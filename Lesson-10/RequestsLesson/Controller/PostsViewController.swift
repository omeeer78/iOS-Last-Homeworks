//
//  PostsViewController.swift
//  RequestsLesson
//
//  Created by Amir on 14.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class PostsViewController:  UITableViewController {
    
    var safeArea: UILayoutGuide!
    var posts = [PostModel]()
    var user: UserModel!
    var isLoading = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.getPosts { [weak self] postsArray in
            
            self?.posts = postsArray
            
            DataStoreManager.shared.clearAllUserPosts() { isSuccessful in
                
                if isSuccessful {
                    DataStoreManager.shared.saveUserPosts(posts: postsArray)
                }
            }
            self?.isLoading = false
            self?.tableView.reloadData()
        }
        
        DataStoreManager.shared.getUserPosts { [weak self] posts in
            
            self?.posts = posts
            self?.tableView.reloadData()
        }
        
        safeArea = view.layoutMarginsGuide
        setupUI()
    }
    
    func configure(with user: UserModel) {
        self.user = user
    }
    
    func setupUI() {
                
        tableView.backgroundColor = .systemPink
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.cellIdentifier())
        
        title = user.firstName + " " + user.lastName
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(exitButtonPressed))
        navigationItem.setHidesBackButton(true, animated: true)
    }

    @objc func exitButtonPressed() {
        
        NetworkManager.shared.exit { [weak self] in
            DataStoreManager.shared.clearUserData { isCleared in
                self?.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
    }
}

extension PostsViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if tableView.contentOffset.y >= tableView.contentSize.height - tableView.frame.size.height, !isLoading {

            isLoading = true
            
            NetworkManager.shared.getPosts() { [weak self] postsArray in

                if !postsArray.isEmpty {
                    
                    self?.posts += postsArray
                    self?.tableView.reloadData()
                    self?.isLoading = false
                }
            }
        }
    }
}

extension PostsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.cellIdentifier(), for: indexPath) as! PostCell
        
        cell.configureCell(post: posts[indexPath.row], user: user)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
}
