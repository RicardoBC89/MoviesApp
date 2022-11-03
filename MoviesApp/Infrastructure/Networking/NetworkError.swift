//
//  NetworkError.swift
//  MoviesApp
//
//  Created by User on 21/10/22.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case JSONParsingError
    case noData
    case internalServerError
    case unexpected
    case badRequest
}

extension NetworkError {
    var errorDescripition: String? {
        switch self {
        case .noInternet:
            return "no_internet".localized
        case .JSONParsingError:
            return "no_JSON".localized
        case .noData:
            return "no_data".localized
        case .internalServerError:
            return "server_error".localized
        case .unexpected, .badRequest:
            return "unexpected".localized
        }
    }
}
