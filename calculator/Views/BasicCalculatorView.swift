import SwiftUI

struct BasicCalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack(spacing: 8) {
                    if geometry.size.width > geometry.size.height {
                        // Landscape Layout
                        Spacer()
                        
                        // Result Display
                        HStack {
                            Spacer()
                            Text(viewModel.value)
                                .bold()
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            // Row 1: 7, 8, 9, Backspace, Divide
                            HStack(spacing: 12) {
                                landscapeButton(.seven, geometry: geometry)
                                landscapeButton(.eight, geometry: geometry)
                                landscapeButton(.nine, geometry: geometry)
                                landscapeButton(.delete, geometry: geometry)
                                landscapeButton(.divide, geometry: geometry)
                            }
                            // Row 2: 4, 5, 6, AC, Multiply
                            HStack(spacing: 12) {
                                landscapeButton(.four, geometry: geometry)
                                landscapeButton(.five, geometry: geometry)
                                landscapeButton(.six, geometry: geometry)
                                landscapeButton(.clear, geometry: geometry)
                                landscapeButton(.multiply, geometry: geometry)
                            }
                            // Row 3: 1, 2, 3, %, Subtract
                            HStack(spacing: 12) {
                                landscapeButton(.one, geometry: geometry)
                                landscapeButton(.two, geometry: geometry)
                                landscapeButton(.three, geometry: geometry)
                                landscapeButton(.percent, geometry: geometry)
                                landscapeButton(.subtract, geometry: geometry)
                            }
                            // Row 4: +/-, 0, ., =, Add
                            HStack(spacing: 12) {
                                landscapeButton(.negative, geometry: geometry)
                                landscapeButton(.zero, geometry: geometry)
                                landscapeButton(.decimal, geometry: geometry)
                                landscapeButton(.equal, geometry: geometry)
                                landscapeButton(.add, geometry: geometry)
                            }
                        }
                        .padding(.bottom)
                        
                    } else {
                        // Portrait Layout (Original)
                        Spacer()
                        
                        // Result Display
                        HStack {
                            Spacer()
                            Text(viewModel.value)
                                .bold()
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding()
                        
                        // Buttons
                        ForEach(viewModel.buttons, id: \.self) { row in
                            HStack(spacing: 12) {
                                ForEach(row, id: \.self) { item in
                                    Button(
                                        action: {
                                            viewModel.didTap(button: item)
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
                                            // Pass screen width from geometry reader
                                            .frame(
                                                width: viewModel.buttonWidth(
                                                    item: item, screenWidth: geometry.size.width),
                                                height: viewModel.buttonHeight(
                                                    screenWidth: geometry.size.width)
                                            )
                                            .background(viewModel.buttonBackgroundColor(item: item))
                                            .foregroundColor(viewModel.buttonTextColor(item: item))
                                            .cornerRadius(
                                                viewModel.buttonWidth(
                                                    item: item, screenWidth: geometry.size.width) / 2)
                                        })
                                }
                            }
                            .padding(.bottom, 3)
                        }
                    }
                }
            }
        }
    }
    
    // Helper for landscape buttons
    func landscapeButton(_ item: CalcButton, geometry: GeometryProxy) -> some View {
        Button(action: {
            viewModel.didTap(button: item)
        }) {
            Group {
                if item == .delete {
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                } else if item == .clear {
                    Text("AC") // Maintain AC text label
                        .font(.system(size: 24))
                } else {
                    Text(item.rawValue)
                        .font(.system(size: 24))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(landscapeButtonColor(item))
            .foregroundColor(landscapeButtonTextColor(item))
            .clipShape(Capsule())
        }
        .frame(height: 50) // Fixed height for landscape buttons
    }
    
    // Custom colors for landscape mode as interpreted from the image
    func landscapeButtonColor(_ item: CalcButton) -> Color {
        switch item {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .delete, .clear, .percent:
             // These looked like "light" function buttons in the user's image, but perhaps darker than standard.
             // Standard "light gray" is Color(.lightGray). User image looks slightly darker gray.
             // Let's use a custom gray.
            return Color(UIColor.systemGray)
        default:
            // Numbers and others are dark gray
            return Color(UIColor.darkGray)
        }
    }
    
    func landscapeButtonTextColor(_ item: CalcButton) -> Color {
        return .white
    }
}

#Preview {
    BasicCalculatorView(viewModel: CalculatorViewModel())
}
