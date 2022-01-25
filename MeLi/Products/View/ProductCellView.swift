//
//  ProductCell.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

protocol ProductCellViewProtocol {
    func configure(viewModel: ProductCellViewModelProtocol)
}

final class ProductCellView: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCondition: UILabel!
    
    private var viewModel: ProductCellViewModelProtocol? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            productTitle.numberOfLines = 0
            productTitle.text = viewModel.title
            productPrice.text = String("$ \(Int(viewModel.price))")
            productCondition.textColor = .orange
            productCondition.text = translateCondition(text: viewModel.condition)
            productImage.image = UIImage(named: "PLACEHOLDER".localized)
            guard let image = viewModel.image else { return }
            productImage.image(fromString: image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    private func translateCondition(text: String) -> String {
        return text == "PRODUCT_CONDITION".localized ? "PRODUCT_CONDITION_NEW".localized : "PRODUCT_CONDITION_USED".localized
    }
}

extension ProductCellView: ProductCellViewProtocol {
    func configure(viewModel: ProductCellViewModelProtocol) {
        self.viewModel = viewModel
    }
}
