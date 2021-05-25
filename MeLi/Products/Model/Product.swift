//
//  Product.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

struct ProductResult: Decodable {
    let results: [Product]
}

struct Product: Decodable {
    
    let title: String
    let id: String
    let price: Double
    let imageURL: String
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case price
        case imageURL = "thumbnail"
        case condition
    }
}
