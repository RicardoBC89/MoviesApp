import Foundation
final class NetworkService {
    let errorLogger = ErrorLogger()
    func getMovies(pagina: Int, completionHandler: @escaping ([Movie], Error?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3a3236cd08291ebde30c78c625a5f9c2&language=en-US&page=\(pagina)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                self?.errorLogger.log(error: NetworkError.unexpected)
                return
            }
            if !(200..<300).contains(httpResponse.statusCode) {
                if httpResponse.statusCode == 500 {
                    completionHandler([], NetworkError.internalServerError)
                    return
                } else {
                    completionHandler([], NetworkError.unexpected)
                }
            }
            if let otherError = self?.handleOtherErrors(error: error) {
                completionHandler([], otherError)
                return
            }
            guard let data = data else {
                self?.errorLogger.log(error: NetworkError.noData)
                return
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(MovieResponse.self, from: data) else {
                self?.errorLogger.log(error: NetworkError.JSONParsingError)
                return
            }
            completionHandler(response.results, nil)
        }
        task.resume()
    }
    
    private func handleOtherErrors(error: Error?) -> NetworkError? {
        guard let error = error else {
            return nil
        }
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .noInternet
        default: return .unexpected
        }
    }
}
