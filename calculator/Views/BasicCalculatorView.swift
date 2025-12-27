import SwiftUI

struct BasicCalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
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

#Preview {
    BasicCalculatorView(viewModel: CalculatorViewModel())
}
