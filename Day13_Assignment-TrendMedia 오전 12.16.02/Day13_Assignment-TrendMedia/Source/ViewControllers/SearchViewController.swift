//
//  SearchViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/17.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    let mediaInformation = MediaInformation()
    let refreshControl = UIRefreshControl()
    var movieData: [MovieModel] = []
    
    // MARK: - @IBOutlet Properties
    

    @IBOutlet var movieTextField: UITextField!
    @IBOutlet var searchTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigaionBar()
        assignDelegate()
        registerXib()
        deleteMovieTextFieldText()
       
    }
    
    // MARK: - Functions
    
    // 인디케이터
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        searchTableView.refreshControl = refreshControl
    }
    
    private func deleteMovieTextFieldText() {
        movieTextField.addTarget(self, action: #selector(MovieRankingViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = movieTextField.text else {return}
        if text.count < 1 {

            movieData.removeAll()

            searchTableView.reloadData()
        } 
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
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData() {
        guard let movieSearch = movieTextField.text else { return }
        
        guard let query = "\(movieSearch)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
      
        let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "DElSzBa_7vEKFkdtIBWu",
            "X-Naver-Client-Secret" : "pGGH5rccRK"
        ]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["items"].arrayValue {
                    
                    let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let image = item["image"].stringValue
                    let link = item["link"].stringValue
                    let userRating = item["userRating"].stringValue
                    let sub = item["subtitle"].stringValue
                    let data = MovieModel(titleData: value,
                                          imageData: image,
                                          linkData: link,
                                          userRatingData: userRating,
                                          subtitle: sub)
                   
                    self.movieData.append(data)
                }
                
                // 중요!
                self.searchTableView.reloadData()
                self.initRefresh()
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshTable(refresh: UIRefreshControl){
        print("새로고침")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.searchTableView.reloadData()
            refresh.endRefreshing()
        }
    }
    @IBAction func tapMovieSearchButton(_ sender: UIButton) {
        fetchMovieData()
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchableViewCell") as? SearchableViewCell else { return UITableViewCell() }
        
        let row = movieData[indexPath.row]
        
        cell.titleLabel.text = row.titleData
        cell.storyLabel.text = row.subtitle
        cell.titleLabel.sizeToFit()
        cell.storyLabel.sizeToFit()
        
        let url = URL(string: row.imageData)
        cell.mediaImage.kf.setImage(with: url)
        cell.mediaImage.contentMode = .scaleAspectFill
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = searchTableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.white
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
}


