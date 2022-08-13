//
//  ViewController.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/12.
//

import UIKit

class ViewController: UIViewController {
    
    let chattingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var randInt: Int = Int.random(in: 1...50)
    var sectionName: [String] = ["", "친구"]
    var imageList = MyDB.imageList
    let imageURL: URL = URL(string: "https://picsum.photos/v2/list")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(randInt)
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        chattingTableView.register(ChattingTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        
        addSubView()
        setConstraints()
        for _ in 0..<randInt - 1 {
            appendImage()
            appendName()
            appendStatus()
        }
        
        sectionName[1] = "친구 \(randInt - 1)"
        
        title = "친구"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addSubView() {
        view.addSubview(chattingTableView)
    }

    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // tableView
        chattingTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        chattingTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        chattingTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        chattingTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func appendImage() {
        ImageAPI().downloadImage { image, result in
            guard let image = image else {
                print("result : \(result)")
                return
            }
            let imageInfo = RandomImage(url: image.url)
            MyDB.imageList.append(imageInfo)
            print(MyDB.imageList)
        }
    }
    
    func appendName() {
        NameAPI().downloadName { name, result in
            guard let name = name else {
                print("result : \(result)")
                return
            }
            let nameInfo = RandomName(name: name.name)
            MyDB.nameList.append(nameInfo)
            print(MyDB.nameList)
        }
    }
    
    func appendStatus() {
        StatusAPI().downloadStatus { status, result in
            guard let status = status else {
                print("result : \(result)")
                return
            }
            let statusInfo = RandomStatus(slip: status.slip)
            print(statusInfo)
            print(MyDB.adviceList)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.profilePhoto.image = UIImage(named: "myProfile")
            cell.nameLabel.text = "정찬욱"
            cell.statusLabel.text = "이게 전대용"
        } else if indexPath.section == 1 {
            cell.profilePhoto.image = UIImage(systemName: "folder.fill")
            cell.nameLabel.text = "이름"
            cell.statusLabel.text = "자기소개"
        } else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return randInt - 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
