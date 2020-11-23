//
//  ImageView.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 19.11.2020.
//

import UIKit

class ImageView: UIImageView {
    
    func fetchImage(url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        //Download image from cache, if it is there
        if let cachedImage = getCachedImage(url: imageURL) {
            image = cachedImage
            print("Get cached images")
            return
        }
        
        //Download from network, if image is not in cache
        ImageManager.shared.getImage(url: imageURL) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                print("Dowload images from network")
            }
            
            //Save data to cache
            self.saveDataToCach(data: data, response: response)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCach(data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let urlRequest = URLRequest(url: urlResponse)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
        
    }
}
