//
//  TextField.swift
//  RequestsLesson
//
//  Created by Amir on 14.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    private let textFieldBackgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
    private let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                              NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = textFieldBackgroundColor
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        typingAttributes = attributes
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftViewMode = UITextField.ViewMode.always
        layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        layer.borderWidth = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
