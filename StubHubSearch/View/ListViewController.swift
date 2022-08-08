//
//  ListViewController.swift
//  StubHubSearch
//
//  Created by HT on 07/08/22.
//

import Foundation
import UIKit

protocol ListViewModelable: AnyObject {
    var filterIsOn: Bool { get}
    var dataSource: [PresentableEvents] { get }
    var filteredDatasource: [PresentableEvents] { get}
    func viewLoaded()
    func searchData(cityText: String?, pricetext: String?)
}

final class ListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewModel: ListViewModelable

    init(viewModel: ListViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView.register(
            StubListCell.self,
            forCellReuseIdentifier: StubListCell.identifier)
        configureViews()
        configureConstraints()
        configureDelegates()
        //configureSearchController()
        viewModel.viewLoaded()
    }

    private func configureViews() {
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        let filterButton = UIBarButtonItem(
            title: "Filter", style: .plain, target: self,
            action: #selector(barButtonItemClicked))

        self.navigationItem.rightBarButtonItem  = filterButton
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func barButtonItemClicked() {
        let vc = FilterViewController()
        vc.filterDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)

    }
}

// MARK: - UITableViewDelegate/DataSource Methods
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterIsOn ?
        viewModel.filteredDatasource.count : viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StubListCell.identifier,
            for: indexPath
        ) as? StubListCell else {
            return UITableViewCell()
        }
        let item = viewModel.filterIsOn ? viewModel.filteredDatasource[indexPath.row] : viewModel.dataSource[indexPath.row]
        cell.configureCell(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension ListViewController: ListViewPresenter {
    func showEvents() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        print(error)
    }
}

extension ListViewController: FilterAndSearchDelegate {
    func filter(cityText: String?, priceText: String?) {
        viewModel.searchData(cityText: cityText, pricetext: priceText)
    }
}
