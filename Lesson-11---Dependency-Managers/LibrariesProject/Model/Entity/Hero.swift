//
//  Hero.swift
//  LibrariesProject
//
//  Created by Amir on 03.03.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

/// Base entity for decoding data
struct Hero: Codable {
    
    let id: Int
    let name: String
    let height: Double?
    let mass: Int?
    let gender: String
    var homeworld: String?
    let wiki: String
    let image: String
    let species: String
    let hairColor: String?
    let eyeColor: String?
    let skinColor: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case mass
        case gender
        case homeworld
        case wiki
        case image
        case species
        case hairColor
        case eyeColor
        case skinColor
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
       
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try? container.decode(Double.self, forKey: .height)
        mass = try? container.decode(Int.self, forKey: .mass)
        gender = try container.decode(String.self, forKey: .gender)
        homeworld = try? container.decode(String.self, forKey: .homeworld)
        wiki = try container.decode(String.self, forKey: .wiki)
        image = try container.decode(String.self, forKey: .image)
        species = try container.decode(String.self, forKey: .species)
        hairColor = try? container.decode(String.self, forKey: .hairColor)
        skinColor = try? container.decode(String.self, forKey: .skinColor)
        eyeColor = try? container.decode(String.self, forKey: .eyeColor)
        
        guard homeworld != nil else {
            homeworld = "No homeworld for \(name)"
            return
        }
    }
}
