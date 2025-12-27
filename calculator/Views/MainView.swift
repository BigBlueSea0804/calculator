import SwiftUI

struct MainView: View {
    @StateObject private var calculatorViewModel = CalculatorViewModel()
    @State private var currentMode: CalculatorMode = .basic
    @State private var showHistory = false
    @State private var selectedDetent: PresentationDetent = .medium

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Header with History and Menu Buttons
                HStack {
                    // History Button (Top-Leading)
                    Button(action: {
                        showHistory = true
                    }) {
                        Image(systemName: "clock")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color(UIColor.darkGray))
                            .clipShape(Circle())
                    }

                    Spacer()

                    // Mode Menu (Top-Trailing)
                    Menu {
                        ForEach(CalculatorMode.allCases, id: \.self) { mode in
                            if mode == .converter {
                                Divider()
                            }

                            Button(action: {
                                currentMode = mode
                            }) {
                                HStack {
                                    Text(mode.rawValue)
                                    if currentMode == mode {
                                        Image(systemName: "checkmark")
                                    }
                                    Image(systemName: mode.iconName)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "function")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color(UIColor.darkGray))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)  // Reduced padding to move buttons up
                .zIndex(1)
                .sheet(isPresented: $showHistory) {
                    HistoryView(viewModel: calculatorViewModel, isPresented: $showHistory)
                        .presentationDetents([.medium, .large], selection: $selectedDetent)
                        .presentationDragIndicator(.visible)
                        .presentationBackground {
                            if selectedDetent == .large {
                                Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255)
                            } else {
                                Rectangle()
                                    .fill(.ultraThinMaterial.opacity(0.6))
                            }
                        }
                }

                // Main Content
                Group {
                    switch currentMode {
                    case .basic:
                        BasicCalculatorView(viewModel: calculatorViewModel)
                    case .scientific:
                        ScientificCalculatorView(viewModel: calculatorViewModel)
                    case .mathNotes:
                        MathNotesView()
                    case .converter:
                        ConverterView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    MainView()
}
