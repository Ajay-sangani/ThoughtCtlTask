//
//  ImageCollectionViewCell.swift
//  ThoughtCtlTask
//
//  Created by Apple on 01/01/24.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var additionalImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.cornerRadius()
    }
    
    func configureData(imageData: ImgurImage) {
        //imageView.sd_setImage(with: URL(string: imageData.imageUrl), placeholderImage: UIImage())
        imageView.sd_setImage(with: URL(string: imageData.imageUrl), placeholderImage: UIImage(named: "placeholder"), options: .fromCacheOnly, context: nil)
        titleLabel.text = imageData.title
        dateLabel.text = imageData.date
        additionalImageLabel.text = "Count : \(imageData.additionalImages)"
    }
}
