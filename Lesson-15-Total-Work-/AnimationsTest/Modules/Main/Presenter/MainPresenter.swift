//
//  MainMainPresenter.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import Foundation

class MainPresenter: MainViewOutput, MainInteractorOutput, MainRouterOutput {
            
    var navTitle: String {
        return "Heroes"
    }
    
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    var dataSource: MainDataSourceInput!

    //MARK: - MainViewOutput
    
    func viewIsReady() {
        interactor.getHeroesInfo()
    }
    
    func loadHeroes() {
        interactor.getHeroesInfo()
    }
    
    func didActivateDeleteAction(at indexPath: IndexPath) {
        interactor.delete(hero: dataSource.heroes[indexPath.row])
    }
    
    func didLongPressedOnCell(at indexPath: IndexPath) {
        
        let hero = dataSource.heroes[indexPath.row]
        print(hero)
        view.triggerHapticFeedback()
    }
    
    func didActivateRenameAction(at indexPath: IndexPath) {
        router.showHeroRenameAlert(with: dataSource.heroes[indexPath.row].name, for: indexPath)
    }
    
    //MARK: - MainInteractorOutput
    
    func didFinishGettingHeroes(with heroes: [HeroDTO]) {
        
        view.set(dataSource: dataSource)
        dataSource.heroes = heroes
        view.reloadTable()
    }
    
    func didFinishGettingHeroes(with error: Error) {
        print(error.localizedDescription)
    }
    
    func didFinishDeletingHero() {
        view.didFinishedEditingHeroes()
    }
    
    func didFinishRenamingHero() {
        view.didFinishedEditingHeroes()
    }
    
    //MARK: - MainRouterOutput
    
    func didEnterNewHero(name: String, for indexPath: IndexPath) {
        interactor.renameHero(by: dataSource.heroes[indexPath.row].id, with: name)
    }
    
}
