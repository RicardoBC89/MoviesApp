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
        print(error)
        #endif
    }
}

