//
//  ProductCell.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

class ProductCellView: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCondition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    func configure(viewModel: ProductCellViewModel) {
        self.productTitle.numberOfLines = 0
        self.productTitle.text = viewModel.title
        self.productPrice.text = String("$ \(Int(viewModel.price))")
        self.productCondition.textColor = .orange
        self.productCondition.text = translateCondition(text: viewModel.condition)
        self.productImage.image(fromString: viewModel.image!)
    }
    
    private func translateCondition(text: String) -> String {
        return text == "new" ? "Nuevo": "Usado"
    }
}
