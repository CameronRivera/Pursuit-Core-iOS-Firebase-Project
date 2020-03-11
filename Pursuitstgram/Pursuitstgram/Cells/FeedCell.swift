//
//  FeedCell.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    public func configureCell(_ pic: Photo){
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(with: URL(string: pic.imageURL))
    }
}
