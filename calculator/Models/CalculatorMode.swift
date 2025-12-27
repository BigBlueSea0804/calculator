import Foundation

enum CalculatorMode: String, CaseIterable {
    case basic = "Basic"
    case scientific = "Scientific"
    case mathNotes = "Math Notes"
    case converter = "Converter"

    var iconName: String {
        switch self {
        case .basic: return "number.square"
        case .scientific: return "function"
        case .mathNotes: return "pencil.and.scribble"
        case .converter: return "arrow.triangle.2.circlepath"
        }
    }
}
