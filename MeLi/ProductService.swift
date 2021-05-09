//
//  ProductService.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

enum ProductListResponse {
    case success(products: ProductResponse)
    case failure(error: MLError)
}

typealias ProductResponseClosure = (ProductListResponse) -> Void

protocol ProductServiceProtocol {
    func searchProducts(products: String, completion: @escaping ProductResponseClosure)
}

class ProductService {
    
    var manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
    
}

extension ProductService: ProductServiceProtocol {
    
    func searchProducts(products: String, completion: @escaping ProductResponseClosure) {
        
        let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.productsSearch.rawValue+products)!
        let request = URLRequest.init(url: url, method: .post, body: nil)
        
        manager.callAPI(request: request) { (response: Result<ProductResponse, MLError>) in
            switch response {
            case .success(let product):
                completion(.success(products: product))
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}
