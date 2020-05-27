//
//  DataManager.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import RealmSwift

protocol DataManagerProtocol {
    
    func save(photos: [Photo])
    func obtainPhotos() -> [Photo]
    func removeAll()
}

class DataManager: DataManagerProtocol {
    
    fileprivate lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func save(photos: [Photo]) {
        
        for i in 0...14 {
            try! realm.write {
                realm.add(photos[i])
            }
        }
    }
    
    func obtainPhotos() -> [Photo] {
        
        var photos = [Photo]()
        
        realm.objects(Photo.self).forEach({ photo in
            photos.append(photo)
        })
    
        return photos
    }
    
    func removeAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
