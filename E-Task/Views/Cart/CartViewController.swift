//
//  CartViewController.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let viewModel: CartViewModel
    private let tableView = UITableView()
    private let totalLabel = UILabel()
    private let checkoutButton = PrimaryButton(title: "Checkout")
    private let emptyStateView = EmptyStateView()
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cart"
        setup()
        layout()
        bindViewModel()
        viewModel.reloadCart()
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        tableView.tableFooterView = UIView()
        
        totalLabel.font = Constants.Fonts.bold(size: 18)
        totalLabel.textAlignment = .right
        totalLabel.textColor = .black
        
        checkoutButton.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        
        emptyStateView.configure(message: "No products selected yet")
        
        [tableView, totalLabel, checkoutButton, emptyStateView].forEach {
            view.addSubview($0)
        }
    }
    
    private func layout() {
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinLeading(to: view.leadingAnchor)
        tableView.pinTrailing(to: view.trailingAnchor)
        tableView.pinBottom(to: totalLabel.topAnchor, constant: -Constants.Metrics.verticalPadding)
        
        totalLabel.pinLeading(to: view.leadingAnchor, constant: Constants.Metrics.horizontalPadding)
        totalLabel.pinTrailing(to: view.trailingAnchor, constant: Constants.Metrics.horizontalPadding)
        totalLabel.pinBottom(to: checkoutButton.topAnchor, constant: Constants.Metrics.verticalPadding)
        
        checkoutButton.pinLeading(to: view.leadingAnchor, constant: 16)
        checkoutButton.pinTrailing(to: view.trailingAnchor, constant: 16)
        checkoutButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        
        emptyStateView.pin(to: view)
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        let hasItems = !viewModel.items.isEmpty
        tableView.isHidden = !hasItems
        totalLabel.isHidden = !hasItems
        checkoutButton.isHidden = !hasItems
        emptyStateView.isHidden = hasItems
        
        totalLabel.text = "Total: \(Int(viewModel.totalPrice)) ₺"
        tableView.reloadData()
    }
    
    @objc private func checkoutTapped() {
        viewModel.clearCart()
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        cell.configure(with: item)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = viewModel.items[indexPath.row]
            viewModel.removeItem(item)
        }
    }
}
