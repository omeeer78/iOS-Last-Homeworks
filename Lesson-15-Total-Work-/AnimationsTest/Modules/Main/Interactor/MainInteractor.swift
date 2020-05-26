//
//  MainMainInteractor.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import Foundation

protocol MainInteractorInput {
    func getHeroesInfo()
    func delete(hero: HeroDTO)
    func renameHero(by id: Int, with newName: String)
}

protocol MainInteractorOutput: class {
    func didFinishGettingHeroes(with heroes: [HeroDTO])
    func didFinishGettingHeroes(with error: Error)
    func didFinishDeletingHero()
    func didFinishRenamingHero()
}

class MainInteractor: MainInteractorInput {
    
    weak var output: MainInteractorOutput!
    
    var networkManager: NetworkManagerProtocol!
    var dbManager: DBManagerProtocol!
    
    /// Method to get info about heroes
    func getHeroesInfo() {
        
        dbManager.fetchAllHeroes { [weak self] heroes in
            if !heroes.isEmpty {
                self?.output.didFinishGettingHeroes(with: heroes)
            } else {
                self?.networkManager.getHeroesInfo { result in
                    
                    switch result {
                        
                    case .failure(let error):
                        
                        DispatchQueue.main.async {
                            self?.output.didFinishGettingHeroes(with: error)
                        }
                        
                    case .success(let heroes):
                        
                        self?.dbManager.saveArray(of: heroes)
                        
                        DispatchQueue.main.async {
                            self?.output.didFinishGettingHeroes(with: heroes.map({ $0.convertDTO() }))
                        }
                    }
                }
            }
        }
    }
    
    /// Method to delete hero
    /// - Parameter hero: hero which should be deleted
    func delete(hero: HeroDTO) {
        
        dbManager.deleteHero(for: hero.id) {
            self.output.didFinishDeletingHero()
        }
    }
    
    /// Method to rename hero
    /// - Parameters:
    ///   - id: hero id
    ///   - newName: New name for hero
    func renameHero(by id: Int, with newName: String) {
        
        dbManager.renameHero(for: id, with: newName) {
            self.output.didFinishRenamingHero()
        }
    }
}
