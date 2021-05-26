//
//  ProductCellViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

protocol ProductCellViewModelProtocol {
    var image: String? { get }
    var title: String { get }
    var price: Double { get }
    var condition: String { get }
}

final class ProductCellViewModel: ProductCellViewModelProtocol {
    
    var image: String? {
        return product.imageURL
    }
    
    var title: String {
        return product.title
    }
    
    var price: Double {
        return product.price
    }
    
    var condition: String {
        return product.condition
    }
    
    private let product: ProductModelViewModelProtocol
    
    init(product: ProductModelViewModelProtocol) {
        self.product = product
    }
}
