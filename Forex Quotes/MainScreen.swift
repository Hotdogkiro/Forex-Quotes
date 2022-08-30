//
//  ContentView.swift
//  Forex Quotes
//
//  Created by Dominik Helbling on 24.11.21.
//

import SwiftUI


class ViewModel: ObservableObject {
    @Published var currencyPairs: [CurrencyPair] = []
}

@available(iOS 15.0, *)
struct ContentView: View {
    let apiKey = "B1I1JON12RO63NGV"
    @ObservedObject var viewModel = ViewModel()
    @State private var searchText = ""
    @State private var updatedCurrencies: [CurrencyPair] = []
    @State var showSearch: Bool = true
    
    let defaults = UserDefaults.standard
    var body: some View {
        NavigationView{
            CurrencyPairs(currencyPairs: $viewModel.currencyPairs, apiKey: apiKey)
                .navigationTitle("CurrencyPairs")
                .toolbar { EditButton() }
            Spacer()
        }
        .debugColorView()
//        if editMode?.wrappedValue == .inactive {
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)){
                ForEach($updatedCurrencies) { currencyPair in
                    NavigationLink {
                        //DetailView(currencyPair: currencyPair.wrappedValue)
                    } label: {
                        HStack{
                            Text("\(currencyPair.wrappedValue.firstCurrency.rawValue) \(currencyPair.wrappedValue.secondCurrency.rawValue)")
                                .font(.footnote)
                            Text("\(currencyPair.wrappedValue.firstCurrencyName)\n\(currencyPair.wrappedValue.secondCurrencyName)")
                                .font(.caption2)
                            if let indexOfCurreny = viewModel.currencyPairs.firstIndex(of: currencyPair.wrappedValue) {
                                Button {
                                    viewModel.currencyPairs.remove(at: indexOfCurreny)
                                    defaults.setCodable(viewModel.currencyPairs ,forKey: "CurrencyPairs")
                                } label: {
                                    Image(systemName: "star.fill")
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                Button {
                                    viewModel.currencyPairs.append(currencyPair.wrappedValue)
                                    defaults.setCodable(viewModel.currencyPairs ,forKey: "CurrencyPairs")
                                } label: {
                                    Image(systemName: "star")
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
//                }
            }
        }
        .onChange(of: searchText) { newQuery in
            let currencyPairs = matchingCurrencyPairs(searchText: searchText)
            DispatchQueue.main.async {
                updatedCurrencies = currencyPairs
            }
        }
        .onChange(of: viewModel.currencyPairs.count) { newQuery in
            loadData()
        }
        .onAppear{
            setup()
        }
    }
    
    func setup(){
        getCurrencyPairs()
        loadData()
    }
    
    func watchlistButtonTapped(){
        
    }
    
    func getCurrencyPairs() {
        let defaults = UserDefaults.standard
        viewModel.currencyPairs = defaults.codable(forKey: "CurrencyPairs") ?? [] as [CurrencyPair]
    }
    
    func matchingCurrencyPairs(searchText : String) -> [CurrencyPair] {
        var matchingCurrencyPairs: [CurrencyPair] = []
        for firstCurrency in Currency.allCases {
            for secondCurrency in Currency.allCases {
                if firstCurrency != secondCurrency {
                    let filteredSearchText = searchText.replacingOccurrences(of: " ", with: "").lowercased()
                    if filteredSearchText.endIndex < "\(firstCurrency) \(secondCurrency)".endIndex {
                        let comparisionString = "\(firstCurrency)\(secondCurrency)"[filteredSearchText.startIndex..<filteredSearchText.endIndex]
                        if filteredSearchText == comparisionString.lowercased() {
                            matchingCurrencyPairs.append(CurrencyPair(firstCurrency: firstCurrency, secondCurrency: secondCurrency))
                            if matchingCurrencyPairs.count >= 20 { return matchingCurrencyPairs }
                        }
                    }
                }
            }
        }
        return matchingCurrencyPairs
    }
    
    func addCurrencyPair(currencyPair: CurrencyPair) {
        viewModel.currencyPairs.append(currencyPair)
    }
    
    func loadData(){
//        guard let earlyDate = Calendar.current.date(
//            byAdding: .minute,
//            value: -5,
//            to: Date()) else { return }
        for i in 0..<viewModel.currencyPairs.count {
            //if viewModel.currencyPairs[i].priceFetchTime?.distance(to: earlyDate) ?? 100000 >= TimeInterval(5) {
                getDataFor(currencyPair: viewModel.currencyPairs[i], index: i)
            //}
        }
    }
    
    func getDataFor(currencyPair: CurrencyPair, index: Int) {
        if let url = URL(string:  "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(currencyPair.firstCurrency)&to_currency=\(currencyPair.secondCurrency)&apikey=\(apiKey)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let dictionary = json as? [String: Any] {
                            if let currencyPairJson = dictionary["Realtime Currency Exchange Rate"] as? [String: String]{
                                if let price = currencyPairJson["5. Exchange Rate"] {
                                    if let doublePrice = Double(price) {
                                        DispatchQueue.main.async {
                                            viewModel.currencyPairs[index].price = doublePrice
                                            print("Fetching Data for \(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue) \(doublePrice)")
                                        }
                                    }
                                }
                                if let priceFetchTime = currencyPairJson["6. Last Refreshed"] {
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "dd-MM-yyyy HH:mm"
                                    if let datePriceFetchTime = formatter.date(from: priceFetchTime) {
                                        DispatchQueue.main.async {
                                            viewModel.currencyPairs[index].priceFetchTime = datePriceFetchTime
                                        }
                                    }
                                }
                            }
                        }
                    }

                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
        }
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
