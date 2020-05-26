//
//  MainMainConfigurator.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import UIKit

class MainModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? MainViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: MainViewController) {

        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        let dataSource = MainDataSource()
        let networkManager = NetworkManager()
        let dbManager = DBManager()
        
        viewController.output = presenter
        
        interactor.output = presenter
        interactor.networkManager = networkManager
        interactor.dbManager = dbManager
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.dataSource = dataSource
        
        router.view = viewController
        router.output = presenter
    }

}
