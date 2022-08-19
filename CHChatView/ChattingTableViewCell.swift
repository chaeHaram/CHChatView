//
//  ChattingTableViewCell.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/12.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        stackView.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        label.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "자기소개"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        label.setContentHuggingPriority(.init(rawValue: 251), for: .vertical)
        return label
    }()
    
    let profilePhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "folder.fill")
        image.layer.cornerRadius = CGFloat(16)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        image.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default , reuseIdentifier: "ProfileCell")
        addSubView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSectionStyle() {
        selectionStyle = .none
    }
    
    func addSubView() {
        contentView.addSubview(profilePhoto)
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(statusLabel)
        
    }
    
    func setConstraints() { 
        profilePhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        profilePhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profilePhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        profilePhoto.widthAnchor.constraint(equalToConstant: 85).isActive = true
        profilePhoto.heightAnchor.constraint(equalToConstant: 85).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 15).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor).isActive = true
        
    }

}
