//
//  NetworkManager.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func callAPI<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, MLError>) -> Void)
}

final class NetworkManager {
    
    private let session = URLSession.shared
    
    init() {}
    
}

extension NetworkManager: NetworkManagerProtocol {
    func callAPI<T>(request: URLRequest, completion: @escaping (Result<T, MLError>) -> Void) where T: Decodable {
        
        session.dataTask(with: request, completionHandler: { data, _, error in
            if error.isNil {
                guard let data = data else {
                    completion(.failure(.dataIsNil))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.serviceError))
            }
        })
        .resume()
    }
}
