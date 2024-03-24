import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showError : Bool = false
    @Published var succes : Bool = false
    @Published var errorMessage : String = ""
    
    func validateUser(){
        if username.isEmpty || password.isEmpty{
            showError = true
            errorMessage = "Please enter username and password to continue"
        }
        else if username == "abc" && password == "123" {
            showError = false
            succes = true
            
        }
        else {
            showError = true
            errorMessage = "Incorrect username and password, please try again"
        }
    }

    func login() {
        LoginAction(
            parameters: LoginRequest(
                username: username,
                password: password
            )
        ).call { _ in
            // Login successful, navigate to the Home screen
        }
    }
}
