//
//  ProductDetailView.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

final class ProductDetailView: UIViewController {
    
    @IBOutlet weak var prodTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    var viewModel: ProductDetailViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureDelegates()
        fetchProductDetail()
    }
    
    private func configureNavBar() {
        title = "PRODUCT_DETAIL_TITLE".localized
        self.navigationController?.navigationBar.tintColor = .black 
    }
    
    private func configureDelegates() {
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
    }
    
    private func fetchProductDetail() {
        view.showLoadingView(activityColor: .gray, backgroundColor: .white)
        
        viewModel?.getProductDetail() { [weak self] response in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    self?.configureUI()
                    self?.imagesCollection.reloadData()
                    self?.view.hideLoadingView()
                }
            case .failure:
                self?.showErrorWithMessage("PRODUCTS_ERROR_MSG".localized) {
                    self?.view.hideLoadingView()
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func configureUI() {
        guard let viewModel = viewModel else { return }
        descriptionTitle.text = "DESCRIPTION_MSG".localized
        prodTitle.text = viewModel.modelDetail?.title
        price.text = String("$ \(Int(viewModel.modelDetail?.price ?? 0))")
        descriptionLbl.text = viewModel.modelDescrip?.description
    }
    
}

extension ProductDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.modelDetail?.pictures.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsImagesCell", for: indexPath) as! ProductDetailCollectionViewCell

        cell.picture = viewModel?.modelDetail?.pictures[indexPath.item]
        
        return cell
    }
    
}
