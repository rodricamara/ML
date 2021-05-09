//
//  ProductDetailView.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

class ProductDetailView: UIViewController {

    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        title = "Detalle del Producto"
        self.navigationController?.navigationBar.tintColor = .black
    }

}
