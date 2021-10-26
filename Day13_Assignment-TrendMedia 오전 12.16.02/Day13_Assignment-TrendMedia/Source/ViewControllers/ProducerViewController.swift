//
//  ProducerViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit
import Kingfisher

class ProducerViewController: UIViewController {
    
    // MARK: - Properties
    
    let mediaInformation = MediaInformation()
    var isOpened : Bool = false
    var tvShow: TvShow?
    var message: String?
    var mainPhoto: UIImage?
    var mediaPhoto: UIImage?
    var overview: String?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var mediaHeightConstraint: NSLayoutConstraint!
    @IBOutlet var produceTableView: UITableView!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigaionBar()
        assignDelegate()
        registerXib()
        setLabel()
    }
    
    // MARK: - Functions
    
    private func setLabel() {
        if let msg = self.message {
            titleLabel.text = msg
        }
        if let photo = self.mainPhoto {
            movieImageView.image = photo
        }
        if let media = self.mediaPhoto {
            mediaImageView.image = media
        }
        if let story = self.overview {
            overviewLabel.text = story
        }
    }
    
    private func initNavigaionBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "뒤로 가기", style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    private func assignDelegate() {
        produceTableView.delegate = self
        produceTableView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "ProducerTableViewCell", bundle: nil)
        produceTableView.register(nibName, forCellReuseIdentifier: "ProducerTableViewCell")
    }
    
    func open() {
        overviewLabel.numberOfLines = 0
        mediaHeightConstraint.constant = 300
        arrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
        self.view.layoutIfNeeded()
        isOpened = true
    }
    
    func close() {
        overviewLabel.numberOfLines = 1
        mediaHeightConstraint.constant = 270
        arrowImageView.transform = CGAffineTransform(rotationAngle: 0)
        self.view.layoutIfNeeded()
        isOpened = false
    }
    
    @objc func closeButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func expandButtonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            if self.isOpened{
                self.close()
            } else {
                self.open()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ProducerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = produceTableView.dequeueReusableCell(withIdentifier: "ProducerTableViewCell") as? ProducerTableViewCell else { return UITableViewCell() }
        
        let row = mediaInformation.tvShow[indexPath.row]
        let url = URL(string: row.backdropImage)
        cell.mediaImage.kf.setImage(with: url)
        cell.mediaImage.contentMode = .scaleAspectFill
        cell.mediaImage.layer.cornerRadius = 10
        cell.producerLabel.text = row.title
        cell.roleLabel.text = row.starring
        cell.producerLabel.sizeToFit()
        cell.roleLabel.sizeToFit()
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = produceTableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.white
    }
}

// MARK: - UITableViewDelegate

extension ProducerViewController: UITableViewDelegate {

}
