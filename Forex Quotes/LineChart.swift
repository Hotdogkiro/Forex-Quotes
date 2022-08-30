//
//  LineChart.swift
//  Forex Quotes
//
//  Created by Dominik Helbling on 26.11.21.
//

import SwiftUI

struct LineChart: View {
    @Binding var currencyPair: CurrencyPair
    @State var timeFrame: TimeFrame = .OneMonth
    @State var padding: CGFloat
    let endDate = Calendar.current.startOfDay(for: Date())
    let calendar = Calendar.current
    let durationOneDay: Double = (24 * 60 * 60)
    var startDate: Date { Calendar.current.date(byAdding: .day, value: -365, to: endDate as Date) ?? Date() }
    var filteredHistoricalDates: [Date] { Array(stride(from: startDate, to: endDate, by: durationOneDay)) }
    var body: some View {
        if currencyPair.historicalDataDaily != nil {
            Text("Works \(filteredHistoricalDates.count)")
            Path { path in
                var filteredHistoricalDataWithWeekends: [Double] = []
                for date in filteredHistoricalDates {
                    print(date)
                    print(currencyPair.historicalDataDaily?[date] ?? 0)
                    var price: Double = 0
                    if currencyPair.historicalDataDaily?[date] != 0.0 {
                        price = currencyPair.historicalDataDaily?[date] ?? 0.0
                    }
                    else {
                        price = currencyPair.historicalDataDaily?[Calendar.current.date(byAdding: .day, value: -1, to: date as Date) ?? date] ?? 0.0
                    }
                    filteredHistoricalDataWithWeekends.append(price)
                }
                let filteredHistoricalData = filteredHistoricalDataWithWeekends.filter { data in return data != 0}
                print(filteredHistoricalData)
                var stepWidth: CGFloat { (UIScreen.screenWidth - (2 * padding)) / CGFloat(filteredHistoricalData.count) }
                var diff: Double = 0
                var scale: Double = 0
                let max = filteredHistoricalData.max()
                let min = filteredHistoricalData.min()
                guard min != nil, max != nil else { return }
                diff = max! - min!
                scale = (((UIScreen.screenWidth - (2 * padding)) / 2) / diff)
                print(((UIScreen.screenWidth - (2 * padding)) / 2))
                print(padding)
                print(diff)
                print(scale)
                
                for (index, data) in filteredHistoricalData.enumerated() {
                    if index == 0 {
                        path.move(to: CGPoint(x: padding, y: (UIScreen.screenWidth * 0.5  + (data - min!) * scale * -1 )))
                    } else {
                        path.addLine(
                            to: CGPoint(x: padding + (stepWidth * CGFloat(index)), y:(UIScreen.screenWidth * 0.5  + (data - min!) * scale * -1 ))
                        )
                    }
                    print("x: \(padding + (stepWidth * CGFloat(index))) y: \((data - min!) * scale))")
                }
            }
            .stroke(.green, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(currencyPair: Binding(get: { CurrencyPair(firstCurrency: Currency.USD, secondCurrency: Currency.CHF) }, set: { _ in }) , padding: UIScreen.screenWidth * 0.1)
    }
}
