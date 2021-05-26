//
//  ProductDetailViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 13/05/2021.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    var prodDetail: ProductDetail? { get }
    var prodDescrip: Description? { get }
    func getProductDetail(completion: @escaping (ProductResponse) -> Void)
    func getProductDescription(completion: @escaping (ProductResponse) -> Void)
}

final class ProductDetailViewModel {
    
    var prodDescrip: Description?
    var prodDetail: ProductDetail?
    var id: String
    let service: ProductDetailServiceProtocol
      
    init(service: ProductDetailServiceProtocol = ProductDetailService(),
         id: String) {
        self.service = service
        self.id = id
    }
    
}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    func getProductDetail(completion: @escaping (ProductResponse) -> Void) {
        
        service.searchProductDetail(with: id) { [weak self] (response) in
            switch response {
            case .success(let product):
                self?.prodDetail = product
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProductDescription(completion: @escaping (ProductResponse) -> Void) {
        
        service.searchProductDescription(with: id) { [weak self] (response) in
            switch response {
            case .success(let description):
                self?.prodDescrip = description
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
