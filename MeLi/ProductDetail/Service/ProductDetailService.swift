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
    
    private let manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
    
}

extension ProductDetailService: ProductDetailServiceProtocol {
    
    func searchProductDetail(with id: String, completion: @escaping ProductDetailResponseClosure) {
        
        let urlString = MLEndpoints.baseURL.rawValue + MLEndpoints.itemSearch.rawValue + id
        guard let url = URL(string: urlString) else {
            return completion(.failure(error: MLError.invalidURL))
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
        
        let urlString = MLEndpoints.baseURL.rawValue + MLEndpoints.itemSearch.rawValue + id + MLEndpoints.itemDescription.rawValue
        guard let url = URL(string: urlString) else {
            return completion(.failure(error: MLError.invalidURL))
        }
        
        let request = URLRequest.init(url: url, method: .get, body: nil)
        manager.callAPI(request: request) { (response: Result<Description, MLError>) in
            switch response {
            case .success(let resp):
                completion(.success(description: resp))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
