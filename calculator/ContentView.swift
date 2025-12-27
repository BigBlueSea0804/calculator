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

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .delete, .clear, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0, alpha: 1))
        }
    }

    var textColor: Color {
        switch self {
        case .delete, .clear, .percent:
            return .black
        default:
            return .white
        }
    }
}

struct ContentView: View {

    @State private var value = "0"
    @State private var previousNumber: Double = 0
    @State private var currentOperation: CalcButton? = nil
    @State private var isTyping = false

    let buttons: [[CalcButton]] = [
        [.delete, .clear, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.negative, .zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Result Display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .padding()

                // Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(
                                action: {
                                    self.didTap(button: item)
                                },
                                label: {
                                    Group {
                                        if item == .delete {
                                            Image(systemName: "delete.left")
                                                .font(.system(size: 32))
                                        } else {
                                            Text(item.rawValue)
                                                .font(.system(size: 32))
                                        }
                                    }
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(self.buttonBackgroundColor(item: item))
                                    .foregroundColor(self.buttonTextColor(item: item))
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                                })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

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
        case .add, .subtract, .multiply, .divide:
            self.currentOperation = button
            self.previousNumber = Double(self.value) ?? 0
            self.isTyping = false
        case .equal:
            let currentValue = Double(self.value) ?? 0
            let result = calculate(
                operation: currentOperation, prev: previousNumber, current: currentValue)

            // Format result to remove decimal if integer
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                self.value = "\(Int(result))"
            } else {
                self.value = "\(result)"
            }
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
            // Prevent multiple decimals
            if !self.value.contains(".") {
                self.value += "."
                self.isTyping = true
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
        case .add:
            return prev + current
        case .subtract:
            return prev - current
        case .multiply:
            return prev * current
        case .divide:
            return prev / current
        default:
            return current
        }
    }

    func buttonWidth(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}
