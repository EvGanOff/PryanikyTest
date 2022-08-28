//
//  MainViewModel.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit
import Combine

class MainViewModel {
    
    // MARK: - Properties -

    @Published private(set) var dataSorted: [GlobalData] = []
    var coordinator: MainCoordinator?
    var networkManager: NetworkManager?
    var view: MainViewController?

    // MARK: - Initializer -
    
    required init(coordinator: MainCoordinator?, networkManager: NetworkManager?, view: MainViewController?) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.view = view
    }
}

extension MainViewModel {

    // MARK: - Metods -

    private func sortingData(data: [GlobalData], sortingArray: [String]) -> [GlobalData] {
        var dictionary = [String: GlobalData]()
        data.forEach { dictionary[$0.name] = $0 }
        let newData = sortingArray.compactMap { dictionary[$0] }

        return newData
    }

    func getTableData() {
        networkManager?.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let dataToShow = data.data
                let dataOrder = data.view
                let newData = self.sortingData(data: dataToShow, sortingArray: dataOrder)
                self.dataSorted = newData

                DispatchQueue.main.async {
                    self.view?.tableView.reloadData()
                }

            case .failure(let error):
                print(error.errorDescription ?? "Error")
            }
        }
    }

    func pushDetailVC(title: String?, text: String?, imageURL: String?) {
        view?.navigationController?.pushViewController(DetailViewController(title: title ?? "" , text: text ?? "", imageURL: imageURL), animated: true)
    }

    func selectRowAt(index: Int) {
        coordinator?.pushTo(.detail(dataSorted[index]))
    }
}
