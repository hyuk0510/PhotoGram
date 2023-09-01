//
//  APIService.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/30.
//

import Foundation

class APIService {
    
    static let shared = APIService() // 인스턴스 생성 방지
    
    private init() {}
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplashKey)&page=1&per_page=5") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    completionHandler(nil)
                }
                
            }
            
        }.resume()
    }
    
}

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
