import Foundation

struct RegisterRequest: Encodable {
    let username: String
    let password: String
    let email: String
    let first_name: String
    let last_name: String
}
