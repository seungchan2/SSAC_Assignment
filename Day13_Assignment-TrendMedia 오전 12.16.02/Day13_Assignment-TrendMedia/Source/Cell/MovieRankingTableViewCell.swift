//
//  MovieRankingTableViewCell.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/26.
//

import UIKit

class MovieRankingTableViewCell: UITableViewCell {
    static let identifier = "MovieRankingTableViewCell"
    
    @IBOutlet var rankingLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
