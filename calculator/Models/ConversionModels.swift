import Foundation

enum ConversionType: String, CaseIterable, Identifiable {
    case length = "Length"
    case mass = "Mass"
    case temperature = "Temperature"
    case currency = "Currency"  // Placeholder

    var id: String { self.rawValue }

    var units: [UnitType] {
        switch self {
        case .length:
            return [.meters, .kilometers, .feet, .miles, .inches, .centimeters]
        case .mass:
            return [.kilograms, .grams, .pounds, .ounces]
        case .temperature:
            return [.celsius, .fahrenheit, .kelvin]
        case .currency:
            return [.usd, .eur, .krw, .jpy]
        }
    }
}

enum UnitType: String, CaseIterable, Identifiable {
    // Length
    case meters = "Meters"
    case kilometers = "Kilometers"
    case feet = "Feet"
    case miles = "Miles"
    case inches = "Inches"
    case centimeters = "Centimeters"

    // Mass
    case kilograms = "Kilograms"
    case grams = "Grams"
    case pounds = "Pounds"
    case ounces = "Ounces"

    // Temperature
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"

    // Currency (Simple fixed rates for demo)
    case usd = "USD"
    case eur = "EUR"
    case krw = "KRW"
    case jpy = "JPY"

    var id: String { self.rawValue }
}
