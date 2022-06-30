//
//  ProductDetailViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 13/05/2021.
//

import Foundation

enum GetProductDetailResponse {
    case success
    case failure(MLError)
}

protocol ProductDetailViewModelProtocol {
    var modelDetail: ProductDetailModelProtocol? { get }
    var modelDescrip: ProductDescriptionModelProtocol? { get }
    func getProductDetail(completion: @escaping (GetProductDetailResponse) -> Void)
}

final class ProductDetailViewModel {
    
    private var id: String
    private let service: ProductDetailServiceProtocol
    var modelDetail: ProductDetailModelProtocol?
    var modelDescrip: ProductDescriptionModelProtocol?
    
    init(id: String,
         service: ProductDetailServiceProtocol = ProductDetailService()) {
        self.id = id
        self.service = service
    }
    
}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    func getProductDetail(completion: @escaping (GetProductDetailResponse) -> Void) {
        service.searchProductDetail(with: id) { [weak self] response in
            switch response {
            case .success(let prodDetail):
                self?.handleProdDetailSuccess(prodDetail: prodDetail)
                self?.getProdDescription() { response in
                    switch response {
                    case .success:
                        completion(.success)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension ProductDetailViewModel {
    
    func getProdDescription(completion: @escaping (GetProductDetailResponse) -> Void) {
        service.searchProductDescription(with: id) { [weak self] response in
            switch response {
            case .success(let resp):
                self?.modelDescrip = ProductDescriptionModel(description: resp.description)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func handleProdDetailSuccess(prodDetail: ProductDetail) {
        modelDetail = ProductDetailModel(title: prodDetail.title,
                                         pictures: mapPictures(pictures: prodDetail.pictures),
                                         price: prodDetail.price,
                                         condition: prodDetail.condition)
    }
    
    func mapPictures(pictures: [Picture]) -> [PictureModelProtocol] {
        var picturesModel = [PictureModel]()
        pictures.forEach { picture in
            picturesModel.append(.init(imageUrl: picture.imageUrl))
        }
        return picturesModel
    }
    
}
