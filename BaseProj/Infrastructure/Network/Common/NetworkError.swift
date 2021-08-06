//
//  NetworkError.swift
//  BaseProj
//
//  Created by 김종권 on 2021/08/07.
//

import Foundation
import Moya

enum NetworkError: Error {
    case notConnectedToInternet
    case tokenExpired
    case unknown
    case defaultUnknown
}

enum ServiceError: Error {
    case moyaError(MoyaError)
    case invalidResponse(responseCode: Int, message: String)
    case tokenExpired
    case refreshTokenExpired
    case duplicateLoggedIn(message: String)
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .moyaError(let moyaError):
            return moyaError.localizedDescription
        case let .invalidResponse(_, message):
            return message
        case .tokenExpired:
            return "AccessToken Expired"
        case .refreshTokenExpired:
            return "RefreshToken Expired"
        case let .duplicateLoggedIn(message):
            return message
        }
    }
}
