//
//  SearchableViewCell.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit

class SearchableViewCell: UITableViewCell {

    static let identifier = "SearchableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mediaImage: UIImageView!
    @IBOutlet var storyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
