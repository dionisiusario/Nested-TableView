//
//  PostCell.swift
//  Project-Test
//
//  Created by MNC Insurance 1 on 18/10/23.
//

import UIKit

class PostCell: UITableViewCell {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var posts: [Posts] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.register(UINib(nibName: "PostCollectionCell", bundle: nil), forCellWithReuseIdentifier: "postCollectionCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 3/4 * collectionView.frame.width, height: 200)
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumInteritemSpacing = 10
    
    collectionView.collectionViewLayout = layout
    
  }
}

extension PostCell : UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if posts.count == 0 {
      return 0
    }else{
      return 10
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCollectionCell", for: indexPath) as! PostCollectionCell
    
    cell.titleLabel.text = posts[indexPath.row].title ?? ""
    cell.detailLabel.text = posts[indexPath.row].body ?? ""
    
    cell.shadowDecorate()
    
    return cell
  }
  
}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
