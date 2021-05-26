//
//  MLError.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

enum MLError: Error {
    
    case decodingError
    case dataIsNil
    case serviceError
    case invalidURL
    
    var errorDescription: String {
        switch self {
        case .dataIsNil:
            return "Error: The data is nil."
        case .decodingError:
            return "Error: Failed when parsing."
        case .serviceError:
            return "Error: There's an error in the service."
        case .invalidURL:
            return "Error: There's an error in the requested URL."
        }
    }
}
