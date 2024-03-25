import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 250)
                    .foregroundStyle(.blue)
                    
                
                VStack{
                    Text("Login").bold().frame(maxWidth: .infinity, alignment: .leading).padding(10)
                    RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding()
                    .foregroundColor(.gray.opacity(0.4))
                    .overlay{
                        TextField(
                            "Username",
                            text: $viewModel.username
                        )
                            .padding(.leading, 40)
                            .textInputAutocapitalization(.never)
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .padding()
                        .foregroundColor(.gray.opacity(0.4))
                        .overlay{
                            SecureField(
                                    "Password",
                                    text: $viewModel.password
                                )
                                .padding(.leading, 40)
                                .textInputAutocapitalization(.never)
                        }
                    
                    
                    
                    Button(action: viewModel.login, label: {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(height: 50)
                            .padding(10)
                            .overlay{
                                Text("Login")
                                    .foregroundColor(.white)
                            }
                    })
                    
                    Text("Or").frame(maxWidth: .infinity, alignment: .center).padding(10)
                    
                    Button(action: {
                        
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(height: 50)
                            .padding(10)
                            .overlay{
                                Text("Sign Up")
                                    .foregroundColor(.white)
                                    
                            }.tint(.red)
                    }
                        
                    )
                }
                .padding()
                Spacer()
                if viewModel.showError {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 100)
                        .padding(10)
                        .foregroundColor(.red)
                        .overlay {
                            Text(viewModel.errorMessage)
                                .foregroundStyle(.white)
                                .bold()
                        }
                }
                Spacer()
                NavigationLink(destination: HomeView(), isActive: $viewModel.success) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
