//
//  MyDB.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import Foundation
import UIKit

struct MyDB {
    static var imageList: [UIImage] = []
    static var nameList: [String] = []
    static var statusList: [String] = []
    
    static var friendProfile: [Profile] = []
    
    static var myProfile: Profile = Profile(image: UIImage(named: "myImage")!, name: "정찬욱", status: "이게 전대용~")
    static var selectProfile: Profile?

}

struct Profile {
    var image: UIImage
    var name: String
    var status: String
}
