//
//  ProfileImageView.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        translatesAutoresizingMaskIntoConstraints = false        
        contentMode = .scaleAspectFill
        backgroundColor = .red
        heightAnchor.constraint(equalToConstant: 43).isActive = true
        widthAnchor.constraint(equalToConstant: 43).isActive = true
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
