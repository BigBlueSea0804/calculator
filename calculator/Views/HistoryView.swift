import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            // Background is handled by MainView for glass effect
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Button(action: {
                        // Edit action placeholder
                    }) {
                        Text("편집")
                            .foregroundColor(.white)
                            .font(.body)
                    }
                    .padding()

                    Spacer()

                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .padding()
                            .background(Color(white: 0.3))  // Circle background for X
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                }
                .padding(.top, 10)

                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if !viewModel.history.isEmpty {
                            Text("이전 7일")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.leading)
                                .padding(.top, 10)

                            ForEach(viewModel.history.reversed()) { item in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.expression)
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                    Text(item.result)
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)

                                Divider()
                                    .background(Color.gray.opacity(0.3))
                                    .padding(.leading)
                            }
                        } else {
                            Text("기록 없음")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top, 50)
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
