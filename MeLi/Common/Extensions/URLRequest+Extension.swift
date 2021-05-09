//
//  URLRequest+Extension.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

extension URLRequest {
    
    public var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else { return .get }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }
        set {
            self.httpMethod = newValue?.rawValue
        }
    }
    
    public init(url: URL, method: HTTPMethod, body: Data?) {
        self.init(url: url)
        self.method = method
        self.httpBody = body
    }
    
}
