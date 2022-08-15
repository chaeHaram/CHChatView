//
//  RandomStatus.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import UIKit

struct adviceList: Decodable {
    let advice: String
}

struct RandomStatus: Decodable {
    let slip: adviceList
}
