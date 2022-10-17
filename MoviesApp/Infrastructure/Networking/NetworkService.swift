import Foundation
import Kingfisher
final class NetworkService {
    func getMovies(completionHandler: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3a3236cd08291ebde30c78c625a5f9c2&language=en-US&page=1") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(MovieResponse.self, from: data) else {return}
            completionHandler(response.results)
        }
        task.resume()
    }
}
