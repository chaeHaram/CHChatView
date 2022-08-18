//
//  ImageApi.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import Foundation

struct ImageAPI {
//    let imageURL: URL = URL(string: "https://picsum.photos/200")!
    let imageURL: URL = URL(string: "https://picsum.photos/v2/list")!
    
    func downloadImage(completion: @escaping (RandomImage?, String) -> Void ) {
        let i: Int = Int.random(in: 0...29)
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let imageDown = try decoder.decode([RandomImage].self, from: data)
                completion(imageDown[i], "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }
    
}
