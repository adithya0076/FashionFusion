import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showError : Bool = false
    @Published var success : Bool = false
    @Published var errorMessage : String = ""
    
    func validateUser() {
        if username.isEmpty || password.isEmpty {
            showError = true
            errorMessage = "Please enter username and password to continue"
        }
        else{
            showError = false
            errorMessage = ""
        }
    }

    func login() {
        validateUser() // Call validateUser to perform validation
        
        // Check if validation succeeded
        guard !showError else {
            // Show error message or handle invalid input
            return
        }
        
        // Validation successful, proceed with login action
        let loginRequest = LoginRequest(username: username, password: password)
//        let url = URL(string: "https://fashionfusionbackend.onrender.com/login")!
        let url = URL(string: "http://127.0.0.1:8000/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(loginRequest)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    // Login successful
                    DispatchQueue.main.async {
                        self.showError = false
                        self.success = true
                        // Navigate to the Home screen
                    }
                } else {
                    // Login failed
                    DispatchQueue.main.async {
                        self.showError = true
                        self.errorMessage = "Incorrect username and password, please try again"
                    }
                }
            }.resume()
        } catch {
            print("Error encoding login request: \(error.localizedDescription)")
        }
    }
}
