//
//  PhotoViewController.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 18.11.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var selectedPhoto: String?
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var photo: ImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedPhoto = selectedPhoto else { return }
        guard let imageURL = URL(string: selectedPhoto) else { return }
        
        ImageManager.shared.getImage(url: imageURL) { (data, _) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.photo.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func shareButtonTapped() {
        let shareController = UIActivityViewController(activityItems: [photo.image as Any], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    
    @IBAction func cancellButtonTapped() {
        dismiss(animated: true)
    }
}
