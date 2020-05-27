//
//  Extensions.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

extension PostCell {
    
    static func cellNibName() -> UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach({ view in
            addSubview(view)
        })
    }
}
