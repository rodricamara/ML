//
//  ViewController.swift
//  MeLi
//
//  Created by Rodrigo Camara on 07/05/2021.
//

import UIKit

class ProductsView: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var productTableView: UITableView!
    
    var viewModel: ProductViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureSearchBar()
        configureProductsTableView()
        viewModel = ProductViewModel()
    }
    
    private func configureNavBar() {
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.barTintColor = .yellow
    }
    
    private func  configureSearchBar() {
        searchBar.placeholder = "SEARCH_BAR_PLACEHOLDER".localized
        searchBar.delegate = self
    }
    
    private func configureProductsTableView() {
        let nib = UINib(nibName: "ProductCellView", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "ProductCellView")
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.allowsSelection = true
        productTableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productSelected = sender as? Product else {
            return
        }
        guard let prodDetailVC = segue.destination as? ProductDetailView else {
            return
        }
        navigationItem.backBarButtonItem = UIBarButtonItem()
        prodDetailVC.product = productSelected
    }
    
}

extension ProductsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.productsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellView") as? ProductCellView, let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(viewModel: ProductCellViewModel(product: viewModel.productsList[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = viewModel?.productsList[indexPath.row] else {
            return
        }
        self.performSegue(withIdentifier: "showProductDetail", sender: product)
    }
}

extension ProductsView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        guard let formatedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), text.count >= 1 else {
            return
        }
        
        view.showLoadingView(activityColor: .gray, backgroundColor: .white)
        viewModel?.getProducts(using: formatedText, completion: { [weak self] (response) in
            switch response {
            case .success:
                break
            case .empty:
                DispatchQueue.main.async {
                    self?.showErrorWithMessage("PRODUCTS_NO_RESULT_MSG".localized, completion: {
                        searchBar.text = ""
                    })
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showErrorWithMessage("PRODUCTS_ERROR_MSG".localized)
                }
            }
            DispatchQueue.main.async {
                self?.productTableView.reloadData()
                self?.view.hideLoadingView()
            }
        })
    }
}
