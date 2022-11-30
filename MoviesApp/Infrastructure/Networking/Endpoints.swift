//
//  Endpoints.swift
//  MoviesApp
//
//  Created by User on 25/10/22.
//

import Foundation

enum Endpoints {
    case popular
    case movieDetails(movieId: Int)
    
    var rawValue: String {
        switch self {
        case .popular:
            return "/popular"
        case .movieDetails(let movieID):
            return "/movie/" + String(movieID)
        }
    }
}
