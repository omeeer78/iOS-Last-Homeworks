//
//  UIImageView+Extension.swift
//  LibrariesProject
//
//  Created by Amir on 08.03.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Custom initializer for UIImageView
    /// - Parameters:
    ///   - roundCorners: rounding indicator
    ///   - cornerRadius: radius for corner rounding
    convenience init(roundCorners: Bool = false, cornerRadius: CGFloat = 0) {
        self.init()                
        
        guard roundCorners else { return }
     
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
