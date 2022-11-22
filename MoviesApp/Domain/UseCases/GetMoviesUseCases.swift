//
//  GetMoviesUseCases.swift
//  MoviesApp
//
//  Created by User on 09/11/22.
//

import Foundation

protocol GetMoviesUseCaseProtocol {
    func execute(pagina: Int, viewModelCompletionHandler: @escaping ([Movie], Error?) -> Void)
}

final class GetMoviesUseCase: GetMoviesUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol = MoviesRepository(), userRepository: UserRepositoryProtocol = UserRepository()) {
        self.moviesRepository = moviesRepository
        self.userRepository = userRepository
    }
    
    func execute(pagina: Int, viewModelCompletionHandler: @escaping ([Movie], Error?) -> Void) {
        let user = userRepository.getUser()
        moviesRepository.getMovies(pagina: pagina) { movies, error in
            if let error = error {
                viewModelCompletionHandler([], error)
                return
            }
            guard let user = user else {
                viewModelCompletionHandler(movies, error)
                return
            }
            if user.age < 21 {
                let filteredMovies = movies.filter { movie in
                    movie.adult == false
                }
                viewModelCompletionHandler(filteredMovies, error)
                return
            } else {
                viewModelCompletionHandler(movies, error)
                return
            }
        }
    }
}
