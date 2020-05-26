//
//  MainMainRouter.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import UIKit

protocol MainRouterInput {
    func showHeroRenameAlert(with heroName: String, for indexPath: IndexPath)
}

protocol MainRouterOutput: AnyObject {
    func didEnterNewHero(name: String, for indexPath: IndexPath)
}

class MainRouter: MainRouterInput {
        
    weak var view: UIViewController!
    weak var output: MainRouterOutput!
    
    //MARK: - MainRouterInput
 
    func showHeroRenameAlert(with heroName: String, for indexPath: IndexPath) {
        
        let title = "Rename \(heroName)"
        let okTitle = "Ok"
        let cancelTitle = "Cancel"
        let textFieldPlaceholder = "Enter new name here"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
        
            textField.text = heroName
            textField.placeholder = textFieldPlaceholder
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { [weak self] action in
            
            guard let name = alert.textFields?.first?.text, name != heroName, name != "" else { return }
            
            self?.output.didEnterNewHero(name: name, for: indexPath)
            
        }
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        alert.addAction(okAction)
        
        view.present(alert, animated: true)        
    }
}
