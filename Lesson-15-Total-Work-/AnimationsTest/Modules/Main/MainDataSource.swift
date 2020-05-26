//
//  MainDataSource.swift
//  AnimationsTest
//
//  Created by Amir on 05.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

protocol MainDataSourceInput: UITableViewDataSource {
    var heroes: [HeroDTO] {get set}
}

protocol MainDataSourceOutput {
    
}


class MainDataSource: NSObject, MainDataSourceInput {
    
    var heroes: [HeroDTO] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HeroCell = tableView.dequeueTypedCell(for: indexPath)
        cell.configure(with: heroes[indexPath.row])
        
        return cell
    }
}
