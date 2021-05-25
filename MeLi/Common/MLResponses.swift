//
//  MLResponses.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

enum ProductsResponse {
    case success
    case empty
    case failure(MLError)
}

enum ProductResponse {
    case success
    case failure(MLError)
}

enum ProductListResponse {
    case success(products: ProductResult)
    case failure(error: MLError)
}

enum ProductDetailResponse {
    case success(product: ProductDetail)
    case failure(error: MLError)
}

enum ProductDescriptionResponse {
    case success(description: Description)
    case failure(error: MLError)
}
