//
//  ProductModelViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 26/05/2021.
//

protocol ProductModelViewModelProtocol {
    var id: String { get }
    var title: String { get }
    var price: Double { get }
    var imageURL: String { get }
    var condition: String { get }
}

struct ProductModelViewModel: ProductModelViewModelProtocol {
    let id: String
    let title: String
    let price: Double
    let imageURL: String
    let condition: String
}
