import Foundation

enum CalculatorMode: String, CaseIterable {
    case basic = "기본"
    case scientific = "공학용"
    case mathNotes = "수학 메모"
    case converter = "변환"

    var iconName: String {
        switch self {
        case .basic: return "plus.forwardslash.minus"
        case .scientific: return "function"
        case .mathNotes: return "scribble.variable"
        case .converter: return "arrow.triangle.2.circlepath"
        }
    }
}
