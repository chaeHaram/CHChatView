//
//  RandomImage.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import UIKit

struct RandomImage: Codable {
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case downloadUrl = "download_url"
    }
}
