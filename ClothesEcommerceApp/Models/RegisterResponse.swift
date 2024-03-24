import Foundation

struct RegisterResponse: Decodable {
    let data: LoginResponseData
}

struct RegisterResponseData: Decodable {
    let accessToken: String
    let refreshToken: String
}
