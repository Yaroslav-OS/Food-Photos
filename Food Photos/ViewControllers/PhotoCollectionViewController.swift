//
//  PhotoCollectionViewController.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 16.11.2020.
//

import UIKit


class PhotoCollectionViewController: UICollectionViewController {
    
    var foods: [Food] = []
    let jsonLink = "https://api.unsplash.com/photos/random?count=30&query=food&orientation=portrait&client_id=k9FHPQbE--TGWVp2ea-pioNPwGKUs1oxfhQ4-LJvG6c"
    var link: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchData(urlString: jsonLink) { foods in
            DispatchQueue.main.async {
                self.foods.append(contentsOf: foods)
                print(self.foods)
                print("Foods count: \(self.foods.count)")
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photoVC = segue.destination as? PhotoViewController else { return }
        guard let cell = sender as? PhotoCell else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let imageURL = foods[indexPath.row].urls["regular"]
        photoVC.selectedPhoto = imageURL ?? ""
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell

        let food = self.foods[indexPath.row]

        cell.configure(food: food)
        
        return cell
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availabeWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availabeWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
