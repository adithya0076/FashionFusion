import Foundation

class RegisterViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var reenterpassword: String = ""
    @Published var showError : Bool = false
    @Published var succes : Bool = false
    @Published var errorMessage : String = ""
    
    func validateUser(){
        if username.isEmpty || password.isEmpty || reenterpassword.isEmpty {
            showError = true
            errorMessage = "Please enter username and password to continue"
        }
        else if password != reenterpassword {
            showError = true
            errorMessage = "Passwords do not match"
        }
        else if !username.isEmpty && password != reenterpassword {
            showError = false
            succes = true
        }
        else {
            showError = true
            errorMessage = "Incorrect username and password, please try again"
        }
    }

    func login() {
        RegisterAction(
            parameters: RegisterRequest(
                username: username,
                password: password,
                reenterpassword: reenterpassword
            )
        ).call { _ in
            // Login successful, navigate to the Home screen
        }
    }
}
