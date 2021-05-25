//
//  ProductDetailViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 13/05/2021.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    var prodDetail: ProductDetail { get }
    var prodDescrip: Description { get }
    func getProductDetail(with id: String, completion: @escaping (ProductDetailResponse) -> Void)
    func getProductDescription(with id: String, completion: @escaping (ProductDescriptionResponse) -> Void)
}

final class ProductDetailViewModel {
    
    var prodDetail = ProductDetail(id: "", title: "", pictures: [], price: 0.0, condition: "")
    var prodDescrip = Description(description: "")
    let service = ProductDetailService()
    
    init() {}
    
}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    func getProductDetail(with id: String, completion: @escaping (ProductDetailResponse) -> Void) {
        
        service.searchProductDetail(with: id) { [weak self] (response) in
            switch response {
            case .success(let product):
                print(product)
                self?.prodDetail = product
                completion(response)
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getProductDescription(with id: String, completion: @escaping (ProductDescriptionResponse) -> Void) {
        
        service.searchProductDescription(with: id) { [weak self] (response) in
            switch response {
            case .success(let description):
                print(description)
                self?.prodDescrip = description
                completion(.success(description: description))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
}
