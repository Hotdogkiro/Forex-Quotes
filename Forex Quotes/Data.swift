//
//  Data.swift
//  Forex Quotes
//
//  Created by Dominik Helbling on 25.11.21.
//

import Foundation
import SwiftUI

struct CurrencyPair: Identifiable, Hashable, Comparable, Codable{
    static func < (lhs: CurrencyPair, rhs: CurrencyPair) -> Bool {
        return lhs < rhs
    }
    
    static func == (lhs: CurrencyPair, rhs: CurrencyPair) -> Bool {
        return lhs.firstCurrency == rhs.firstCurrency && lhs.secondCurrency == rhs.secondCurrency
    }
    
    let id = UUID()
    var firstCurrency: Currency
    var secondCurrency: Currency
    var firstCurrencyName: String { currencies[firstCurrency] ?? "" }
    var secondCurrencyName: String { currencies[secondCurrency] ?? "" }
    var price: Double?
    var priceFetchTime: Date?
    var historicalDataDaily: [Date: Double]?
    var historicalDataDailyFetchTime: Date?
    var historicalDataInterday: [Date: Double]?
    var historicalDataInterdayFetchTime: Date?


//    var priceOpen: Double
//    var priceClose: Double
//    var dailyChange: Double
//    var winning: Bool
    init(firstCurrency: Currency, secondCurrency: Currency){
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
    }
    
//    enum CodingKeys: String, CodingKey {
//        case price = "5. Exchange Rate"
//        case priceFetchTime = ""
//        case price = "5. Exchange Rate"
//    }

}

enum TimeFrame: String {
    case OneDay
    case FiveDays
    case OneMonth
    case SixMonths
    case YearToDate
    case OneYear
    case FiveYears
}

enum Currency : String, Decodable, CaseIterable, Encodable {
    case AED
    case AFN
    case ALL
    case AMD
    case ANG
    case AOA
    case ARS
    case AUD
    case AWG
    case AZN
    case BAM
    case BBD
    case BDT
    case BGN
    case BHD
    case BIF
    case BMD
    case BND
    case BOB
    case BRL
    case BSD
    case BTN
    case BWP
    case BZD
    case CAD
    case CDF
    case CHF
    case CLF
    case CLP
    case CNH
    case CNY
    case COP
    case CUP
    case CVE
    case CZK
    case DJF
    case DKK
    case DOP
    case DZD
    case EGP
    case ERN
    case ETB
    case EUR
    case FJD
    case FKP
    case GBP
    case GEL
    case GHS
    case GIP
    case GMD
    case GNF
    case GTQ
    case GYD
    case HKD
    case HNL
    case HRK
    case HTG
    case HUF
    case ICP
    case IDR
    case ILS
    case INR
    case IQD
    case IRR
    case ISK
    case JEP
    case JMD
    case JOD
    case JPY
    case KES
    case KGS
    case KHR
    case KMF
    case KPW
    case KRW
    case KWD
    case KYD
    case KZT
    case LAK
    case LBP
    case LKR
    case LRD
    case LSL
    case LYD
    case MAD
    case MDL
    case MGA
    case MKD
    case MMK
    case MNT
    case MOP
    case MRO
    case MRU
    case MUR
    case MVR
    case MWK
    case MXN
    case MYR
    case MZN
    case NAD
    case NGN
    case NOK
    case NPR
    case NZD
    case OMR
    case PAB
    case PEN
    case PGK
    case PHP
    case PKR
    case PLN
    case PYG
    case QAR
    case RON
    case RSD
    case RUB
    case RUR
    case RWF
    case SAR
    //case SBDf
    case SCR
    case SDG
    case SDR
    case SEK
    case SGD
    //case SHIB
    case SHP
    case SLL
    case SOS
    case SRD
    case SYP
    case SZL
    case THB
    case TJS
    case TMT
    case TND
    case TOP
    case TRY
    case TTD
    case TWD
    case TZS
    case UAH
    case UGX
    case USD
    case UYU
    case UZS
    case VND
    case VUV
    //case WBTC
    case WST
    case XAF
    case XCD
    case XDR
    case XOF
    case XPF
    case YER
    case ZAR
    case ZMW
    case ZWL
    
//    var fullName: String {
//        switch self {
//
//        }
//    }
}

