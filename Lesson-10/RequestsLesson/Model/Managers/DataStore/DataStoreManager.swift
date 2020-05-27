//
//  DataStoreManager.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import CoreData

class DataStoreManager {
    
    static let shared: DataStoreManager = DataStoreManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RequestsLesson")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - User manage methods
    func saveUserData(user: UserModel, token: String) {
        
        DispatchQueue.global().async { [weak self] in
            
            let userModel = User(context: self!.persistentContainer.viewContext)                        
            userModel.id = Int64(user.id)
            userModel.firstName = user.firstName
            userModel.lastName = user.lastName
            userModel.avatarURL = user.photo
            userModel.token = token
            
            self?.saveContext()
        }
    }
        
    func getUserData(completion: @escaping (UserModel?) -> Void) {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        DispatchQueue.global().async { [weak self] in
            
            if let user = try? self?.persistentContainer.viewContext.fetch(fetchRequest).first {
                DispatchQueue.main.async {
                    completion(user.convertToUserModel())
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    //MARK: - Posts manage methods
    func saveUserPosts(posts: [PostModel]) {
        
        DispatchQueue.global().async { [weak self] in
            
            posts.forEach({ post in
                let postModel = Post(context: (self?.persistentContainer.viewContext)!)            
                postModel.postId = Int64(post.id)
                postModel.text = post.text
                postModel.repostsCount = Int64(post.reposts)
                postModel.commentsCount = Int64(post.comments)
                postModel.likesCount = Int64(post.likes)
                postModel.date = post.date
                postModel.imageURL = post.image
            })
            
            self?.saveContext()
        }
    }
    
    func getUserPosts(completion: @escaping ([PostModel]) -> Void) {
        
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        DispatchQueue.global().async { [weak self] in
            
            if let posts = try? self?.persistentContainer.viewContext.fetch(fetchRequest), !posts.isEmpty {
                
                DispatchQueue.main.async {
                    completion(posts.map({ $0.convertToPostModel() }))
                }
            } else {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    // MARK:- Deleting functions
    
    func clearAllUserPosts(completion: @escaping (Bool) -> Void) {
        
        DispatchQueue.global().async { [weak self] in
            
            let userPostsDeleteRequest = NSBatchDeleteRequest(fetchRequest: Post.fetchRequest())
                                    
            do {
                
                try self?.persistentContainer.viewContext.execute(userPostsDeleteRequest)
                
                self?.saveContext()
                
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
    }

    func clearUserData(completion: @escaping (Bool) -> Void) {
        
        DispatchQueue.global().async { [weak self] in
                        
            let userDataDeleteRequest = NSBatchDeleteRequest(fetchRequest: User.fetchRequest())
            let userPostsDeleteRequest = NSBatchDeleteRequest(fetchRequest: Post.fetchRequest())
            
            do {
                
                try self?.persistentContainer.viewContext.execute(userDataDeleteRequest)
                try self?.persistentContainer.viewContext.execute(userPostsDeleteRequest)
                
                self?.saveContext()
                
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
    }
}

extension User {
    
    func convertToUserModel() -> UserModel {
        
        return UserModel(id: Int(self.id),
                         firstName: self.firstName ?? "",
                         lastName: self.lastName ?? "",
                         photo: self.avatarURL ?? "",
                         token: self.token ?? "")
    }
}

extension Post {
    
    func convertToPostModel() -> PostModel {
        
        return PostModel(id: Int(self.postId),
                         text: self.text ?? "",
                         image: self.imageURL ?? "",
                         likes: Int(self.likesCount),
                         comments: Int(self.commentsCount),
                         reposts: Int(self.repostsCount),
                         date: self.date ?? Date(timeIntervalSince1970: TimeInterval(exactly: 0)!))
    }
}
