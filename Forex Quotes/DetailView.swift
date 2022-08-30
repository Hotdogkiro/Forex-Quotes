//
//  DetailView.swift
//  Forex Quotes
//
//  Created by Dominik Helbling on 26.11.21.
//

import SwiftUI

struct DetailView: View {
    @Binding var currencyPair: CurrencyPair
    let defaults = UserDefaults.standard
    let apiKey: String
    var body: some View {
        LineChart(currencyPair: $currencyPair, padding: UIScreen.screenWidth * 0.1)
   
//            Button {
//                currencyPairs.append(currencyPair)
//                defaults.setCodable(currencyPairs ,forKey: "CurrencyPairs")
//            } label: {
//                Image(systemName: "star")
//            }
        
        Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
            .font(.title)
        Text("\(currencyPair.firstCurrencyName) \(currencyPair.secondCurrencyName)")
            .font(.caption2)
            .onAppear { getDetailedDataFor(currencyPair: currencyPair) }
        
    }
    
    func getDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate)
    }
    
    func filterDetailedDataForClose(historicalData : [String: [String: String]]) -> [Date: Double] {
        var filteredTimedData: [Date: Double] = [:]

        for timedData in historicalData {
            if let dateForTimedDate = getDate(stringDate: timedData.key){
                filteredTimedData[dateForTimedDate] = Double(timedData.value["4. close"] ?? "0") ?? 0
            }
        }
        return filteredTimedData
    }
    
    func getDetailedDataFor(currencyPair: CurrencyPair) {
        if let url = URL(string:
        "https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=\(currencyPair.firstCurrency)&to_symbol=\(currencyPair.secondCurrency)&outputsize=full&apikey=\(apiKey)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let dictionary = json as? [String: Any] {
                            if let historicalData = dictionary["Time Series FX (Daily)"] as? [String: [String: String]]{
                                DispatchQueue.main.async {
                                    self.currencyPair.historicalDataDaily = filterDetailedDataForClose(historicalData: historicalData)
                                }
                                
//                                        let formatter = DateFormatter()
//                                        formatter.dateFormat = "dd-MM-yyyy HH:mm"
//                                        if let datePriceFetchTime = formatter.date(from: priceFetchTime) {
//                                            DispatchQueue.main.async {
//                                                currencyPairs[index].priceFetchTime = datePriceFetchTime
//                                            }
//                                        }
//                                }
//
                                
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
