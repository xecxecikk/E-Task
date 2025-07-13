//
//  ProductListViewController.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    private let viewModel: ProductListViewModel
    private let topBarView = TopBarView()
    private let searchBar = UISearchBar()
    private let filterLabel = UILabel()
    private let filterButton = UIButton(type: .system)
    private let collectionView: UICollectionView
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        bindViewModel()
        viewModel.fetchInitialProducts()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteUpdated(_:)), name: .favoritesUpdated, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.layer.zPosition = 10
        view.bringSubviewToFront(searchBar)
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        searchBar.placeholder = "Search products..."
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.showsCancelButton = false
        
        filterLabel.text = "Filters:"
        filterLabel.font = .systemFont(ofSize: 16)
        filterLabel.textColor = .black
        
        filterButton.setTitle("Select Filter", for: .normal)
        filterButton.backgroundColor = .systemGray3
        filterButton.setTitleColor(.black, for: .normal)
        filterButton.layer.cornerRadius = 4
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        filterButton.addTarget(self, action: #selector(showFilterOptions), for: .touchUpInside)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ProductCardCell.self, forCellWithReuseIdentifier: "ProductCardCell")
        
        loadingIndicator.hidesWhenStopped = true
        
        [topBarView, searchBar, filterLabel, filterButton, collectionView, loadingIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 100),
            
            searchBar.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            filterLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            filterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            filterButton.centerYAnchor.constraint(equalTo: filterLabel.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterButton.widthAnchor.constraint(equalToConstant: 120),
            filterButton.heightAnchor.constraint(equalToConstant: 36),
            
            collectionView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if self.viewModel.filteredProducts.isEmpty {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
                self.collectionView.reloadData()
            }
        }
        
        viewModel.onLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func showFilterOptions() {
        let filterVC = UINavigationController(rootViewController: FilterViewController())
        filterVC.modalPresentationStyle = .pageSheet
        present(filterVC, animated: true)
    }
    
    @objc private func handleFavoriteUpdated(_ notification: Notification) {
        guard
            let product = notification.object as? Product,
            let index = viewModel.filteredProducts.firstIndex(where: { $0.id == product.id })
        else { return }
        
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesUpdated, object: nil)
    }
}

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = viewModel.filteredProducts[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCardCell", for: indexPath) as! ProductCardCell
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let width = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.filteredProducts[indexPath.item]
        let detailVM = ProductDetailViewModel(product: product)
        let detailVC = ProductDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > contentHeight - height - 100 {
            viewModel.fetchMoreProducts()
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
