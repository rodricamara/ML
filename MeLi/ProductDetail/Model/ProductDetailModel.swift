//
//  ProductDetailModel.swift
//  MeLi
//
//  Created by Rodrigo Camara on 13/05/2021.
//

import Foundation

struct ProductDetail: Decodable {
    
    var id: String
    let title: String
    let pictures: [Pictures]
    let price: Double
    let condition: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case pictures
        case price
        case condition
    }
    
    init(id: String,
         title: String,
         pictures: [Pictures],
         price: Double,
         condition: String) {
        self.id = id
        self.title = title
        self.pictures = pictures
        self.price = price
        self.condition = condition
    }
}

struct Pictures: Decodable {
    let id: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "url"
    }
}

struct Description: Decodable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description = "plain_text"
    }
}
