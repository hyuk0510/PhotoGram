//
//  UnSplashAPIManager.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/30.
//

import Foundation

class UnSplashAPIManager {
    
    enum APIError {
        case failedRequest
        case noData
        case invalidResponse
        case invalidData
    }
    
    static let shared = UnSplashAPIManager()
    
    private init() {}
    
    static func unsplashRequest(query: String, completion: @escaping (Photos?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.unsplash.com"
        let path = "/search/photos"
        
        let key = APIKey.unsplashKey
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "5"),
            URLQueryItem(name: "order_by", value: "relevant"),
            URLQueryItem(name: "client_id", value: key)
        ]
        
        guard let url = component.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Photos.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
            
        }.resume()
    }
}
