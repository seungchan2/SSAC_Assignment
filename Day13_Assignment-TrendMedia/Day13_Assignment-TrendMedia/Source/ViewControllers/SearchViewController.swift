//
//  SearchViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit

class SearchViewController: UIViewController {

    let mediaInformation = MediaInformation()
    let imageArray = [Const.Image.squidgame, Const.Image.maid, Const.Image.theFiveJuana, Const.Image.sexEducation, Const.Image.alice, Const.Image.kastanjemanden, Const.Image.hometown, Const.Image.pawPastrol, Const.Image.theBaby, Const.Image.taleDark, Const.Image.grey, Const.Image.house, Const.Image.king, Const.Image.nevertheless, Const.Image.billionDollar]
    
    @IBOutlet var searchTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigaionBar()
        assignDelegate()
        registerXib()
    }
    
    private func initNavigaionBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        self.navigationItem.title = "영화 검색"
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func assignDelegate() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "SearchableViewCell", bundle: nil)
        searchTableView.register(nibName, forCellReuseIdentifier: "SearchableViewCell")
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchableViewCell") as? SearchableViewCell else { return UITableViewCell() }
        
        let row = mediaInformation.tvShow[indexPath.row]
        cell.titleLabel.text = row.title
        cell.storyLabel.text = row.overview
        cell.titleLabel.sizeToFit()
        cell.storyLabel.sizeToFit()
        cell.mediaImage.image = imageArray[indexPath.row]
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = searchTableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.white
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
