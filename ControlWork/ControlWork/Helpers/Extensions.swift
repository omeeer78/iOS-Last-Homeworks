//
//  Extensions.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import UIKit

extension UITableViewCell {
     
     static var identifier: String {
          return String(describing: self)
     }
}

extension UITableView {
     
     func register(cell: UITableViewCell.Type) {
          self.register(cell, forCellReuseIdentifier: cell.identifier)
     }
}

