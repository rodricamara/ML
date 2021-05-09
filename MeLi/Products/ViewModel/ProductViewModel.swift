//
//  ProductViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

enum ProductsResponse {
    case success
    case empty
    case failure(MLError)
}

protocol ProductViewModelProtocol {
    var productsList: [Product] { get }
    func getProducts(using text: String, completion: @escaping (ProductsResponse) -> Void)
}

final class ProductViewModel {
    
    var productsList = [Product]()
    let service = ProductService()
    
    init() { }
}

extension ProductViewModel: ProductViewModelProtocol {
    
    func getProducts(using text: String, completion: @escaping (ProductsResponse) -> Void) {
        service.searchProducts(products: text) { [weak self] (response) in
            switch response {
            case .success(let responseModel):
                self?.productsList = responseModel.results
                if responseModel.results.isEmpty {
                    self?.productsList = []
                    completion(.empty)
                } else {
                    self?.productsList = responseModel.results
                    completion(.success)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
