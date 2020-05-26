//
//  HeroDetailView.swift
//  AnimationsTest
//
//  Created by Amir on 11.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

protocol HeroDetailDelegate: AnyObject {
    func closeButtonPressed()
}

class HeroDetailView: UIView {
    
    var hero: HeroDTO!
    
    weak var delegate: HeroDetailDelegate?
    
    private let scrollView = UIScrollView()
    private let closeButton = UIButton.closeBtn()
    
    private let heroImageView = UIImageView(roundCorners: true, cornerRadius: 15)
    private let nameLabel = UILabel(numberOfLines: 0)
    private let heightLabel = UILabel()
    private let massLabel = UILabel()
    private let genderLabel = UILabel()
    private let homeworldLabel = UILabel(numberOfLines: 0)
    private let wikiLabel = UILabel(numberOfLines: 0)
    private let speciesLabel = UILabel(numberOfLines: 0)
    private let hairColorLabel = UILabel()
    private let eyeColorLabel = UILabel()
    private let skinColorLabel = UILabel()
    private let loremLabel = UILabel(numberOfLines: 0)
    private let loremText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Interdum varius sit amet mattis vulputate enim nulla aliquet porttitor. Vitae elementum curabitur vitae nunc sed velit dignissim sodales ut. Fermentum iaculis eu non diam. Consectetur adipiscing elit pellentesque habitant morbi. Feugiat scelerisque varius morbi enim. Duis ultricies lacus sed turpis tincidunt id aliquet risus feugiat. Scelerisque felis imperdiet proin fermentum leo. Dui nunc mattis enim ut tellus elementum sagittis. Donec ac odio tempor orci. Massa enim nec dui nunc mattis enim. Feugiat sed lectus vestibulum mattis ullamcorper velit sed. Potenti nullam ac tortor vitae purus faucibus. Eu volutpat odio facilisis mauris. Cras tincidunt lobortis feugiat vivamus at augue eget arcu. Nisl nisi scelerisque eu ultrices vitae auctor eu augue. Lectus magna fringilla urna porttitor. Quam pellentesque nec nam aliquam sem et tortor consequat. Eget mi proin sed libero enim sed faucibus. Ultrices sagittis orci a scelerisque purus semper."
    
    private let interval: CGFloat = 15
    private let noHomeworld = "No homeworld"
    private let noHairColor = "No hair color"
    private let noEyeColor = "No eye color"
    private let noSkinColor = "No skin color"
    
    private lazy var mainStackView = UIStackView(views: [nameLabel, heightLabel, massLabel, genderLabel, homeworldLabel, wikiLabel, speciesLabel, hairColorLabel, eyeColorLabel, skinColorLabel, loremLabel], axis: .vertical, spacing: 6)
    
    convenience init(hero: HeroDTO, delegate: HeroDetailDelegate) {
        self.init()
        
        self.delegate = delegate
        
        guard let url = URL(string: hero.image) else { return }
        
        heroImageView.sd_setImage(with: url)
        
        nameLabel.text = hero.name
        heightLabel.text = "\(hero.height)"
        massLabel.text = "\(hero.mass ?? 0)"
        genderLabel.text = hero.gender
        homeworldLabel.text = hero.homeworld ?? noHomeworld
        wikiLabel.text = hero.wiki
        speciesLabel.text = hero.species
        hairColorLabel.text = hero.hairColor ?? noHairColor
        eyeColorLabel.text = hero.eyeColor ?? noEyeColor
        skinColorLabel.text = hero.skinColor ?? noSkinColor
        
        initViews()
    }
    
    private func initViews() {
        
        backgroundColor = .white
        
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                  size: CGSize(width: frame.width, height: frame.height))
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = false
                
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        addSubview(scrollView)
        addSubview(closeButton)
        loremLabel.text = loremText
        
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(heroImageView)
        scrollView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: interval),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -interval),
            
            heroImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            heroImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            heroImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            heroImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            mainStackView.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: interval * 2),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    @objc private func closeButtonPressed() {
        delegate?.closeButtonPressed()
    }
}
