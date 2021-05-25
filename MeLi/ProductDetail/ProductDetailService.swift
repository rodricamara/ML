//
//  ProductDetailService.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import Foundation

enum ProductDetailResponse {
    case success(product: ProductDetail)
    case failure(error: MLError)
}

enum ProductDescriptionResponse {
    case success(description: Description)
    case failure(error: MLError)
}

typealias ProductDetailResponseClosure = (ProductDetailResponse) -> Void
typealias ProductDescriptionResponseClosure = (ProductDescriptionResponse) -> Void

protocol ProductDetailServiceProtocol {
    func searchProductDetail(with id: String, completion: @escaping ProductDetailResponseClosure)
    func searchProductDescription(with id: String, completion: @escaping ProductDescriptionResponseClosure)
}

class ProductDetailService {
    
    var manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
    
}

extension ProductDetailService: ProductDetailServiceProtocol {
    
    func searchProductDetail(with id: String, completion: @escaping ProductDetailResponseClosure) {
        
        let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.itemSearch.rawValue+id)!
        let request = URLRequest.init(url: url, method: .get, body: nil)

        manager.callAPI(request: request) { (response: Result<ProductDetail, MLError>) in
            switch response {
            case .success(let productDetail):
                completion(.success(product: productDetail))
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func searchProductDescription(with id: String, completion: @escaping ProductDescriptionResponseClosure) {
        
        let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.itemSearch.rawValue+id+MLEndpoints.itemDescription.rawValue)!
        let request = URLRequest.init(url: url, method: .get, body: nil)

        manager.callAPI(request: request) { (response: Result<Description, MLError>) in
            switch response {
            case .success(let productDescription):
                completion(.success(description: productDescription))
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    
}
    
    
