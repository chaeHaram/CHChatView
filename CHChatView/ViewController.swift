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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(randInt)
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        chattingTableView.register(ChattingTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        
        addSubView()
        setConstraints()
        
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

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randInt
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
