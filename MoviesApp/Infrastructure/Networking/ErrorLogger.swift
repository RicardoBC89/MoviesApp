//
//  ErrorLogger.swift
//  MoviesApp
//
//  Created by User on 21/10/22.
//

import Foundation

class ErrorLogger {
    func log(error: Error) {
        #if DEBUG
        switch error {
        case InfrastructureError.JSONParsingError(let debugDescription):
            print(debugDescription)
        default: print(error)
        }
        #endif
    }
}

