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
    
    private let manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
    
}

extension ProductService: ProductServiceProtocol {
    
    func searchProducts(products: String, completion: @escaping ProductResponseClosure) {
        
        let urlString = MLEndpoints.baseURL.rawValue + MLEndpoints.productsSearch.rawValue + products
        guard let url = URL(string: urlString) else {
            return completion(.failure(error: MLError.invalidURL))
        }
        
        let request = URLRequest.init(url: url, method: .post, body: nil)
        manager.callAPI(request: request) { (response: Result<ProductResult, MLError>) in
            switch response {
            case .success(let resp):
                completion(.success(products: resp))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
