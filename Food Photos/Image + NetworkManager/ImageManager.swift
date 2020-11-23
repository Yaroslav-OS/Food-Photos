//
//  ImageManager.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 22.11.2020.
//

import Foundation

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    func getImage(url: URL, completion: @escaping (Data, URLResponse) -> Void ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            guard responseURL == url else { return }
            completion(data, response)
        }.resume()
    }
}
