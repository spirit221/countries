//
//  NetworkError.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case emptyResponse
    
    var userFriendlyMessage: String {
        switch self {
        case .invalidURL:
            return "Oops! It seems there was an issue with the URL. Please check the link and try again."
        case .invalidResponse:
            return "We received an unexpected response from the server. Please try again later."
        case .decodingError:
            return "There was a problem processing your request. Please contact support if this continues."
        case .emptyResponse:
            return "It looks like we didn't receive any data from the server. Please try refreshing the page."
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.emptyResponse, .emptyResponse):
            return true
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

extension Error {
    var userFriendlyMessage: String {
        return (self as? NetworkError)?.userFriendlyMessage ?? "Something went wrong"
    }
}
