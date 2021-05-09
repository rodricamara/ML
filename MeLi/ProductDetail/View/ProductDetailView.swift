//
//  ProductDetailView.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

class ProductDetailView: UIViewController {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
    }
    
    private func configureNavBar() {
        title = "Detalle del Producto"
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureUI() {
        productTitle.text = product?.title
    }

}
