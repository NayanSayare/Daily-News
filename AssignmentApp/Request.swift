//
//  Request.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import Foundation

class NetworkRequest {
    
    func fetchNews(completionHandler: @escaping (News?) -> Void) {
        if let url: URL = URL(string: "http://10.64.14.85/v1/dashboard") {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                DispatchQueue.main.async {
                    guard let httpResponse = response as? HTTPURLResponse, let data = data,
                          httpResponse.statusCode == 200  else {
                        completionHandler(nil)
                        return
                    }
                    
                    do {
                        let json = try JSONDecoder().decode(News.self, from: data)
                        completionHandler(json)
                    } catch {
                        completionHandler(nil)
                    }
                }
            }.resume()
        }
    }
    
}

