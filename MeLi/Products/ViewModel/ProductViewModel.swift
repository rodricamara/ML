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
    case failure
}

protocol ProductViewModelProtocol {
    var model: [ProductModelViewModelProtocol]? { get }
    func getProducts(using text: String, completion: @escaping (GetProductsResponse) -> Void)
}

final class ProductViewModel {
    
    internal var model: [ProductModelViewModelProtocol]?
    private let service: ProductServiceProtocol
    
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
            case .failure(_):
                completion(.failure)
            }
        }
    }
    
    private func handleProductsSuccess(products: [Product]) {
        var productsModel = [ProductModelViewModel]()
        products.forEach { product in
            productsModel.append(ProductModelViewModel(id: product.id,
                                                       title: product.title,
                                                       price: product.price,
                                                       imageURL: product.imageURL,
                                                       condition: product.condition))
        }
        self.model = productsModel
    }
    
}
