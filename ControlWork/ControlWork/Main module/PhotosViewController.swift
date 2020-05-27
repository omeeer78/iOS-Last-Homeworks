//
//  PhotosViewController.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, PhotoPresenterInput {
        
    var dataSource: DataSourceProtocol!
    var presenter: PhotoPresenterOutput!
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cell: UITableViewCell.self)
        table.delegate = self
        table.dataSource = dataSource
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = presenter.title
        
        setupTable()
        
        presenter.obtainPhotos()
    }
    
    func didFinishObtainPhotos(with photos: [Photo]) {
        
        dataSource.photos = photos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFinishObtainCachedPhotos(with photos: [Photo]) {
        dataSource.photos = photos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTable() {
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
}


extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
