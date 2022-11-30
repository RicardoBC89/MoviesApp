//
//  NetworkError.swift
//  MoviesApp
//
//  Created by User on 21/10/22.
//

import Foundation
protocol BaseError: Error {
    var errorDescription: String? {get}
}

enum NetworkError {
    case noInternet
    case noData
    case internalServerError
    case unexpected
    case badRequest
    case noMorePages
}

enum InfrastructureError {
    case JSONParsingError(debugDescription: String)
}

extension NetworkError: BaseError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "no_internet".localized
        case .noData:
            return "no_data".localized
        case .internalServerError:
            return "server_error".localized
        case .unexpected, .badRequest:
            return "unexpected".localized
        default: return ""
        }
    }
}

extension InfrastructureError: BaseError {
    var errorDescription: String? {
        switch self {
        case .JSONParsingError:
            return "no_JSON".localized
        default: return ""
        }
    }
}
