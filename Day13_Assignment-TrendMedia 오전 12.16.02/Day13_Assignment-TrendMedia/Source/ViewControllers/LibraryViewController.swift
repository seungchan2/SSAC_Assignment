//
//  LibraryViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/24.
//

import UIKit
import Toast

class LibraryViewController: UIViewController {
    // MARK: - Properties
    
    let colorArray = [UIColor.purple, UIColor.magenta, UIColor.systemGreen, UIColor.blue, UIColor.red, UIColor.red,UIColor.orange, UIColor.purple, UIColor.blue, UIColor.orange, UIColor.blue, UIColor.gray, UIColor.purple, UIColor.lightGray ,UIColor.systemBrown]
    let mediaInformation = MediaInformation()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var collectionView: UICollectionView!
   
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        assignDelegate()
        collectionViewLayout()
    }
    
    // MARK: - Functions
    
    private func collectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "LibraryCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "LibraryCollectionViewCell")
    }
    
    private func assignDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

// MARK: - UICollectionViewDataSource

extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.mediaTitleLabel.text = mediaInformation.tvShow[indexPath.row].title
        let url = URL(string: mediaInformation.tvShow[indexPath.row].backdropImage)
        let data = try? Data(contentsOf: url!)
        cell.mediaImageView.image = UIImage(data: data!)
        cell.mediaImageView.contentMode = .scaleAspectFill
        cell.rawLabel.text = "\(mediaInformation.tvShow[indexPath.row].rate)"
        cell.rawLabel.textColor = .white
        cell.backgroundColorView.backgroundColor = UIColor.blue
        cell.backgroundColorView.layer.cornerRadius = 15
        cell.backgroundColorView.backgroundColor = colorArray[indexPath.row]
        return cell

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? LibraryCollectionViewCell else { return }
        guard let text = cell.mediaTitleLabel.text else { return }
        self.view.makeToast("\(text)에 대한 정보가 궁금하세요?", duration: 0.5, position: .bottom)
        }
}

// MARK: - UICollectionViewDelegate
extension LibraryViewController: UICollectionViewDelegate {
    
}


