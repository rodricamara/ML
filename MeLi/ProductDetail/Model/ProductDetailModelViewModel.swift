//
//  ProductDetailModelViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 26/05/2021.
//

protocol ProductDetailModelProtocol {
    var title: String { get }
    var pictures: [PictureModel] { get }
    var price: Double { get }
    var condition: String { get }
}

protocol ProductDescriptionModelProtocol {
    var description: String { get }
}

struct ProductDetailModel: ProductDetailModelProtocol {
    let title: String
    let pictures: [PictureModel]
    let price: Double
    let condition: String
}

struct PictureModel {
    let imageUrl: String
}

struct ProductDescriptionModel: ProductDescriptionModelProtocol {
    let description: String
}
