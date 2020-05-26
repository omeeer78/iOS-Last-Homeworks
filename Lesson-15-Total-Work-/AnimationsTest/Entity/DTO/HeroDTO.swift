//
//  HeroDTO.swift
//  AnimationsTest
//
//  Created by Amir on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

struct HeroDTO  {
    
    let id: Int
    let name: String
    let height: Double
    let mass: Int?
    let gender: String
    let homeworld: String?
    let wiki: String
    let image: String
    var imageData: Data?
    let species: String
    let hairColor: String?
    let eyeColor: String?
    let skinColor: String?
}
