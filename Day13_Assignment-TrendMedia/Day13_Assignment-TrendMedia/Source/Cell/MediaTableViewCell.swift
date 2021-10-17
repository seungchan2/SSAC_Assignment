//
//  MediaTableViewCell.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    static let identifier = "MediaTableViewCell"
    
    @IBOutlet var mediaView: UIView!
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleEnglishLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var starringLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeShadow()
    }
    
    private func makeShadow() {
        mediaView.layer.cornerRadius = 10
        
        mediaImage.layer.cornerRadius = 10
        mediaImage.contentMode = .scaleAspectFill
        mediaView.layer.borderWidth = 0.1
               /// 테두리 밖으로 contents가 있을 때, 마스킹(true)하여 표출안되게 할것인지 마스킹을 off(false)하여 보일것인지 설정
        mediaView.layer.masksToBounds = false
               /// shadow 색상
        mediaView.layer.shadowColor = UIColor.black.cgColor
               /// 현재 shadow는 view의 layer 테두리와 동일한 위치로 있는 상태이므로 offset을 통해 그림자를 이동시켜야 표출
        mediaView.layer.shadowOffset = CGSize(width: 0, height: 5)
               /// shadow의 투명도 (0 ~ 1)
        mediaView.layer.shadowOpacity = 0.2
               /// shadow의 corner radius
        mediaView.layer.shadowRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
