//
//  MainCoordinator.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit

enum Destination {
    case main
    case detail(GlobalData)
}

protocol DetailCoordinating: AnyObject {
    func popTo(_ destination: Destination)
}

protocol MainCoordinating: AnyObject {
    func pushTo(_ destination: Destination)
}

class MainCoordinator: Coordinatable {

    // MARK: - Properties -

    weak var parent: Coordinatable?
    var childCoordinators: [Coordinatable] = []

    // MARK: - Private properties -

    private let navigationController: UINavigationController


    // MARK: - Initializer -

    init(navigationController: UINavigationController, parent: Coordinatable? = nil) {
        self.navigationController = navigationController
        self.parent = parent
    }

    // MARK: - Public Methods -

    func start() {
        let viewController = ScreenBuilder.createMainModule(self)
        navigationController.pushViewController(viewController, animated: true)
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }
}

    // MARK: - DetailCoordinating -

extension MainCoordinator: DetailCoordinating {
    func popTo(_ destination: Destination) {
        switch destination {
        case .main:
            guard let viewController = navigationController.viewControllers.first(where: { viewController in
                viewController is MainViewController }) else { return }
            viewController.viewDidLoad()
            navigationController.popToViewController(viewController, animated: true)
        case .detail:
            break
        }
    }
}

    // MARK: - MainCoordinating -

extension MainCoordinator: MainCoordinating {
    func pushTo(_ destination: Destination) {
        switch destination {
        case .main:
            break
        case .detail(let model):
            let viewController = ScreenBuilder.createDetailModule(model, self)
            navigationController.pushViewController(viewController, animated: true)
            childCoordinatorWillStart(self)
        }
    }
}
