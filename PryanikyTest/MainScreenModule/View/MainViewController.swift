//
//  MainViewController.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit
import Combine
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Properties -

    var tableView = UITableView()
    var viewModel: MainViewModel?
    private var dataObserver: AnyCancellable?
    private var data: [GlobalData]?

    // MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PryanikyTest"
        fetchDataForCells()
        configureTableView()
        setupLayout()

        dataObserver = viewModel?.$dataSorted.sink(receiveValue: { data in
            self.data = data
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Metods -

    private func configureTableView() {
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didSwipeToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        view.addSubview(tableView)
    }

    @objc private func didSwipeToRefresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        fetchDataForCells()
        tableView.refreshControl?.endRefreshing()
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.top.right.bottom.height.equalToSuperview()
        }
    }

    private func configureAlertController(with array: [Variant]) -> UIAlertController {
        let numberOfVariants = array.count - 1
        let alertController = UIAlertController(title: "Выберете опцию", message: nil, preferredStyle: .alert)

        for variantNumber in 0...numberOfVariants {
            let variantId = String(variantNumber + 1)
            alertController.addAction(UIAlertAction(title: variantId, style: .default, handler: { _ in
                self.viewModel?.pushDetailVC(title: variantId, text: array[variantNumber].text ?? "", imageURL: nil)
            }))
        }

        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        return alertController
    }

    private func fetchDataForCells() {
        viewModel?.getTableData()
    }
}

// MARK: - UITableViewDataSource -

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedData = viewModel?.dataSorted[indexPath.row]
        if let _ = selectedData?.data.url {
            viewModel?.selectRowAt(index: indexPath.row)
        } else if let variants = selectedData?.data.variants {
            let ac = configureAlertController(with: variants)
            present(ac, animated: true, completion: nil)
        } else {
            viewModel?.selectRowAt(index: indexPath.row)
        }
    }
}

// MARK: - UITableViewDataSource -
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseID, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell() }

        let cellData = data?[indexPath.row].name
        cell.setText(with: cellData ?? "Error")

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
