import Foundation

final class NetworkService {
    let errorLogger = ErrorLogger()
        
    func get<T: Decodable>(endpoint: Endpoints,
             queryParameters: [Dictionary<String,String>],
             serviceCompletionHandler: @escaping (T?, Error?) -> Void) {
        let queryString = parseQueryParameters(queryParameters: queryParameters)
        guard let url = URL(string: AppConfiguration.apiBaseURL + endpoint.rawValue + queryString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    serviceCompletionHandler(nil, NetworkError.noInternet)
                    return
                default: serviceCompletionHandler(nil, error)
                }
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                self?.errorLogger.log(error: NetworkError.unexpected)
                return
            }
            if !(200..<300).contains(httpResponse.statusCode) {
                if httpResponse.statusCode == 500 {
                    serviceCompletionHandler(nil, NetworkError.internalServerError)
                    return
                } else {
                    serviceCompletionHandler(nil, NetworkError.unexpected)
                }
            }
            if let otherError = self?.handleOtherErrors(error: error) {
                serviceCompletionHandler(nil, otherError)
                return
            }
            guard let data = data else {
                self?.errorLogger.log(error: NetworkError.noData)
                return
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {
                self?.errorLogger.log(error: InfrastructureError.JSONParsingError(debugDescription: response.debugDescription))
                return
            }
            serviceCompletionHandler(response, nil)
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
                queryString += chave + "=" + valor + "&"
            }
        }
        return queryString
    }
}
