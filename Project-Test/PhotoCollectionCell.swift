//
//  PhotoCollectionCell.swift
//  Project-Test
//
//  Created by MNC Insurance 1 on 18/10/23.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {

  @IBOutlet weak var container: UIView!
  @IBOutlet weak var titlePhotoLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }
  
  override func prepareForReuse() {
    photoImageView.image = nil
  }
  
  func setupImageView(url: String){
    if let imageURL = URL(string: url) {
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
              
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            } else {
              print(error?.localizedDescription ?? "Error")
            }
        }.resume()
    } else {
        print("invalid URL")
    }
  }

}
