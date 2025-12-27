import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                if viewModel.history.isEmpty {
                    Text("No History")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(viewModel.history.reversed()) { item in
                            VStack(alignment: .trailing, spacing: 5) {
                                Text(item.expression)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("= " + item.result)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical, 5)
                            .listRowBackground(Color.black)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    isPresented = false
                })
        }
        .preferredColorScheme(.dark)
    }
}
