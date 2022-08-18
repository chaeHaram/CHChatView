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

    var randInt: Int = Int.random(in: 2...5)
    var sectionName: [String] = ["", "친구"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        setConstraints()
        configureTableView()
        
        sectionName[1] = "친구 \(randInt - 1)"
        
        title = "친구"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().async {
            for _ in 0..<self.randInt - 1 {
                self.apiFetch()
            }
        }
    }
    
    func configureTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        chattingTableView.register(ChattingTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
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

    func apiFetch() {
        // 동기 - 비동기
        // 동기 : 일꾼이 세명이 있어도 한명이 1 -> 2 -> 3으로 처리
        // 비동기 : 일꾼이 세명이 있으면 세명이 일 하나씩 맡아서 처리
        let group = DispatchGroup()
        
        group.enter()
        ImageAPI().downloadImage { image, result in
            guard let image = image else {
                print("result : \(result)")
                return
            }
            let imageInfo = RandomImage(downloadUrl: image.downloadUrl)
            MyDB.imageList.append(imageInfo)
            group.leave()
        }
        
        group.enter()
        NameAPI().downloadName { name, result in
            guard let name = name else {
                print("result : \(result)")
                return
            }
            let nameInfo = RandomName(name: name.name)
            MyDB.nameList.append(nameInfo)
            group.leave()
        }
        
        group.enter()
        StatusAPI().downloadStatus { status, result in
            guard let status = status else {
                print("result : \(result)")
                return
            }
            let statusInfo = RandomStatus(slip: status.slip)
            MyDB.statusList.append(statusInfo)
            group.leave()
        }
        group.notify(queue: .main) {
            self.chattingTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.profilePhoto.image = MyDB.myImage
            cell.nameLabel.text = MyDB.myName
            cell.statusLabel.text = MyDB.myStatus
        } else if indexPath.section == 1 {
//            cell.profilePhoto.image = UIImage(systemName: "pencil")
//            cell.nameLabel.text = "이름"
//            cell.statusLabel.text = "자기소개"
            cell.profilePhoto.image = UIImage(data: try! Data(contentsOf: URL(string: MyDB.imageList[indexPath.row].downloadUrl)!))
            cell.nameLabel.text = MyDB.nameList[indexPath.row].name
            cell.statusLabel.text = MyDB.statusList[indexPath.row].slip.advice
        } else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return MyDB.imageList.count
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
