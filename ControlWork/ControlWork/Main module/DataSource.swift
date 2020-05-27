//
//  DataSource.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import Kingfisher

protocol DataSourceProtocol: UITableViewDataSource {
    var photos: [Photo] { get set }
}

class DataSource: NSObject, DataSourceProtocol {
    
    var photos = [Photo]()
    private let placeholderImageName = "placeholder"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        
        let photo = photos[indexPath.row]
        let url = URL(string: photo.url)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = photo.title
        
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named: self.placeholderImageName))        
        
        cell.selectionStyle = .none
        
        return cell
    }
}
