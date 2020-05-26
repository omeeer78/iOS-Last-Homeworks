//
//  DBManager.swift
//  AnimationsTest
//
//  Created by Amir on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import RealmSwift

protocol DBManagerProtocol {
    
    /// Method to save heroes array to database
    /// - Parameter heroes: array of heroes to save
    func saveArray(of heroes: [Hero])
    
    /// Method to rename hero
    /// - Parameters:
    ///   - key: hero id
    ///   - newName: new hero name
    ///   - completion:  completion which executes after hero renamed
    func renameHero(for key: Int, with newName: String, completion: @escaping () -> Void)
    
    /// Method to delete hero from database
    /// - Parameters:
    ///   - key: user id
    ///   - completion:  completion which executes after hero deleted
    func deleteHero(for key: Int, completion: @escaping () -> Void)
        
    /// Method to get heroes from database
    /// - Parameter completion: completion which executes after heroes fetched
    func fetchAllHeroes(completion: @escaping ([HeroDTO]) -> Void)
}

class DBManager: DBManagerProtocol {
    
    private lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func saveArray(of heroes: [Hero]) {
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            
            try? self?.realm.write {
                for index in 0 ... 19 {
                    self?.realm.add(heroes[index].convertToRealmModel())
                }
            }
        }
    }
    
    func renameHero(for key: Int, with newName: String, completion: @escaping () -> Void) {
        
        guard let objectToEdit = self.realm.object(ofType: RealmHero.self, forPrimaryKey: key) else { return }
        
        try? realm.write {
            objectToEdit.name = newName
            realm.add(objectToEdit, update: .modified)
        }
        completion()
    }
        
    func deleteHero(for key: Int, completion: @escaping () -> Void) {
        
        guard let objectToDelete = self.realm.object(ofType: RealmHero.self, forPrimaryKey: key) else { return }
        
        try? self.realm.write {
            self.realm.delete(objectToDelete)
        }
        completion()
        
    }
    
    func fetchAllHeroes(completion: @escaping ([HeroDTO]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            let objects = Array(realm.objects(RealmHero.self)
                .sorted(byKeyPath: #keyPath(RealmHero.id), ascending: true))
                .map({ $0.convertTDTO()})
            
            DispatchQueue.main.async {
                completion(objects)
            }
        }
    }
}
