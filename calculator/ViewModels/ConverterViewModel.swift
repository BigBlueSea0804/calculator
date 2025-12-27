import Combine
import Foundation

class ConverterViewModel: ObservableObject {
    @Published var selectedType: ConversionType = .length {
        didSet {
            inputUnit = selectedType.units.first!
            outputUnit =
                selectedType.units.count > 1 ? selectedType.units[1] : selectedType.units.first!
            convert()
        }
    }

    @Published var inputUnit: UnitType = .meters { didSet { convert() } }
    @Published var outputUnit: UnitType = .feet { didSet { convert() } }
    @Published var inputValue: String = "" { didSet { convert() } }
    @Published var outputValue: String = ""

    func convert() {
        guard let value = Double(inputValue) else {
            outputValue = ""
            return
        }

        let baseValue = toBase(value: value, unit: inputUnit)
        let result = fromBase(value: baseValue, unit: outputUnit)

        outputValue = String(format: "%.4f", result)
    }

    private func toBase(value: Double, unit: UnitType) -> Double {
        switch unit {
        case .meters: return value
        case .kilometers: return value * 1000
        case .feet: return value * 0.3048
        case .miles: return value * 1609.34
        case .inches: return value * 0.0254
        case .centimeters: return value * 0.01

        case .kilograms: return value
        case .grams: return value * 0.001
        case .pounds: return value * 0.453592
        case .ounces: return value * 0.0283495

        case .celsius: return value
        case .fahrenheit: return (value - 32) * 5 / 9
        case .kelvin: return value - 273.15

        case .usd: return value
        case .eur: return value * 1.1
        case .krw: return value * 0.00075
        case .jpy: return value * 0.0067
        }
    }

    private func fromBase(value: Double, unit: UnitType) -> Double {
        switch unit {
        case .meters: return value
        case .kilometers: return value / 1000
        case .feet: return value / 0.3048
        case .miles: return value / 1609.34
        case .inches: return value / 0.0254
        case .centimeters: return value / 0.01

        case .kilograms: return value
        case .grams: return value / 0.001
        case .pounds: return value / 0.453592
        case .ounces: return value / 0.0283495

        case .celsius: return value
        case .fahrenheit: return (value * 9 / 5) + 32
        case .kelvin: return value + 273.15

        case .usd: return value
        case .eur: return value / 1.1
        case .krw: return value / 0.00075
        case .jpy: return value / 0.0067
        }
    }
}
