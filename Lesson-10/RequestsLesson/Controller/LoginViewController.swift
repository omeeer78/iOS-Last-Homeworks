//
//  LoginViewController.swift
//  RequestsLesson
//
//  Created by Amir on 28.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    let url = "https://oauth.vk.com/authorize?client_id=7247861&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=token&v=5.52"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self        
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addWebViewLayouts()
        title = "Войти в VK"
        
        guard let vkUrl = URL(string: url) else { return }
        
        webView.load(URLRequest(url: vkUrl))
    }
        
    func addWebViewLayouts() {
        
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        if let urlString = webView.url?.absoluteString.replacingOccurrences(of: "#", with: "?"),
            let urlParams = URL(string: urlString)?.queryParameters,
            let token = urlParams["access_token"] {
            
            NetworkManager.shared.authToken = token
            
            let destVC = PostsViewController()
            
            NetworkManager.shared.getUser { [weak self] user in
                DataStoreManager.shared.saveUserData(user: user, token: token)
                destVC.user = user
                self?.navigationController?.pushViewController(destVC, animated: true)
            }
        }
    }
}

extension URL {
    /// extracts query parameters from GET request as a dictionary
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
