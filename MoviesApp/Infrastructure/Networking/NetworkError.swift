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
}

extension NetworkError {
    var errorDescripition: String? {
        switch self {
        case .noInternet:
            return "Sem internet"
        case .JSONParsingError:
            return "JSON Parsing não feito"
        case .noData:
            return "Sem data"
        case .internalServerError:
            return "Servidor com problemas, tente mais tarde"
        case .unexpected:
            return "Nem sei o que aconteceu, valeu, beijos na familia"
        }
    }
}
