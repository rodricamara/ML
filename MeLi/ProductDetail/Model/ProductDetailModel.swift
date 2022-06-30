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
    let pictures: [Picture]
    let price: Double
    let condition: String
}

struct Picture: Decodable {
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