var currencies: [Currency: String] = [
    Currency.AED  : "United Arab Emirates Dirham",
//    Currency.AFN  : "Afghan Afghani",
    Currency.ALL  : "Albanian Lek",
    Currency.AMD  : "Armenian Dram",
    Currency.ANG  : "Netherlands Antillean Guilder",
    Currency.AOA  : "Angolan Kwanza",
    Currency.ARS  : "Argentine Peso",
    Currency.AUD  : "Australian Dollar",
    Currency.AWG  : "Aruban Florin",
    Currency.AZN  : "Azerbaijani Manat",
    Currency.BAM  : "Bosnia-Herzegovina Convertible Mark",
    Currency.BBD  : "Barbadian Dollar",
    Currency.BDT  : "Bangladeshi Taka",
    Currency.BGN  : "Bulgarian Lev",
    Currency.BHD  : "Bahraini Dinar",
    Currency.BIF  : "Burundian Franc",
    Currency.BMD  : "Bermudan Dollar",
    Currency.BND  : "Brunei Dollar",
    Currency.BOB  : "Bolivian Boliviano",
    Currency.BRL  : "Brazilian Real",
    Currency.BSD  : "Bahamian Dollar",
    Currency.BTN  : "Bhutanese Ngultrum",
    Currency.BWP  : "Botswanan Pula",
    Currency.BZD  : "Belize Dollar",
    Currency.CAD  : "Canadian Dollar",
    Currency.CDF  : "Congolese Franc",
    Currency.CHF  : "Swiss Franc",
    Currency.CLF  : "Chilean Unit of Account UF",
    Currency.CLP  : "Chilean Peso",
    Currency.CNH  : "Chinese Yuan Offshore",
    Currency.CNY  : "Chinese Yuan",
    Currency.COP  : "Colombian Peso",
    Currency.CUP  : "Cuban Peso",
    Currency.CVE  : "Cape Verdean Escudo",
    Currency.CZK  : "Czech Republic Koruna",
    Currency.DJF  : "Djiboutian Franc",
    Currency.DKK  : "Danish Krone",
    Currency.DOP  : "Dominican Peso",
    Currency.DZD  : "Algerian Dinar",
    Currency.EGP  : "Egyptian Pound",
    Currency.ERN  : "Eritrean Nakfa",
    Currency.ETB  : "Ethiopian Birr",
    Currency.EUR  : "Euro",
    Currency.FJD  : "Fijian Dollar",
    Currency.FKP  : "Falkland Islands Pound",
    Currency.GBP  : "British Pound Sterling",
    Currency.GEL  : "Georgian Lari",
    Currency.GHS  : "Ghanaian Cedi",
    Currency.GIP  : "Gibraltar Pound",
    Currency.GMD  : "Gambian Dalasi",
    Currency.GNF  : "Guinean Franc",
    Currency.GTQ  : "Guatemalan Quetzal",
    Currency.GYD  : "Guyanaese Dollar",
    Currency.HKD  : "Hong Kong Dollar",
    Currency.HNL  : "Honduran Lempira",
    Currency.HRK  : "Croatian Kuna",
    Currency.HTG  : "Haitian Gourde",
    Currency.HUF  : "Hungarian Forint",
    Currency.ICP  : "Internet Computer",
    Currency.IDR  : "Indonesian Rupiah",
    Currency.ILS  : "Israeli New Sheqel",
    Currency.INR  : "Indian Rupee",
    Currency.IQD  : "Iraqi Dinar",
    Currency.IRR  : "Iranian Rial",
    Currency.ISK  : "Icelandic Krona",
    Currency.JEP  : "Jersey Pound",
    Currency.JMD  : "Jamaican Dollar",
    Currency.JOD  : "Jordanian Dinar",
    Currency.JPY  : "Japanese Yen",
    Currency.KES  : "Kenyan Shilling",
    Currency.KGS  : "Kyrgystani Som",
    Currency.KHR  : "Cambodian Riel",
    Currency.KMF  : "Comorian Franc",
    Currency.KPW  : "North Korean Won",
    Currency.KRW  : "South Korean Won",
    Currency.KWD  : "Kuwaiti Dinar",
    Currency.KYD  : "Cayman Islands Dollar",
    Currency.KZT  : "Kazakhstani Tenge",
    Currency.LAK  : "Laotian Kip",
    Currency.LBP  : "Lebanese Pound",
    Currency.LKR  : "Sri Lankan Rupee",
    Currency.LRD  : "Liberian Dollar",
    Currency.LSL  : "Lesotho Loti",
    Currency.LYD  : "Libyan Dinar",
    Currency.MAD  : "Moroccan Dirham",
    Currency.MDL  : "Moldovan Leu",
    Currency.MGA  : "Malagasy Ariary",
    Currency.MKD  : "Macedonian Denar",
    Currency.MMK  : "Myanma Kyat",
    Currency.MNT  : "Mongolian Tugrik",
    Currency.MOP  : "Macanese Pataca",
    Currency.MRO  : "Mauritanian Ouguiya (pre-2018)",
    Currency.MRU  : "Mauritanian Ouguiya",
    Currency.MUR  : "Mauritian Rupee",
    Currency.MVR  : "Maldivian Rufiyaa",
    Currency.MWK  : "Malawian Kwacha",
    Currency.MXN  : "Mexican Peso",
    Currency.MYR  : "Malaysian Ringgit",
    Currency.MZN  : "Mozambican Metical",
    Currency.NAD  : "Namibian Dollar",
    Currency.NGN  : "Nigerian Naira",
    Currency.NOK  : "Norwegian Krone",
    Currency.NPR  : "Nepalese Rupee",
    Currency.NZD  : "New Zealand Dollar",
    Currency.OMR  : "Omani Rial",
    Currency.PAB  : "Panamanian Balboa",
    Currency.PEN  : "Peruvian Nuevo Sol",
    Currency.PGK  : "Papua New Guinean Kina",
    Currency.PHP  : "Philippine Peso",
    Currency.PKR  : "Pakistani Rupee",
    Currency.PLN  : "Polish Zloty",
    Currency.PYG  : "Paraguayan Guarani",
    Currency.QAR  : "Qatari Rial",
    Currency.RON  : "Romanian Leu",
    Currency.RSD  : "Serbian Dinar",
    Currency.RUB  : "Russian Ruble",
    Currency.RUR  : "Old Russian Ruble",
    Currency.RWF  : "Rwandan Franc",
    Currency.SAR  : "Saudi Riyal",
    //Currency.SBDf : "Solomon Islands Dollar",
    Currency.SCR  : "Seychellois Rupee",
    Currency.SDG  : "Sudanese Pound",
    Currency.SDR  : "Special Drawing Rights",
    Currency.SEK  : "Swedish Krona",
    Currency.SGD  : "Singapore Dollar",
    //Currency.SHIB : "Shiba Inu",
    Currency.SHP  : "Saint Helena Pound",
    Currency.SLL  : "Sierra Leonean Leone",
    Currency.SOS  : "Somali Shilling",
    Currency.SRD  : "Surinamese Dollar",
    Currency.SYP  : "Syrian Pound",
    Currency.SZL  : "Swazi Lilangeni",
    Currency.THB  : "Thai Baht",
    Currency.TJS  : "Tajikistani Somoni",
    Currency.TMT  : "Turkmenistani Manat",
    Currency.TND  : "Tunisian Dinar",
    Currency.TOP  : "Tongan Pa'anga",
    Currency.TRY  : "Turkish Lira",
    Currency.TTD  : "Trinidad and Tobago Dollar",
    Currency.TWD  : "New Taiwan Dollar",
    Currency.TZS  : "Tanzanian Shilling",
    Currency.UAH  : "Ukrainian Hryvnia",
    Currency.UGX  : "Ugandan Shilling",
    Currency.USD  : "United States Dollar",
    Currency.UYU  : "Uruguayan Peso",
    Currency.UZS  : "Uzbekistan Som",
    Currency.VND  : "Vietnamese Dong",
    Currency.VUV  : "Vanuatu Vatu",
    //Currency.WBTC : "Wrapped Bitcoin",
    Currency.WST  : "Samoan Tala",
    Currency.XAF  : "CFA Franc BEAC",
    Currency.XCD  : "East Caribbean Dollar",
    Currency.XDR  : "Special Drawing Rights",
    Currency.XOF  : "CFA Franc BCEAO",
    Currency.XPF  : "CFP Franc",
    Currency.YER  : "Yemeni Rial",
    Currency.ZAR  : "South African Rand",
    Currency.ZMW  : "Zambian Kwacha",
    Currency.ZWL  : "Zimbabwean Dollar"
]

public extension View {
    func debugColorView() -> some View {
        self.background(
            Color(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1)
            )
        )
    }
}

extension UserDefaults {
  func setCodable<T: Codable>(_ value: T, forKey key: String) {
    guard let data = try? JSONEncoder().encode(value) else {
      fatalError("Cannot create a json representation of \(value)")
    }
    self.set(data, forKey: key)
  }
    
  func codable<T: Codable>(forKey key: String) -> T? {
    guard let data = self.data(forKey: key) else {
      return nil
    }
    return try? JSONDecoder().decode(T.self, from: data)
  }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
