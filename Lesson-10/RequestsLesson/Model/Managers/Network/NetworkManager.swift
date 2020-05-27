//
//  NetworkManager.swift
//  RequestsLesson
//
//  Created by Amir on 15.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//


import WebKit

class NetworkManager {
    
    //MARK: - Singleton
    static let shared = NetworkManager()
    
    //MARK: - Properties
    private let initialLimit = 10
    var authToken: String = ""
    var postsOffset = 0
    var fetchLimit = 10
    
    //MARK: - Get data
    func getUser(completion: @escaping (UserModel) -> Void) {
        
        let methodURL = "https://api.vk.com/method/users.get?fields=photo&access_token=\(authToken)&v=5.103"
        
        guard let url = URL(string: methodURL) else { return }
        
        URLSession.shared.dataTask(with: url) {  data, response, error in
            
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(UserResponse.self, from: data), let user = response.response.first {
                
                DispatchQueue.main.async {
                    completion(user)
                }
            } else {
                print("Error: Cannot decode JSON response")
            }
        }.resume()
    }
    
    func getPosts(completion: @escaping ([PostModel]) -> Void) {
        
        let methodURL = "https://api.vk.com/method/wall.get?count=\(fetchLimit)&offset=\(postsOffset)&filter=owner&access_token=\(authToken)&v=5.103&extended=1"
        
        guard let url = URL(string: methodURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            self?.postsOffset = self!.fetchLimit + 1
            self?.fetchLimit += (self?.initialLimit)!
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let response = try? decoder.decode(PostResponse.self, from: data) {
                
                if response.getPosts().isEmpty {
                    self?.fetchLimit -= (self?.initialLimit)!
                }
                DispatchQueue.main.async {
                    completion(response.getPosts())
                }
            }
        }.resume()
    }
    
    func getImage(from urlString: String, completion: @escaping (Data) -> Void) {
          
          guard let url = URL(string: urlString) else { return }
          
          URLSession.shared.dataTask(with: url) { (data, response, error) in
              
              if let error = error {
                  print(error.localizedDescription)
                  return
              }
              
              guard let data = data else { return }
              
              DispatchQueue.main.async {
                  completion(data)
              }
          }.resume()
      }
    //MARK: - Exit from account
    func exit(completion: @escaping () -> Void) {
        
        fetchLimit = initialLimit
        postsOffset = 0
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { dataRecords in
            
            WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
                                                    for: dataRecords,
                                                    completionHandler: completion)
        }
    }
}
