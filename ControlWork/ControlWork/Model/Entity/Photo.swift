//
//  Photo.swift
//  ControlWork
//
//  Created by Amir on 15.04.2020.
//  Copyright © 2020 Amir Mardanov. All rights reserved.
//

import RealmSwift

@objcMembers
class Photo: Object, Codable {
    
    dynamic var albumId: Int = 0
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var url: String = ""
    dynamic var thumbnailUrl: String = ""
}
