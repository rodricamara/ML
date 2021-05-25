//
//  ProductDetailView.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

class ProductDetailView: UIViewController {
    
    @IBOutlet weak var prodTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    
    var product: Product?
    var viewModel: ProductDetailViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        viewModel = ProductDetailViewModel()
        fetchProductDetail()
    }
    
    private func configureNavBar() {
        title = "PRODUCT_DETAIL_TITLE".localized
        self.navigationController?.navigationBar.tintColor = .black 
    }
    
    private func fetchProductDetail() {
        guard let id = product?.id else { return }
        view.showLoadingView(activityColor: .gray, backgroundColor: .white)
        viewModel?.getProductDetail(with: id, completion: { [weak self] response in
            switch response {
            case .success:
                self?.viewModel?.getProductDescription(with: id, completion: { [weak self] (response) in
                    switch response {
                    case .success:
                        DispatchQueue.main.async {
                            self?.configureUI()
                        }
                    case .failure:
                        print("error")
                    }
                })

            case .failure:
                print("error")
            }
        })
    }
    
    private func configureUI() {
        guard let viewModel = viewModel else { return }
        descriptionTitle.text = "DESCRIPTION_MSG".localized
        prodTitle.text = viewModel.prodDetail.title
        //image.image(fromString: viewModel?.prodDetail.pictures.first)
        //image.image(fromString: product.imageURL)
        price.text = String("$ \(Int(viewModel.prodDetail.price))")
        descriptionLbl.text = viewModel.prodDescrip.description
        view.hideLoadingView()
    }

}
