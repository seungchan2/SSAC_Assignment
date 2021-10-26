//
//  ProducerTableViewCell.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit

class ProducerTableViewCell: UITableViewCell {
    
    static let identifier = "ProducerTableViewCell"
    
    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var producerLabel: UILabel!
    @IBOutlet var mediaImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
