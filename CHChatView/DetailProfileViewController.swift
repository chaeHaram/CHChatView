//
//  DetailProfileViewController.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/18.
//

import UIKit

class DetailProfileViewController: UIViewController {
    
    let uiView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "foler.fill")
        profileImage.layer.cornerRadius = CGFloat(16)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    let profileNameLabel: UILabel = {
        let profileName = UILabel()
        profileName.text = "이름"
        profileName.font = UIFont.boldSystemFont(ofSize: 14)
        profileName.translatesAutoresizingMaskIntoConstraints = false
        return profileName
    }()
    
    let profileStatusLabel: UILabel = {
        let profileStatus = UILabel()
        profileStatus.text = "자기소개"
        profileStatus.font = UIFont.systemFont(ofSize: 12)
        profileStatus.translatesAutoresizingMaskIntoConstraints = false
        return profileStatus
    }()
    
    let previousViewControllerMoveButton: UIButton = {
        let previousButton = UIButton()
        previousButton.setTitle("X", for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        return previousButton
    }()
    
    let profileEditButton: UIButton = {
        let profileEditButton = UIButton()
        profileEditButton.setTitle("프로필 편집", for: .normal)
        profileEditButton.setImage(UIImage(systemName: "pencil.fill"), for: .normal)
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        return profileEditButton
    }()
    
    let friendManagementButton: UIButton = {
        let friendManagementButton = UIButton()
        friendManagementButton.setTitle("친구 관리", for: .normal)
        friendManagementButton.setImage(UIImage(systemName: "person.fill"), for: .normal)
        friendManagementButton.translatesAutoresizingMaskIntoConstraints = false
        return friendManagementButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubView()
    }
    
    func addSubView() {
        view.addSubview(uiView)
        uiView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(profileImageView)
        verticalStackView.addArrangedSubview(profileNameLabel)
        verticalStackView.addArrangedSubview(profileStatusLabel)
        uiView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(profileEditButton)
        horizontalStackView.addArrangedSubview(friendManagementButton)
        uiView.addSubview(previousViewControllerMoveButton)
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        uiView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        uiView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
}
