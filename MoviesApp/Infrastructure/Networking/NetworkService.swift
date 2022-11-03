import Foundation

final class NetworkService {
    let errorLogger = ErrorLogger()
        
    func get<T>(endpoint: Endpoints,
             queryParameters: [Dictionary<String,String>],
             completionHandler: @escaping (T?, Error?) -> Void) {
        let queryString = parseQueryParameters(queryParameters: queryParameters)
        guard let url = URL(string: AppConfiguration.apiBaseURL+endpoint.rawValue+queryString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                self?.errorLogger.log(error: NetworkError.unexpected)
                return
            }
            if !(200..<300).contains(httpResponse.statusCode) {
                if httpResponse.statusCode == 500 {
                    completionHandler(nil, NetworkError.internalServerError)
                    return
                } else {
                    completionHandler(nil, NetworkError.unexpected)
                }
            }
            if let otherError = self?.handleOtherErrors(error: error) {
                completionHandler(nil, otherError)
                return
            }
            guard let data = data else {
                self?.errorLogger.log(error: NetworkError.noData)
                return
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {
                self?.errorLogger.log(error: NetworkError.JSONParsingError)
                return
            }
            completionHandler(response, nil)
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
    private func parseQueryParameters(queryParameters:[Dictionary<String,String>]) -> String {
        var queryString = "?"
        for queryParameterDict in queryParameters {
            for (chave, valor) in queryParameterDict {
                queryString+=chave+"="+valor+"&"
            }
        }
        return queryString
    }
}
