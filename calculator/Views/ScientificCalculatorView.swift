import SwiftUI

struct ScientificCalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    @State private var showHistory = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    // Result Display
                    HStack {
                        Button(action: { showHistory = true }) {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                        .sheet(isPresented: $showHistory) {
                            HistoryView(viewModel: viewModel, isPresented: $showHistory)
                        }

                        Spacer()
                        Text(viewModel.value)
                            .bold()
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                    }
                    .padding()

                    // Buttons
                    ForEach(viewModel.scientificButtons, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { item in
                                Button(
                                    action: {
                                        viewModel.didTap(button: item)
                                    },
                                    label: {
                                        Text(item.rawValue)
                                            .font(.system(size: 20))
                                            .frame(
                                                width: viewModel.buttonWidth(
                                                    item: item, screenWidth: geometry.size.width,
                                                    isScientific: true),
                                                height: viewModel.buttonHeight(
                                                    screenWidth: geometry.size.width,
                                                    isScientific: true)
                                            )
                                            .background(viewModel.buttonBackgroundColor(item: item))
                                            .foregroundColor(viewModel.buttonTextColor(item: item))
                                            .cornerRadius(
                                                viewModel.buttonWidth(
                                                    item: item, screenWidth: geometry.size.width,
                                                    isScientific: true) / 2)
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
    ScientificCalculatorView(viewModel: CalculatorViewModel())
}
