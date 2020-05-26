//
//  UIButton+Extension.swift
//  AnimationsTest
//
//  Created by Amir on 11.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit


extension UIButton {
    
    class func closeBtn() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1411764706, green: 0.1490196078, blue: 0.1764705882, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }
}
