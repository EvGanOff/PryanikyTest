//
//  DetailViewModel.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/26/22.
//

import Foundation

class DetailViewModel {

    // MARK: - Properties -
    
    var data: GlobalData?
    weak var coordinator: MainCoordinator?
    var view: DetailViewController?

    // MARK: - Initializer -

    required init(view: DetailViewController?) {
        self.view = view
    }
}
