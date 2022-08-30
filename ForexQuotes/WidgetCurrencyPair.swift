//
//  WidgetCurrencyPair.swift
//  ForexQuotesExtension
//
//  Created by Dominik Helbling on 14.02.22.
//

import Foundation


struct WidgetCurrencyPair {
    
    var firstCurrency: Currency
    var secondCurrency: Currency
    var firstCurrencyName: String { currencies[firstCurrency] ?? "" }
    var secondCurrencyName: String { currencies[secondCurrency] ?? "" }
    var price: Double?

    init(firstCurrency: Currency, secondCurrency: Currency){
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
    }
}
