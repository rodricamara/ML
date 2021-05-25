//
//  ProductDetailCollectionViewCell.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    var picture: Picture? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        self.productImage.image = UIImage(named: "PLACEHOLDER".localized)
        guard let picture = picture else { return }
        self.productImage.image(fromString: picture.imageUrl)
    }
    
}
