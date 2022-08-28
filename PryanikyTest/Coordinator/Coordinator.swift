//
//  Coordinator.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
    func pop()
}

class Coordinator: Coordinatable {

    var childCoordinators: [Coordinatable] = []
    var parent: Coordinatable?

    // MARK: - Properties -

    private let navigationController: UINavigationController

    // MARK: - Initializer -

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods -

    func start() {
        let coordinator = MainCoordinator(navigationController: navigationController, parent: self)
        coordinator.start()
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }
}
