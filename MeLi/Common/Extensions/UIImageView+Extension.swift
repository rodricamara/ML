//
//  UIImageView+Extension.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

extension UIImageView {
    
    public func image(fromUrl url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: response)
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "PLACEHOLDER".localized)
                }
            }
        }
        task.resume()
    }
    
    public func image(fromString urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        image(fromUrl: url)
    }
}
