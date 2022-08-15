//
//  MyDB.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import Foundation
import UIKit

struct MyDB {
    static var imageList: [RandomImage] = []
    static var nameList: [RandomName] = []
    static var statusList: [RandomStatus] = []
    
    static var myImage: UIImage = UIImage(named: "myImage")!
    static var myName: String = "정찬욱"
    static var myStatus: String = "이게 전대용~"
}
