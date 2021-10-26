//
//  ViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let refreshControl = UIRefreshControl()
    let mediaInformation = MediaInformation()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet weak var mediaTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        makeShadow()
        registerXib()
        assignDelegate()
        initRefresh()
    }
    
    // MARK: - Functions
    
    // 인디케이터
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        mediaTableView.refreshControl = refreshControl
    }
    
    private func initNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(presentSearchView))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(pushMapView))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.title = "Trend Media"
    }
    
    private func makeShadow() {
        buttonStackView.layer.cornerRadius = 5
        
        buttonStackView.backgroundColor = .white
        
        buttonStackView.layer.borderWidth = 0.1
        /// 테두리 밖으로 contents가 있을 때, 마스킹(true)하여 표출안되게 할것인지 마스킹을 off(false)하여 보일것인지 설정
        buttonStackView.layer.masksToBounds = false
        /// shadow 색상
        buttonStackView.layer.shadowColor = UIColor.black.cgColor
        /// 현재 shadow는 view의 layer 테두리와 동일한 위치로 있는 상태이므로 offset을 통해 그림자를 이동시켜야 표출
        buttonStackView.layer.shadowOffset = CGSize(width: 0, height: 5)
        /// shadow의 투명도 (0 ~ 1)
        buttonStackView.layer.shadowOpacity = 0.2
        /// shadow의 corner radius
        buttonStackView.layer.shadowRadius = 5.0
        
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "MediaTableViewCell", bundle: nil)
        mediaTableView.register(nibName, forCellReuseIdentifier: "MediaTableViewCell")
    }
    
    private func assignDelegate() {
        mediaTableView.dataSource = self
        mediaTableView.delegate = self
    }
    
    // 인디케이터
    @objc func refreshTable(refresh: UIRefreshControl){
        print("새로고침")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mediaTableView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    @objc func presentSearchView() {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let nav = UINavigationController(rootViewController: nextVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func pushMapView() {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func presentToWebView(_ gesture: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Web", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "WebViewController") as? WebViewController else { return }
        self.present(nextVC, animated: true)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchLibraryButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Library", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "LibraryViewController") as? LibraryViewController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func touchTvButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MovieRanking", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "MovieRankingViewController") as? MovieRankingViewController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mediaTableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else { return UITableViewCell() }
        
        let row = mediaInformation.tvShow[indexPath.row]
        
        cell.dateLabel.text = row.releaseDate
        cell.genreLabel.text = row.genre
        cell.gradeLabel.text = "\(row.rate)"
        cell.titleEnglishLabel.text = row.title
        cell.starringLabel.text = row.starring
        cell.overviewLabel.text = row.overview
        
        let url = URL(string: row.backdropImage)
        cell.mediaImage.kf.setImage(with: url)
        
        // 웹뷰로 넘어가기
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentToWebView(_:)))
        cell.webViewButton.addGestureRecognizer(tapRecognizer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Producer", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "ProducerViewController") as? ProducerViewController else { return }
        
        guard let cell = mediaTableView.cellForRow(at: indexPath) as? MediaTableViewCell else { return }
        
        cell.contentView.backgroundColor = UIColor.white
        
        // 데이터 전달 -> 이렇게 하는 것이 맞나.. 리팩토링 필요!!!
        nextVC.message = cell.titleEnglishLabel.text
        nextVC.mainPhoto = cell.mediaImage.image
        nextVC.mediaPhoto = cell.mediaImage.image
        nextVC.overview = cell.overviewLabel.text
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }
}

