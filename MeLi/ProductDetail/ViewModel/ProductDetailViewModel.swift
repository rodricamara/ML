//
//  ProductDetailViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 13/05/2021.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    var modelDetail: ProductDetailModelProtocol? { get }
    var modelDescrip: ProductDescriptionModelProtocol? { get }
    func getProductDetail(completion: @escaping (ProductResponse) -> Void)
    func getProductDescription(completion: @escaping (ProductResponse) -> Void)
}

final class ProductDetailViewModel {
    
    var id: String
    let service: ProductDetailServiceProtocol
    var modelDetail: ProductDetailModelProtocol?
    var modelDescrip: ProductDescriptionModelProtocol?
    
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
            case .success(let resp):
                self?.handleProdDetailSuccess(prodDetail: resp)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleProdDetailSuccess(prodDetail: ProductDetail) {
        var pictures = [PictureModel]()
        for item in prodDetail.pictures {
            pictures.append(PictureModel(imageUrl: item.imageUrl))
        }
        self.modelDetail = ProductDetailModel(title: prodDetail.title,
                                              pictures: pictures,
                                              price: prodDetail.price,
                                              condition: prodDetail.condition)
    }
    
    func getProductDescription(completion: @escaping (ProductResponse) -> Void) {
        
        service.searchProductDescription(with: id) { [weak self] (response) in
            switch response {
            case .success(let resp):
                self?.modelDescrip = ProductDescriptionModel(description: resp.description)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
