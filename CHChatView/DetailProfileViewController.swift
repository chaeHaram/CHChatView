//
//  DetailProfileViewController.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/18.
//

import UIKit

class DetailProfileViewController: UIViewController {
    
    enum ViewType {
        case myProfile
        case friendProfile
    }
    
//    static let storyboardName = "Main"
    static let storyID = "DetailVC"
    
    static var viewType: ViewType = .myProfile
    
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
    
    let chattingButton: UIButton = {
        let chattingButton = UIButton()
        if viewType == .myProfile {
            chattingButton.setTitle("나와의 채팅", for: .normal)
        } else {
            chattingButton.setTitle("1:1 채팅", for: .normal)
        }
        chattingButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
        chattingButton.translatesAutoresizingMaskIntoConstraints = false
        return chattingButton
    }()
    
    let editOrCallButton: UIButton = {
        let editOrCallButton = UIButton()
        if viewType == .myProfile {
            editOrCallButton.setTitle("프로필 편집", for: .normal)
            editOrCallButton.setImage(UIImage(systemName: "person.fill"), for: .normal)
        } else {
            editOrCallButton.setTitle("통화하기", for: .normal)
            editOrCallButton.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        }
        editOrCallButton.translatesAutoresizingMaskIntoConstraints = false
        return editOrCallButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiView.backgroundColor = randomColor()
        
        addSubView()
        setConstraints()
    }
    
    func randomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        return randomColor
    }
    
    func addSubView() {
        view.addSubview(uiView)
        uiView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(profileImageView)
        verticalStackView.addArrangedSubview(profileNameLabel)
        verticalStackView.addArrangedSubview(profileStatusLabel)
        uiView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(chattingButton)
        horizontalStackView.addArrangedSubview(editOrCallButton)
        uiView.addSubview(previousViewControllerMoveButton)
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        uiView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        uiView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        uiView.heightAnchor.constraint(equalTo: uiView.widthAnchor, multiplier: 1.7).isActive = true
        verticalStackView.centerXAnchor.constraint(equalTo: uiView.centerXAnchor).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: uiView.centerYAnchor).isActive = true
        previousViewControllerMoveButton.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 15).isActive = true
        previousViewControllerMoveButton.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 15).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor).isActive = true
        horizontalStackView.centerXAnchor.constraint(equalTo: uiView.centerXAnchor).isActive = true
        
    }
}
