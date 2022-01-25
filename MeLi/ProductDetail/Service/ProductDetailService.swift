//
//  ProductDetailService.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import Foundation

enum ProductDetailResponse {
    case success(detail: ProductDetail)
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

final class ProductDetailService {
    
    private var manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
    
}

extension ProductDetailService: ProductDetailServiceProtocol {
    
    func searchProductDetail(with id: String, completion: @escaping ProductDetailResponseClosure) {
        
        guard let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.itemSearch.rawValue+id) else {
            let error: MLError = .invalidURL
            print(error.errorDescription)
            return completion(.failure(error: error))
        }
        let request = URLRequest.init(url: url, method: .get, body: nil)
        
        manager.callAPI(request: request) { (response: Result<ProductDetail, MLError>) in
            switch response {
            case .success(let resp):
                completion(.success(detail: resp))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func searchProductDescription(with id: String, completion: @escaping ProductDescriptionResponseClosure) {
        
        guard let url = URL(string: MLEndpoints.baseURL.rawValue+MLEndpoints.itemSearch.rawValue+id+MLEndpoints.itemDescription.rawValue) else {
            let error: MLError = .invalidURL
            print(error.errorDescription)
            return completion(.failure(error: error))
        }
        let request = URLRequest.init(url: url, method: .get, body: nil)
        
        manager.callAPI(request: request) { (response: Result<Description, MLError>) in
            switch response {
            case .success(let resp):
                completion(.success(description: resp))
            case .failure(let error):
                print(error.errorDescription)
                completion(.failure(error: error))
            }
        }
    }
}
