//
//  AuthorizationViewController.swift
//  RequestsLesson
//
//  Created by Amir on 14.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    private let mainVKColor = #colorLiteral(red: 0.2773358226, green: 0.4431029558, blue: 0.7284063697, alpha: 1)
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "vkLogoWhite")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(mainVKColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(authButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func authButtonPressed() {
        print("Tapped")
        navigationController?.pushViewController(PostsViewController(), animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = #colorLiteral(red: 0.2912331223, green: 0.5033848882, blue: 0.7445880175, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        
        addConstraints()
    }
    
    private func addConstraints() {
        
        view.addSubview(logoImageView)
        view.addSubview(button)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
                
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
