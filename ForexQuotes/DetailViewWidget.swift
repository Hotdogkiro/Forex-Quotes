//
//  DetailViewWidget.swift
//  Forex WidgetExtension
//
//  Created by Dominik Helbling on 13.02.22.
//

import SwiftUI
import WidgetKit

struct DetailViewWidget: View {
    @State var currencyPair: WidgetCurrencyPair
    @State var family: WidgetFamily
    
    var body: some View {
//           LineChart(currencyPair: $currencyPair, padding: UIScreen.screenWidth * 0.1)
   
//            Button {
//                currencyPairs.append(currencyPair)
//                defaults.setCodable(currencyPairs ,forKey: "CurrencyPairs")
//            } label: {
//                Image(systemName: "star")
//            }
        switch(family) {
            case .systemSmall:
            HStack{
                VStack{
                    Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                        .font(.title3)
                    Text("""
                         \(currencyPair.firstCurrencyName)
                         \(currencyPair.secondCurrencyName)
    """)
                        .font(.caption2)
                }
                    //.onAppear { getDetailedDataFor(currencyPair: currencyPair) }
                Text("\(String(format: "%.4f", currencyPair.price ?? 0.0))")
                    .font(.title3)
            }
        case .systemMedium:
            HStack{
                VStack{
                    Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                        .font(.title2)
                    Text("\(currencyPair.firstCurrencyName) | \(currencyPair.secondCurrencyName)")
                        .font(.caption)
                }
                    //.onAppear { getDetailedDataFor(currencyPair: currencyPair) }
                Text("\(String(format: "%.4f", currencyPair.price ?? 0.0))")
                    .font(.title2)
            }
        case .systemLarge:
            HStack{
                VStack{
                    Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                        .font(.title)
                    Text("\(currencyPair.firstCurrencyName) | \(currencyPair.secondCurrencyName)")
                        .font(.caption)
                }
                    //.onAppear { getDetailedDataFor(currencyPair: currencyPair) }
                Text("\(String(format: "%.4f", currencyPair.price ?? 0.0))")
                    .font(.title)
            }
        case .systemExtraLarge:
            HStack{
                VStack{
                    Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                        .font(.title3)
                    Text("\(currencyPair.firstCurrencyName) \(currencyPair.secondCurrencyName)")
                        .font(.caption2)
                }
                    //.onAppear { getDetailedDataFor(currencyPair: currencyPair) }
                Text("\(String(format: "%.4f", currencyPair.price ?? 0.0))")
                    .font(.title3)
            }
        @unknown default:
            HStack{
                VStack{
                    Text("\(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue)")
                        .font(.title3)
                    Text("""
                         \(currencyPair.firstCurrencyName)
                         \(currencyPair.secondCurrencyName)
    """)
                        .font(.caption2)
                }
                    //.onAppear { getDetailedDataFor(currencyPair: currencyPair) }
                Text("\(String(format: "%.4f", currencyPair.price ?? 0.0))")
                    .font(.title3)
            }
        }
    }
}



struct DetailViewWidget_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewWidget(currencyPair: WidgetCurrencyPair(firstCurrency: .CHF, secondCurrency: .EUR), family: .systemMedium).previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
