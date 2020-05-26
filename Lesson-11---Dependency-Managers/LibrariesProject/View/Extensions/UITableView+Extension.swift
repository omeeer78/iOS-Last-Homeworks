//
//  UITableView+Extension.swift
//  LibrariesProject
//
//  Created by Amir on 08.03.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// Variable that returns cell identifier
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    /// Method, that register cell
    /// - Parameter cell: cell for registration
    func register(cell: UITableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.identifier)
    }
}
