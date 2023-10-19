//
//  PhotoCell.swift
//  Project-Test
//
//  Created by MNC Insurance 1 on 18/10/23.
//

import UIKit

class PhotoCell: UITableViewCell {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var photos: [Photos] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "photoCollectionCell")
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 1/2 * collectionView.frame.width, height: 230)
    layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    layout.minimumInteritemSpacing = 10
    collectionView.collectionViewLayout = layout
    
  }
  
}
extension PhotoCell : UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if photos.count == 0 {
      return 0
    }else{
      return 10
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! PhotoCollectionCell
    
    cell.titlePhotoLabel.text = photos[indexPath.row].title ?? ""
    cell.setupImageView(url: photos[indexPath.row].url ?? "")
    cell.shadowDecorate()
    
    return cell
  }
}
