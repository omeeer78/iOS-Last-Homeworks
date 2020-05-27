//
//  PostModel.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    
    var id: Int
    var text: String?
    var image: String?
    var likes: Int
    var comments: Int
    var reposts: Int
    var date: Date
}

struct PostResponse: Codable {
    
    let response: Response
    
    func getPosts() -> [PostModel] {
        
        var posts = [PostModel]()        
        
        response.items.forEach({ item in
            
            let postId = item.id
            let postText = item.text
            let postLikes = item.likes.count
            let postComments = item.comments.count
            let postReposts = item.reposts.count
            let postDate = Date(timeIntervalSince1970: TimeInterval(exactly: item.date)!)
            let postImage = item.attachments?.first?.photo.sizes.last?.url
            
            let post = PostModel(id: postId,
                                 text: postText,
                                 image: postImage,
                                 likes: postLikes,
                                 comments: postComments,
                                 reposts: postReposts,
                                 date: postDate)
            posts.append(post)
            
        })
        
        return posts
    }
}

struct Response: Codable {
    
    let count: Int
    let items: [Item]
}

struct Item: Codable {
    
    let id: Int
    let date: Int
    let text: String?
    let attachments: [Attachment]?
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
}

struct Attachment: Codable {
    
    let type: String
    let photo: Photo
}

struct Photo: Codable {
    
    let id: Int
    let sizes: [Size]
    let text: String
    let date: Int
}

struct Size: Codable {
    
    let type: String
    let url: String
}

struct Comments: Codable {
    
    let count: Int
}

struct Likes: Codable {
    
    let count, canLike: Int
}

struct Reposts: Codable {
    
    let count: Int
}
