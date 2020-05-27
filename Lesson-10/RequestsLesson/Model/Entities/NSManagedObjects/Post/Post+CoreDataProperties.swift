//
//  Post+CoreDataProperties.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var commentsCount: Int64
    @NSManaged public var date: Date?
    @NSManaged public var imageURL: String?
    @NSManaged public var likesCount: Int64
    @NSManaged public var postId: Int64
    @NSManaged public var repostsCount: Int64
    @NSManaged public var text: String?

}
