//
//  ContentView.swift
//  Forex Quotes
//
//  Created by Dominik Helbling on 24.11.21.
//

import SwiftUI

struct CurrencyPairs: View {
    @Binding var currencyPairs: [CurrencyPair]
    @Environment(\.editMode) private var editMode
    @State var priceIsVisible: Bool = true
    let defaults = UserDefaults.standard
    let apiKey: String
    
    @ViewBuilder
    var body: some View {
            List {
                ForEach($currencyPairs) { $currencyPair in
                    HStack(){
                        if editMode?.wrappedValue == .inactive {
                        NavigationLink {
                            DetailView(currencyPair: $currencyPair, apiKey: apiKey)
                        } label: {
                            HStack{
                                Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                                    .font(.footnote)
                                Text("\(currencyPair.firstCurrencyName)\n\(currencyPair.secondCurrencyName)")
                                    .font(.caption2)
                                    VStack{
                                        Text("\(String(format: "%.4f", currencyPair.price ?? 0.0))")
                                            .font(.title)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                        
    //                                    Maybe add later to show user, when prices where fetched the last time
                                        
    //                                    Text("\(currencyPair.priceFetchTime ?? Date())")
    //                                        .font(.caption2)
    //                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                            }
                        }
                        else {
                            HStack{
                                Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                                    .font(.footnote)
                                Text("\(currencyPair.firstCurrencyName)\n\(currencyPair.secondCurrencyName)")
                                    .font(.caption2)
                                }
                            
                        }
                    }
                }
                //.onDelete { self.deleteCurrencyPair(at :$0) }
                //.onMove { self.moveCurrencyPair(from: $0, to: $1) }
            }

        .onAppear{
            setup()
        }
    }
    func deleteCurrencyPair(at: IndexSet){
        currencyPairs.remove(atOffsets: at)
        defaults.setCodable(currencyPairs ,forKey: "CurrencyPairs")
    }
    func moveCurrencyPair(from: IndexSet, to: Int){
        currencyPairs.move(fromOffsets: from, toOffset: to)
        defaults.setCodable(currencyPairs ,forKey: "CurrencyPairs")
    }
    func setup(){
    }
}

