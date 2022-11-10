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
    private let userRepository: UserRepository = UserRepository()
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol = MoviesRepository()) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(pagina: Int, viewModelCompletionHandler: @escaping ([Movie], Error?) -> Void) {
        userRepository.getUser(viewModelCompletionHandler: { [weak self] user in
            self?.moviesRepository.getMovies(pagina: 1) { movies, error in
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
        })
    }
}
