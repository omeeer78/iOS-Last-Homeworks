//
//  UserModel.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation


struct UserResponse: Codable {
    let response: [UserModel]
}

struct UserModel {
    
    var id: Int
    var firstName: String
    var lastName: String
    var photo: String?
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo
        
    }    
}

extension UserModel: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        photo = try container.decode(String.self, forKey: .photo)
        token = ""
    }
}

extension UserModel: Encodable {
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(photo, forKey: .photo)
    }
}
