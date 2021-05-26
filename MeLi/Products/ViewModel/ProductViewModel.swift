//
//  ProductViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

enum GetProductsResponse {
    case success
    case empty
    case failure(MLError)
}

protocol ProductViewModelProtocol {
    var model: [ProductModelViewModelProtocol]? { get }
    func getProducts(using text: String, completion: @escaping (GetProductsResponse) -> Void)
}

final class ProductViewModel {
    
    var model: [ProductModelViewModelProtocol]?
    let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
}

extension ProductViewModel: ProductViewModelProtocol {
    
    func getProducts(using text: String, completion: @escaping (GetProductsResponse) -> Void) {
        service.searchProducts(products: text) { [weak self] (response) in
            switch response {
            case .success(let responseModel):
                if responseModel.results.isEmpty {
                    self?.model = []
                    completion(.empty)
                } else {
                    self?.handleProductsSuccess(products: responseModel.results)
                    completion(.success)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleProductsSuccess(products: [Product]) {
        var productsModel = [ProductModelViewModel]()
        for item in products {
            productsModel.append(ProductModelViewModel(id: item.id,
                                                       title: item.title,
                                                       price: item.price,
                                                       imageURL: item.imageURL,
                                                       condition: item.condition))
        }
        self.model = productsModel
    }
    
}
