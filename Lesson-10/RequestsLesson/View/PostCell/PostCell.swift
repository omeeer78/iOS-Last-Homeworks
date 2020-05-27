//
//  PostCell.swift
//  RequestsLesson
//
//  Created by Amir on 14.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    lazy var mainWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
   lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "i3")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.heightAnchor.constraint(equalToConstant: 43).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 43).isActive = true
        imageView.layer.cornerRadius = frame.height / 2
    imageView.clipsToBounds = true
        return imageView
    }()

    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = #colorLiteral(red: 0.3607843137, green: 0.5019607843, blue: 0.7058823529, alpha: 1)
        lbl.text = "Amir Mardanov"
        return lbl
    }()
    
    lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .lightGray
        lbl.text = "12 декабря"
        return lbl
    }()
    
    lazy var postTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        lbl.textColor = .black
        lbl.sizeToFit()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.text = "Post text"
        return lbl
    }()
    
    lazy var nameTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, timeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var userInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameTimeStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var separatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9176470588, blue: 0.937254902, alpha: 1)
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return view
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var likesCountLabel = CountLabel()
    lazy var commentsCountLabel = CountLabel()
    lazy var repostsCountLabel = CountLabel()
    
    lazy var likesStack = InfoStack(arrangedSubviews: [likeButton, likesCountLabel])
    lazy var commentsStack = InfoStack(arrangedSubviews: [IconImageView(image: #imageLiteral(resourceName: "comment")), commentsCountLabel])
    lazy var repostsStack = InfoStack(arrangedSubviews: [IconImageView(image: #imageLiteral(resourceName: "share")), repostsCountLabel])
    
    lazy var leftSideElements: InfoStack = {
        let stack = InfoStack(arrangedSubviews: [likesStack, commentsStack, repostsStack])
        stack.spacing = 20
        return stack
    }()
    
    func addSubviewsAndLayout() {
        contentView.addSubview(mainWrapper)
        
        mainWrapper.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        mainWrapper.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        mainWrapper.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        mainWrapper.addSubviews([userInfoStack,
                                 postTextLabel,
                                 postImageView,
                                 separatorLineView,
                                 bottomView])
        
        userInfoStack.topAnchor.constraint(equalTo: mainWrapper.topAnchor, constant: 9).isActive = true
        userInfoStack.leftAnchor.constraint(equalTo: mainWrapper.leftAnchor, constant: 9).isActive = true
        userInfoStack.rightAnchor.constraint(equalTo: mainWrapper.rightAnchor).isActive = true
        
        postTextLabel.topAnchor.constraint(equalTo: userInfoStack.bottomAnchor, constant: 10).isActive = true
        postTextLabel.leftAnchor.constraint(equalTo: mainWrapper.leftAnchor, constant: 9).isActive = true
        postTextLabel.rightAnchor.constraint(equalTo: mainWrapper.rightAnchor, constant: 9).isActive = true
        
        postImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 10).isActive = true
        postImageView.leftAnchor.constraint(equalTo: mainWrapper.leftAnchor).isActive = true
        postImageView.rightAnchor.constraint(equalTo: mainWrapper.rightAnchor).isActive = true
        
        separatorLineView.rightAnchor.constraint(equalTo: mainWrapper.rightAnchor).isActive = true
        separatorLineView.leftAnchor.constraint(equalTo: mainWrapper.leftAnchor, constant: 12).isActive = true
        
        bottomView.addSubview(leftSideElements)
        
        bottomView.bottomAnchor.constraint(equalTo: mainWrapper.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: mainWrapper.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: mainWrapper.rightAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor).isActive = true
        
        leftSideElements.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 15).isActive = true
        leftSideElements.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviewsAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.isHidden = false
        postImageView.image = nil
        postTextLabel.isHidden = false
    }

    func configureCell(post: PostModel, user: UserModel) {
        
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        
        if let userImageURL = user.photo {
            
            NetworkManager.shared.getImage(from: userImageURL) { [weak self] data in
                self?.profileImageView.image = UIImage(data: data)
            }
        }
        
        if let postImageURL = post.image {
            NetworkManager.shared.getImage(from: postImageURL) { [weak self] data in
                self?.postImageView.image = UIImage(data: data)
            }
        }
        
        timeLabel.text = DateManager.reformDate(post.date)
        
        if let postText = post.text {
            if post.image == nil {
                
                postImageView.isHidden = true
                separatorLineView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 11).isActive = true
                
            } else {
                
                postImageView.isHidden = false
                separatorLineView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 11).isActive = true
            }
            postTextLabel.text = postText
        }
        
        likesCountLabel.text = String(post.likes)
        commentsCountLabel.text = String(post.comments)
        repostsCountLabel.text = String(post.reposts)        
    }
    
    @objc func likeButtonPressed() {
        print("Like/Dislike")
    }
}
