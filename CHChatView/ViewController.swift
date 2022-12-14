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

    var randInt: Int = Int.random(in: 1...5)
    var sectionName: [String] = ["", "친구"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        setConstraints()
        configureTableView()
        
        sectionName[1] = "친구 \(randInt)"
        
        title = "친구"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().async {
            self.apiFetch()
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
        let group = DispatchGroup()
        
        for _ in 0..<self.randInt {
            group.enter()
            ImageAPI().downloadImage { image, result in
                guard let image = image else {
                    print("result : \(result)")
                    return
                }
                let imageInfo = image.downloadUrl
                let imageUrl: URL = URL(string: imageInfo)!
                let imageData = try! Data(contentsOf: imageUrl)
                MyDB.imageList.append(UIImage(data: imageData)!)
                print("image OK")
                group.leave()
                }
        }
        
        for _ in 0..<self.randInt {
            group.enter()
            NameAPI().downloadName { name, result in
                guard let name = name else {
                    print("result : \(result)")
                    return
                }
                let nameInfo = name.name
                MyDB.nameList.append(nameInfo)
                print("name OK")
                group.leave()
            }
        }
        
        for _ in 0..<self.randInt {
            group.enter()
            StatusAPI().downloadStatus { status, result in
                guard let status = status else {
                    print("result : \(result)")
                    return
                }
                let statusInfo = status.slip.advice
                MyDB.statusList.append(statusInfo)
                print("status OK")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.friendProfile()
            self.chattingTableView.reloadData()
            print("reload")
        }
        
    }
    
    func friendProfile() {
        print("friend 시작")
        for index in 0...randInt - 1 {
            let image = MyDB.imageList[index]
            let name = MyDB.nameList[index]
            let status = MyDB.statusList[index]
            MyDB.friendProfile.append(Profile(image: image, name: name, status: status))
        }
        print("friend ok")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.profilePhoto.image = MyDB.myProfile.image
            cell.nameLabel.text = MyDB.myProfile.name
            cell.statusLabel.text = MyDB.myProfile.status
        } else if indexPath.section == 1 {
            cell.profilePhoto.image = MyDB.friendProfile[indexPath.row].image
            cell.nameLabel.text = MyDB.friendProfile[indexPath.row].name
            cell.statusLabel.text = MyDB.friendProfile[indexPath.row].status
        } else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return MyDB.friendProfile.count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailProfileViewController.storyID) as? DetailProfileViewController else { return }
        if indexPath.section == 0 {
            MyDB.selectProfile = MyDB.myProfile
            print("clicked")
        } else if indexPath.section == 1 {
            MyDB.selectProfile = MyDB.friendProfile[indexPath.row]
            print("clicked")
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
