import Darwin
import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var value = "0"
    @Published var previousNumber: Double = 0
    @Published var currentOperation: CalcButton? = nil
    @Published var isTyping = false
    @Published var history: [HistoryItem] = []

    let buttons: [[CalcButton]] = [
        [.delete, .clear, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.negative, .zero, .decimal, .equal],
    ]

    // Scientific layout could be different, so let's define it separately or combine
    let scientificButtons: [[CalcButton]] = [
        [.sin, .cos, .tan, .log, .ln],
        [.sqrt, .power, .factorial, .pi, .clear],
        [.seven, .eight, .nine, .multiply, .divide],
        [.four, .five, .six, .add, .subtract],
        [.one, .two, .three, .percent, .equal],
        [.zero, .decimal, .negative, .delete],
    ]

    func buttonBackgroundColor(item: CalcButton) -> Color {
        if item == currentOperation {
            return .white
        }
        return item.buttonColor
    }

    func buttonTextColor(item: CalcButton) -> Color {
        if item == currentOperation {
            return .orange
        }
        return item.textColor
    }

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .power:
            self.currentOperation = button
            self.previousNumber = Double(self.value) ?? 0
            self.isTyping = false

        case .equal:
            let currentValue = Double(self.value) ?? 0
            let result = calculate(
                operation: currentOperation, prev: previousNumber, current: currentValue)

            if result.truncatingRemainder(dividingBy: 1) == 0 {
                self.value = "\(Int(result))"
            } else {
                self.value = "\(result)"
            }

            // Add to history
            let opSymbol = currentOperation?.rawValue ?? ""
            let historyItem = HistoryItem(
                expression:
                    "\(formatResult(previousNumber)) \(opSymbol) \(formatResult(currentValue))",
                result: self.value)
            history.append(historyItem)

            self.currentOperation = nil
            self.previousNumber = 0

        case .clear:
            self.value = "0"
            self.previousNumber = 0
            self.currentOperation = nil
            self.isTyping = false

        case .delete:
            if value.count > 1 {
                value.removeLast()
            } else {
                value = "0"
                isTyping = false
            }

        case .negative:
            if let currentValue = Double(value) {
                let newValue = currentValue * -1
                if newValue.truncatingRemainder(dividingBy: 1) == 0 {
                    self.value = "\(Int(newValue))"
                } else {
                    self.value = "\(newValue)"
                }
            }

        case .percent:
            if let currentValue = Double(value) {
                let newValue = currentValue / 100
                self.value = "\(newValue)"
            }

        case .decimal:
            if !self.value.contains(".") {
                self.value += "."
                self.isTyping = true
            }

        // Single operand operations
        case .sin:
            if let v = Double(value) { self.value = formatResult(sin(v * .pi / 180)) }  // Degree mode
        case .cos:
            if let v = Double(value) { self.value = formatResult(cos(v * .pi / 180)) }
        case .tan:
            if let v = Double(value) { self.value = formatResult(tan(v * .pi / 180)) }
        case .log:
            if let v = Double(value) { self.value = formatResult(log10(v)) }
        case .ln:
            if let v = Double(value) { self.value = formatResult(log(v)) }
        case .sqrt:
            if let v = Double(value) { self.value = formatResult(sqrt(v)) }
        case .pi:
            self.value = formatResult(Double.pi)
            self.isTyping = false
        case .factorial:
            if let v = Int(value), v >= 0 {
                self.value = "\(factorial(v))"
            }

        default:
            let number = button.rawValue
            if isTyping {
                if value == "0" && number != "." {
                    self.value = number
                } else {
                    self.value = "\(self.value)\(number)"
                }
            } else {
                self.value = number
                self.isTyping = true
            }
        }
    }

    func calculate(operation: CalcButton?, prev: Double, current: Double) -> Double {
        guard let operation = operation else { return current }

        switch operation {
        case .add: return prev + current
        case .subtract: return prev - current
        case .multiply: return prev * current
        case .divide: return prev / current
        case .power: return pow(prev, current)
        default: return current
        }
    }

    private func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(result))"
        }
        return "\(result)"
    }

    private func factorial(_ n: Int) -> Int {
        if n == 0 { return 1 }
        return n * factorial(n - 1)
    }

    func buttonWidth(item: CalcButton, screenWidth: CGFloat, isScientific: Bool = false) -> CGFloat
    {
        if isScientific {
            return (screenWidth - (6 * 10)) / 5  // 5 cols
        }
        if item == .zero {
            return ((screenWidth - (5 * 12)) / 4)
        }
        return (screenWidth - (5 * 12)) / 4
    }

    func buttonHeight(screenWidth: CGFloat, isScientific: Bool = false) -> CGFloat {
        if isScientific {
            return (screenWidth - (6 * 10)) / 5  // 5 cols
        }
        return (screenWidth - (5 * 12)) / 4
    }
}
