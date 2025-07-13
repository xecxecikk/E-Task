//
//  FilterViewController.swift
//  E-Task
//
//  Created by XECE on 13.07.2025.
//

import UIKit

final class FilterViewController: UIViewController {
    
    private let sortOptions = ["Old to new", "New to old", "Price high to low", "Price low to High"]
    private let brands = ["Mercedes", "Bentley", "Dodge", "Ford"]
    private let models = ["Focus", "XC90", "Fortwo"]
    
    private var selectedSortIndex: Int?
    private var selectedBrands: Set<String> = []
    private var selectedModels: Set<String> = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let applyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Filter"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTapClose)
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.backgroundColor = .systemBlue
        applyButton.layer.cornerRadius = 8
        applyButton.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -16),
            
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapApply() {
        print("Applied filters: \(selectedSortIndex ?? -1), Brands: \(selectedBrands), Models: \(selectedModels)")
        dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return sortOptions.count
        case 1: return brands.count
        case 2: return models.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Sort By"
        case 1: return "Brand"
        case 2: return "Model"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = sortOptions[indexPath.row]
            cell.accessoryType = selectedSortIndex == indexPath.row ? .checkmark : .none
        case 1:
            let brand = brands[indexPath.row]
            cell.textLabel?.text = brand
            cell.accessoryType = selectedBrands.contains(brand) ? .checkmark : .none
        case 2:
            let model = models[indexPath.row]
            cell.textLabel?.text = model
            cell.accessoryType = selectedModels.contains(model) ? .checkmark : .none
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedSortIndex = indexPath.row
        case 1:
            let brand = brands[indexPath.row]
            if selectedBrands.contains(brand) {
                selectedBrands.remove(brand)
            } else {
                selectedBrands.insert(brand)
            }
        case 2:
            let model = models[indexPath.row]
            if selectedModels.contains(model) {
                selectedModels.remove(model)
            } else {
                selectedModels.insert(model)
            }
        default:
            break
        }
        
        tableView.reloadSections([indexPath.section], with: .automatic)
    }
}
