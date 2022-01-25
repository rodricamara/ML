//
//  ProductDetailCollectionViewCell.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import UIKit

final class ProductDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    var picture: PictureModelProtocol? {
        didSet {
            self.updateUI()
        }
    }
    
}

private extension ProductDetailCollectionViewCell {
    private func updateUI() {
        productImage.image = UIImage(named: "PLACEHOLDER".localized)
        guard let picture = picture else { return }
        productImage.image(fromString: picture.imageUrl)
    }
}
