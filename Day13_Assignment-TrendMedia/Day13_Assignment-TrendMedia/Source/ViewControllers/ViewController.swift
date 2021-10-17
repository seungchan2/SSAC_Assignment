//
//  ViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit

class ViewController: UIViewController {
    let mediaInformation = MediaInformation()
    let imageArray = [Const.Image.squidgame, Const.Image.maid, Const.Image.theFiveJuana, Const.Image.sexEducation, Const.Image.alice, Const.Image.kastanjemanden, Const.Image.hometown, Const.Image.pawPastrol, Const.Image.theBaby, Const.Image.taleDark, Const.Image.grey, Const.Image.house, Const.Image.king, Const.Image.nevertheless, Const.Image.billionDollar]
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var mediaTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        makeShadow()
        registerXib()
        assignDelegate()
      
    }
    
    private func initNavigationBar() {
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(presentSearchView))
         self.navigationItem.rightBarButtonItem?.tintColor = .black
         self.title = "Trend Media"
    }
    
    private func makeShadow() {
        buttonView.layer.cornerRadius = 5
       
        buttonView.layer.borderWidth = 0.1
               /// 테두리 밖으로 contents가 있을 때, 마스킹(true)하여 표출안되게 할것인지 마스킹을 off(false)하여 보일것인지 설정
        buttonView.layer.masksToBounds = false
               /// shadow 색상
        buttonView.layer.shadowColor = UIColor.black.cgColor
               /// 현재 shadow는 view의 layer 테두리와 동일한 위치로 있는 상태이므로 offset을 통해 그림자를 이동시켜야 표출
        buttonView.layer.shadowOffset = CGSize(width: 0, height: 5)
               /// shadow의 투명도 (0 ~ 1)
        buttonView.layer.shadowOpacity = 0.2
               /// shadow의 corner radius
        buttonView.layer.shadowRadius = 5.0

    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "MediaTableViewCell", bundle: nil)
        mediaTableView.register(nibName, forCellReuseIdentifier: "MediaTableViewCell")
    }
    
    private func assignDelegate() {
        mediaTableView.dataSource = self
        mediaTableView.delegate = self
    }
    
    private func pushProducerView() {
        let storyboard = UIStoryboard(name: "Producer", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "ProducerViewController") as? ProducerViewController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func presentSearchView() {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let nav = UINavigationController(rootViewController: nextVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mediaTableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else { return UITableViewCell() }
        
        let row = mediaInformation.tvShow[indexPath.row]
        cell.backgroundView?.layer.borderWidth = 1
        cell.backgroundView?.layer.backgroundColor = UIColor.black.cgColor
        cell.dateLabel.text = row.releaseDate
        cell.genreLabel.text = row.genre
        cell.titleEnglishLabel.text = row.title
        cell.starringLabel.text = row.starring
        cell.mediaImage.image = imageArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = mediaTableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.white

        pushProducerView()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }
}

