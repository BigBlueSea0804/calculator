import SwiftUI

struct MainView: View {
    @StateObject private var calculatorViewModel = CalculatorViewModel()
    @State private var currentMode: CalculatorMode = .basic
    @State private var showMenu = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Header with Menu Button
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "line.3.horizontal")
                            Text(currentMode.rawValue)
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 40)  // Adjust for safe area
                .zIndex(1)

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
