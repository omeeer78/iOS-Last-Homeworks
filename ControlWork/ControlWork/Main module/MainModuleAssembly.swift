//
//  MainModuleAssembly.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import UIKit

class MainModuleAssembly {
    
    class func configuredView() -> UIViewController {
     
        let view = PhotosViewController()
        let presenter = PhotosPresenter()
        let dataSource = DataSource()
        let networkManager = NetworkManager()
        
        let dataManager = DataManager()
        
        view.presenter = presenter
        view.dataSource = dataSource
        
        presenter.dataManager = dataManager
        presenter.view = view
        presenter.networkManager = networkManager
        
        return view
    }
}
