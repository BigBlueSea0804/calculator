import PencilKit
import SwiftUI

struct MathNotesView: View {
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("Math Notes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        canvasView.drawing = PKDrawing()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal)

                CanvasView(canvasView: $canvasView, toolPicker: $toolPicker)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

#Preview {
    MathNotesView()
}
