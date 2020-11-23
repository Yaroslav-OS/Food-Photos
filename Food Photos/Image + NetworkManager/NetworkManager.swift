//
//  NetworkManager.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 17.11.2020.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(urlString: String, complition: @escaping ([Food]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let quotes = try JSONDecoder().decode([Food].self, from: data)
                print(quotes)
                DispatchQueue.main.async {
                    complition(quotes)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}

