import SwiftUI

struct LoadingScreenView: View {
    @State var isActive : Bool = false
    var body: some View {
        if isActive {
            LoginView()
        }else{
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
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
            
        }
        
            }
        }
    }
}

struct LoadingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreenView()
    }
}
