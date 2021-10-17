//
//  ProducerViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit

class ProducerViewController: UIViewController {
    
    let mediaInformation = MediaInformation()
    let imageArray = [Const.Image.squidgame, Const.Image.maid, Const.Image.theFiveJuana, Const.Image.sexEducation, Const.Image.alice, Const.Image.kastanjemanden, Const.Image.hometown, Const.Image.pawPastrol, Const.Image.theBaby, Const.Image.taleDark, Const.Image.grey, Const.Image.house, Const.Image.king, Const.Image.nevertheless, Const.Image.billionDollar]

    @IBOutlet var produceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigaionBar()
        assignDelegate()
        registerXib()
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
    
    @objc func closeButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProducerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = produceTableView.dequeueReusableCell(withIdentifier: "ProducerTableViewCell") as? ProducerTableViewCell else { return UITableViewCell() }
        
        cell.mediaImage.image = imageArray[indexPath.row]
        cell.mediaImage.contentMode = .scaleAspectFill
        cell.mediaImage.layer.cornerRadius = 10
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = produceTableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.white
    }
}

extension ProducerViewController: UITableViewDelegate {

}
