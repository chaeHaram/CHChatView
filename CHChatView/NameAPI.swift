//
//  NameApi.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import Foundation

struct NameAPI {
    let nameURL: URL = URL(string: "https://api.namefake.com/")!
    
    func downloadName(completion: @escaping (RandomName?, String) -> Void ) {
        URLSession.shared.dataTask(with: nameURL) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let nameDown = try decoder.decode(RandomName.self, from: data)
                completion(nameDown, "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }
}
