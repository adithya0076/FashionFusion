import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = LoginViewModel() 
    @State var isLogout = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text(viewModel.username)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            
            Spacer()
            
            Button(action: {
                isLogout = true
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
            
            NavigationLink(destination: LoadingScreenView(), isActive: $isLogout) {
                EmptyView()
            }
        }
        .navigationBarTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
