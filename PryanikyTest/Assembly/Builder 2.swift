//
//  Builder.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit

protocol AssemblyProtocol {
    static func createMainModule(_ coordinator: MainCoordinator) -> UIViewController
    static func createDetailModule(_ model: GlobalData?, _ coordinator: MainCoordinator) -> UIViewController
}

class ScreenBuilder: AssemblyProtocol {

    static func createMainModule(_ coordinator: MainCoordinator) -> UIViewController {
        let viewController = MainViewController()
        let networkManager = NetworkManager()
        let viewModel = MainViewModel(coordinator: coordinator, networkManager: networkManager, view: viewController)

        viewController.viewModel = viewModel
        viewModel.coordinator = coordinator

        return viewController
    }

    static func createDetailModule(_ model: GlobalData?, _ coordinator: MainCoordinator) -> UIViewController {
        let viewController = DetailViewController(title: "", text: "", imageURL: nil)
        let viewModel = DetailViewModel(view: viewController)

        viewModel.coordinator = coordinator
        viewModel.data = model
        viewController.viewModel = viewModel
        
        return viewController
    }
}
