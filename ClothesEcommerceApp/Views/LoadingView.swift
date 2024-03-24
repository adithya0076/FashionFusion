import SwiftUI

struct LoadingScreenView: View {
    var body: some View {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .padding()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                
                Spacer()
            }
        }
}

#Preview {
    LoadingScreenView()
}
