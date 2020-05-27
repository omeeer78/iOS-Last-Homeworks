//
//  PhotosPresenter.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import Foundation

protocol PhotoPresenterInput: AnyObject {
    func didFinishObtainPhotos(with photos: [Photo])
    func didFinishObtainCachedPhotos(with photos: [Photo])
}

protocol PhotoPresenterOutput: AnyObject {
    func obtainPhotos()
    var title: String { get }
}

class PhotosPresenter: PhotoPresenterOutput {
    
    var title: String {
        return "Photos"
    }
    
    func obtainCachePhotos() {
        let photos = dataManager.obtainPhotos()
        view.didFinishObtainCachedPhotos(with: photos)
    }
    
    weak var view: PhotoPresenterInput!
    var networkManager: NetworkManager!
    var dataManager: DataManagerProtocol!
    
    func obtainPhotos() {
        
        networkManager.fetchPhotos { [weak self] photosArray in
            
            DispatchQueue.main.async {
                self?.view.didFinishObtainPhotos(with: photosArray)
            }
            self?.dataManager.removeAll()
            self?.dataManager.save(photos: photosArray)
        }
    }
    
}
