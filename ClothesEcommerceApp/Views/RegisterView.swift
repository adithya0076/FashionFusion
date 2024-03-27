import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 250)
                    .foregroundStyle(.blue)
                    
                Text("Register").bold().frame(maxWidth: .infinity, alignment: .leading).padding(10)
                ScrollView{
                    VStack{
                        
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
                            TextField(
                                "Email",
                                text: $viewModel.email
                            )
                                .padding(.leading, 40)
                                .textInputAutocapitalization(.never)
                        }
                        RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .padding()
                        .foregroundColor(.gray.opacity(0.4))
                        .overlay{
                            TextField(
                                "First Name",
                                text: $viewModel.first_name
                            )
                                .padding(.leading, 40)
                                .textInputAutocapitalization(.never)
                        }
                        RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .padding()
                        .foregroundColor(.gray.opacity(0.4))
                        .overlay{
                            TextField(
                                "Last Name",
                                text: $viewModel.last_name
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
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .padding()
                            .foregroundColor(.gray.opacity(0.4))
                            .overlay{
                                SecureField(
                                        "Re-enter Password",
                                        text: $viewModel.reenterpassword
                                    )
                                    .padding(.leading, 40)
                                    .textInputAutocapitalization(.never)
                            }
                        
                        
                        
                    }
                    .padding()
                }
                Button(action: {
                    viewModel.register()
                    
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
                NavigationLink(destination: LoginView(), isActive: $viewModel.success) {
                    EmptyView()
                }
                
            }
        }
    }
}

#Preview {
    RegisterView()
}
