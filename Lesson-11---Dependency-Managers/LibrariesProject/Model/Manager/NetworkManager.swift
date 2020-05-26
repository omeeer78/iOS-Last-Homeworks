//
//  NetworkManager.swift
//  LibrariesProject
//
//  Created by Amir on 02.03.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Alamofire

protocol NetworkManagerProtocol {
    
    /// Method that retrieves information about heroes
    /// - Parameter completion: Block called when data is received successfully
    func getHeroesInfo(completion: @escaping (GetHeroesResult) -> Void)
}

enum GetHeroesResult {
    case success(heroes: [Hero])
    case failure(error: Error)
}

class NetworkManager: NetworkManagerProtocol {
    
    /// Api link for get all heroes info
    private let allURL = "https://cdn.rawgit.com/akabab/starwars-api/0.2.1/api/all.json"
    
    func getHeroesInfo(completion: @escaping (GetHeroesResult) -> Void) {
            
        guard let apiUrl = URL(string: allURL) else { return }
        
        AF.request(apiUrl).responseDecodable(of: [Hero].self) { response in
            
            var result: GetHeroesResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if response.error == nil {
                guard let heroesArray = response.value else {
                    result = .success(heroes: [])
                    return }
                result = .success(heroes: heroesArray)
            } else {
                result = .failure(error: response.error!)
            }
        }
    }
}
