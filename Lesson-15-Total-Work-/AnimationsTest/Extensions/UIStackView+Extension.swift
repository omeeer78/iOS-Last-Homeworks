//
//  UIStackView+Extension.swift
//  LibrariesProject
//
//  Created by Amir on 08.03.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

extension UIStackView {
    
    /// Custom initializer for UIStackView
    /// - Parameters:
    ///   - views: arranged subviews array
    ///   - axis: stack view axis
    ///   - spacing: spacing between views
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: views)
                
        self.axis = axis
        self.spacing = spacing
    }    
}

