//
//  LibraryCollectionViewCell.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/24.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
        static let identifier = "LibraryCollectionViewCell"
    @IBOutlet var backgroundColorView: UIView!
    
    @IBOutlet var mediaImageView: UIImageView!
    
    @IBOutlet var mediaTitleLabel: UILabel!
    @IBOutlet var rawLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 10
       
    }

}
