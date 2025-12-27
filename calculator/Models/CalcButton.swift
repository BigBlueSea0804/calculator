import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    case delete = "delete"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case log = "log"
    case ln = "ln"
    case sqrt = "√"
    case pi = "π"
    case power = "^"
    case factorial = "!"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .delete, .clear, .percent:
            return Color(.lightGray)
        case .sin, .cos, .tan, .log, .ln, .sqrt, .pi, .power, .factorial:
            return Color(red: 40 / 255, green: 40 / 255, blue: 40 / 255)
        default:
            return Color(red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0)
        }
    }

    var textColor: Color {
        switch self {
        case .delete, .clear, .percent:
            return .black
        case .sin, .cos, .tan, .log, .ln, .sqrt, .pi, .power, .factorial:
            return .white
        default:
            return .white
        }
    }
}
