//
//  AppCoordinator.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    var parent: Coordinatable? { get set }

    func start()
    func pop()
    func childCoordinatorWillStart(_ chlid: Coordinatable)
    func childCoordinatorDidFinish(_ child: Coordinatable)
}

extension Coordinatable {
    func childCoordinatorWillStart(_ chlid: Coordinatable) {
      guard !childCoordinators.contains(where: { $0 === chlid }) else { return }
      childCoordinators.append(chlid)
    }

    func childCoordinatorDidFinish(_ child: Coordinatable) {
        guard childCoordinators.isEmpty == false else { return }

        for (index, element) in childCoordinators.enumerated() where element === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}

class AppCoordinator: Coordinatable {

    // MARK: - Properties -

    var childCoordinators: [Coordinatable] = []
    var parent: Coordinatable?
    private let navigationController: UINavigationController

    // MARK: - Initializer -

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let coordinator = MainCoordinator(navigationController: navigationController, parent: self)
        coordinator.start()
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }
}
