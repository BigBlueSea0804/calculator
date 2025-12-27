import SwiftUI

struct ConverterView: View {
    @StateObject private var viewModel = ConverterViewModel()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Converter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                Picker("Type", selection: $viewModel.selectedType) {
                    ForEach(ConversionType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

                HStack {
                    VStack {
                        Text("Input")
                            .foregroundColor(.gray)
                        TextField("0", text: $viewModel.inputValue)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)

                        Picker("Input Unit", selection: $viewModel.inputUnit) {
                            ForEach(viewModel.selectedType.units) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Image(systemName: "arrow.right")
                        .foregroundColor(.gray)

                    VStack {
                        Text("Output")
                            .foregroundColor(.gray)
                        Text(viewModel.outputValue.isEmpty ? "0" : viewModel.outputValue)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)

                        Picker("Output Unit", selection: $viewModel.outputUnit) {
                            ForEach(viewModel.selectedType.units) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()

                Spacer()
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    ConverterView()
}
