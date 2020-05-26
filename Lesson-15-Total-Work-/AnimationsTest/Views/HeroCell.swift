//
//  HeroCell.swift
//  AnimationsTest
//
//  Created by Amir on 05.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import SDWebImage

class HeroCell: UITableViewCell {

    /// Hero imageView & size to it
    private var heroImage = UIImageView(roundCorners: true, cornerRadius: 8)
    private let imageViewSizes = CGSize(width: 60, height: 60)
    
    /// Label that stores the name
    private var nameLabel = UILabel(fontSize: 18, textColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
    
    /// Label that stores the homeworld
    private var homeworldLabel = UILabel(fontSize: 12, textColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))
        
    /// Basic indentation for elements
    private let interval: CGFloat = 16
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        initConstraints()
    }
    
    /// Method, that initialize cell views
    private func initViews() {
                
        nameLabel.sizeToFit()
        homeworldLabel.sizeToFit()
        
        heroImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(heroImage)
        addSubview(nameLabel)
        addSubview(homeworldLabel)
    }
    
    /// Method, that initialize constraints
    private func initConstraints() {
        
        let stackView = UIStackView(views: [nameLabel, homeworldLabel], axis: .vertical, spacing: 2)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            heroImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            heroImage.leftAnchor.constraint(equalTo: leftAnchor, constant: interval),
            heroImage.heightAnchor.constraint(equalToConstant: imageViewSizes.height),
            heroImage.widthAnchor.constraint(equalToConstant: imageViewSizes.width),

            stackView.topAnchor.constraint(equalTo: topAnchor, constant: interval),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -interval),
            stackView.leftAnchor.constraint(equalTo: heroImage.rightAnchor, constant: interval / 2),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -interval)
        ])
    }
    
    /// Method, that configure cell
    /// - Parameter hero: passed hero model
    func configure(with hero: HeroDTO) {
        
        guard let url = URL(string: hero.image) else { return }
        
        heroImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "loading"))
        nameLabel.text = hero.name
        homeworldLabel.text = hero.homeworld
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
