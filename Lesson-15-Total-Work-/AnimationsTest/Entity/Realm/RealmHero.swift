//
//  RealmHero.swift
//  AnimationsTest
//
//  Created by Amir on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import RealmSwift

@objcMembers
class RealmHero: Object {
    
    dynamic var id = 0
    dynamic var name = String()
    dynamic var height = RealmOptional<Double>()
    dynamic var mass = RealmOptional<Int>()
    dynamic var gender = String()
    dynamic var homeworld: String? = .none
    dynamic var wiki = String()
    dynamic var image = String()
    dynamic var imageData: Data? = .none
    dynamic var species = String()
    dynamic var hairColor: String? = .none
    dynamic var eyeColor: String? = .none
    dynamic var skinColor: String? = .none
    
    override class func primaryKey() -> String? {
        return #keyPath(RealmHero.id)
    }
    
    func convertTDTO() -> HeroDTO {
        
        let massDTO = mass.value ?? 0
        let homeworldDTO = homeworld ?? "No homeold"
        let eyeColorDTO = eyeColor ?? "No eye color"
        let skinColorDTO = skinColor ?? "No skin color"
        let hairColorDTO = hairColor ?? "No hair color"
        let heightDTO = height.value ?? 0
        
        return HeroDTO(id: id, name: name, height: heightDTO, mass: massDTO, gender: gender, homeworld: homeworldDTO, wiki: wiki, image: image, imageData: imageData, species: species, hairColor: hairColorDTO, eyeColor: eyeColorDTO, skinColor: skinColorDTO)
    }
    
}
