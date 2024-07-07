//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Pavlo on 06.07.2024.
//

import Foundation

protocol ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws
}

enum ResponseValidationError: Error, Equatable {
    case unacceptableCode(Int)
}

struct StatusCodeValidator: ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws {
        guard (200...299).contains(response.statusCode) else {
            throw ResponseValidationError.unacceptableCode(response.statusCode)
        }
    }
}

typealias DataLoaderHandler = (Result<Data, EndpointError>) -> Void
typealias CurrencyConversionHandler = (Result<CurrencyConversionResponse, EndpointError>) -> Void

protocol NetworkServiceProtocol {
    func convert(request: CurrencyConversionRequest, completion: @escaping CurrencyConversionHandler)
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let responseValidator: ResponseValidator
    
    init(session: URLSession,
         decoder: JSONDecoder,
         encoder: JSONEncoder,
         responseValidator: ResponseValidator) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
        self.responseValidator = responseValidator
    }
    
    private func request(_ endpoint: Endpoint, completion: @escaping DataLoaderHandler) {
        guard NetworkConnectivityManager.shared.isOnline else {
            completion(.failure(EndpointError.noInternetConnection))
            return
        }
        
        guard let url = endpoint.url else {
            return completion(.failure(EndpointError.invalidURL))
        }
        
        let task = session.dataTask(with: url) { [responseValidator] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse(response)))
                return
            }
            
            do {
                try responseValidator.validate(httpResponse)
            } catch {
                completion(.failure(.validation(error)))
            }
            
            let result = data.map(Result.success) ?? .failure(EndpointError.network(error))
            completion(result)
        }
        
        task.resume()
    }
    
    func convert(request: CurrencyConversionRequest, completion: @escaping CurrencyConversionHandler) {
        self.request(.fxRates(request: request)) { [decoder] result in
            switch result {
            case .success(let data):
                do {
                    let response = try decoder.decode(CurrencyConversionResponse.self, from: data)
                    completion(.success(response))
                    print(response)
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkService {
    static func makeDefault() -> NetworkService {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        let responseValidator = StatusCodeValidator()
        
        return .init(session: session,
                     decoder: decoder,
                     encoder: encoder,
                     responseValidator: responseValidator)
    }
}
