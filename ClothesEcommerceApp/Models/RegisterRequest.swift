import Foundation

struct RegisterRequest: Encodable {
    let username: String
    let password: String
    let reenterpassword: String
}
