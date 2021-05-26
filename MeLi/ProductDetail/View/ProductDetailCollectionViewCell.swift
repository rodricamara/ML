//
//  ProductDetailCollectionViewCell.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import UIKit

final class ProductDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    var picture: PictureModel? {
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
