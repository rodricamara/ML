//
//  ProductDetailService.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import Foundation

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
        
        if let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.itemSearch.rawValue+id) {
            let request = URLRequest.init(url: url, method: .get, body: nil)
            
            manager.callAPI(request: request) { (response: Result<ProductDetail, MLError>) in
                switch response {
                case .success(let productDetail):
                    completion(.success(product: productDetail))
                case .failure(let error):
                    completion(.failure(error: error))
                }
            }
        }
    }
    
    func searchProductDescription(with id: String, completion: @escaping ProductDescriptionResponseClosure) {
        
        if let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.itemSearch.rawValue+id+MLEndpoints.itemDescription.rawValue) {
            let request = URLRequest.init(url: url, method: .get, body: nil)
            
            manager.callAPI(request: request) { (response: Result<Description, MLError>) in
                switch response {
                case .success(let productDescription):
                    completion(.success(description: productDescription))
                case .failure(let error):
                    completion(.failure(error: error))
                }
            }
        }
    }
}
    
    
