import SwiftUI

struct MainView: View {
    @StateObject private var calculatorViewModel = CalculatorViewModel()
    @State private var currentMode: CalculatorMode = .basic
    @State private var showMenu = false
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
                        Image(systemName: "clock.arrow.circlepath")  // User asked for this or clock
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color(UIColor.darkGray))
                            .clipShape(Circle())
                    }

                    Spacer()

                    // Mode Button (Top-Trailing)
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "calculator")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color(UIColor.darkGray))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 40)  // Adjust for safe area
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

            // Custom Menu Overlay
            if showMenu {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }

                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(CalculatorMode.allCases, id: \.self) { mode in
                            Button(action: {
                                currentMode = mode
                                withAnimation {
                                    showMenu = false
                                }
                            }) {
                                HStack {
                                    Image(systemName: mode.iconName)
                                        .frame(width: 30)
                                    Text(mode.rawValue)
                                        .fontWeight(.medium)
                                }
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 250)
                    .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                    .edgesIgnoringSafeArea(.bottom)

                    Spacer()
                }
                .transition(.move(edge: .leading))
                .zIndex(2)
            }
        }
    }
}

#Preview {
    MainView()
}
