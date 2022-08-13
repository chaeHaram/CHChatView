//
//  StatusAPI.swift
//  CHChatView
//
//  Created by Chae_Haram on 2022/08/14.
//

import Foundation

struct StatusAPI {
    let statusURL: URL = URL(string: "https://api.adviceslip.com/advice")!
    
    func downloadStatus(completion: @escaping (RandomStatus?, String) -> Void ) {
        URLSession.shared.dataTask(with: statusURL) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let statusDown = try decoder.decode(RandomStatus.self, from: data)
                completion(statusDown, "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }
}
