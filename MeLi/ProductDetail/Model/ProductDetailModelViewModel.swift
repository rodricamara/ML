//
//  ProductDetailModelViewModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 26/05/2021.
//

protocol ProductDetailModelProtocol {
    var title: String { get }
    var pictures: [PictureModelProtocol] { get }
    var price: Double { get }
    var condition: String { get }
}

struct ProductDetailModel: ProductDetailModelProtocol {
    let title: String
    let pictures: [PictureModelProtocol]
    let price: Double
    let condition: String
}

protocol PictureModelProtocol {
    var imageUrl: String { get }
}

struct PictureModel: PictureModelProtocol {
    let imageUrl: String
}

protocol ProductDescriptionModelProtocol {
    var description: String { get }
}

struct ProductDescriptionModel: ProductDescriptionModelProtocol {
    let description: String
}
