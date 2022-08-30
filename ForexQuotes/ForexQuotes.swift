//
//  Forex_Widget.swift
//  Forex Widget
//
//  Created by Dominik Helbling on 03.02.22.
//

import WidgetKit
import SwiftUI
import Intents

let apiKey = "B1I1JON12RO63NGV"
let defaults = UserDefaults.standard


struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), currencyPair: WidgetCurrencyPair(firstCurrency: Currency.USD, secondCurrency: Currency.CHF), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), currencyPair: WidgetCurrencyPair(firstCurrency: Currency.USD, secondCurrency: Currency.CHF), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        var currencyPair : WidgetCurrencyPair
        
        switch configuration.CurrencyPairWidget {
        case .cHFGBP:
            currencyPair = WidgetCurrencyPair(firstCurrency: .CHF, secondCurrency: .GBP)
        case .unknown:
            currencyPair = WidgetCurrencyPair(firstCurrency: .CHF, secondCurrency: .USD)
        case .uSDCHF:
            currencyPair = WidgetCurrencyPair(firstCurrency: .USD, secondCurrency: .CHF)
        case .eURGBP:
            currencyPair = WidgetCurrencyPair(firstCurrency: .EUR, secondCurrency: .GBP)
        case .eURCHF:
            currencyPair = WidgetCurrencyPair(firstCurrency: .EUR, secondCurrency: .CHF)
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        getData(currencyPair: currencyPair, completion: { (price) in
            currencyPair.price = price
            
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, currencyPair: currencyPair, configuration: configuration)
                entries.append(entry)
            }
            
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        })
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    var currencyPair: WidgetCurrencyPair
    let configuration: ConfigurationIntent
    var currencyPairFromConfig = {}
}

struct Placeholder : View {
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        DetailViewWidget(currencyPair: WidgetCurrencyPair(firstCurrency: Currency.USD, secondCurrency: Currency.CHF), family: family)
            .redacted(reason: .placeholder)
    }
}

struct Forex_WidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily

    var entry: Provider.Entry

    var body: some View {
        DetailViewWidget(currencyPair: entry.currencyPair, family: family)
    }
}

@main
struct Forex_Widget: Widget {
    let kind: String = "Forex_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Forex_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Currency Pair Price")
        .description("Current rate of a Currency Pair")
    }
}

struct Forex_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Forex_WidgetEntryView(entry: SimpleEntry(date: Date(), currencyPair: WidgetCurrencyPair(firstCurrency: Currency.USD, secondCurrency: Currency.CHF), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

func getData (currencyPair: WidgetCurrencyPair, completion: @escaping (Double) -> ()){
    if let url = URL(string:  "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(currencyPair.firstCurrency)&to_currency=\(currencyPair.secondCurrency)&apikey=\(apiKey)") {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let dictionary = json as? [String: Any] {
                        if let currencyPairJson = dictionary["Realtime Currency Exchange Rate"] as? [String: String]{
                            if let price = currencyPairJson["5. Exchange Rate"] {
                                if let doublePrice = Double(price) {
                                    DispatchQueue.main.async {
                                        print("Fetching Data for \(currencyPair.firstCurrency.rawValue) \(currencyPair.secondCurrency.rawValue) \(doublePrice)")
                                        completion(doublePrice)
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
