//
//  NetworkManager.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import Alamofire

protocol NetworkManagerProtocol {
    func fetchPhotos(completion: @escaping ([Photo]) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    private let apiUrl = "https://jsonplaceholder.typicode.com/photos"
    
    func fetchPhotos(completion: @escaping ([Photo]) -> Void ) {
       
        guard let url = URL(string: apiUrl) else { return }
        
        AF.request(url).responseDecodable(of: [Photo].self) { response in
            
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            
            guard let photos = response.value else { return }
            
            DispatchQueue.main.async {
                completion(photos)
            }
        }
    }
}
