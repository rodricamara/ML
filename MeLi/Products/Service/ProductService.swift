//
//  ProductService.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

enum ProductsResponse {
    case success(products: ProductResult)
    case failure(error: MLError)
}

typealias ProductResponseClosure = (ProductsResponse) -> Void

protocol ProductServiceProtocol {
    func searchProducts(products: String, completion: @escaping ProductResponseClosure)
}

final class ProductService {
    
    var manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
    
}

extension ProductService: ProductServiceProtocol {
    
    func searchProducts(products: String, completion: @escaping ProductResponseClosure) {
        
        guard let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.productsSearch.rawValue+products) else {
            let error: MLError = .invalidURL
            print(error.errorDescription)
            return completion(.failure(error: error))
        }
        let request = URLRequest.init(url: url, method: .post, body: nil)
        
        manager.callAPI(request: request) { (response: Result<ProductResult, MLError>) in
            switch response {
            case .success(let resp):
                completion(.success(products: resp))
            case .failure(let error):
                print(error.errorDescription)
                completion(.failure(error: error))
            }
        }
    }
}
