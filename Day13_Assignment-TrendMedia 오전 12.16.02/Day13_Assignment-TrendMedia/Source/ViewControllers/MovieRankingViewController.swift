//
//  MovieRankingViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class MovieRankingViewController: UIViewController {

    var movieData: [MovieRankingModel] = []
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var movieTextField: UITextField!
    @IBOutlet var rankingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        assignDelegate()
        deleteMovieTextFieldText()
        navigationController?.navigationBar.tintColor = .black
    }
    

    private func registerXib() {
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
    }
    
    private func assignDelegate() {
        let nibName = UINib(nibName: "MovieRankingTableViewCell", bundle: nil)
        rankingTableView.register(nibName, forCellReuseIdentifier: "MovieRankingTableViewCell")
    }
    
    private func deleteMovieTextFieldText() {
        movieTextField.addTarget(self, action: #selector(MovieRankingViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = movieTextField.text else {return}
        if text.count < 8 {
            movieData.removeAll()
            rankingTableView.reloadData()
        }
    }
    
    func fetchMovieData() {
        guard let movieSearch = movieTextField.text else { return }
        
        guard let query = "\(movieSearch)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
      
        let url = "http:kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=912e30cb7289ef96c370678c3f93ce38&targetDt=\(query)"

        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let rank = item["rank"].stringValue
                    let title = item["movieNm"].stringValue
                    let openDate = item["openDt"].stringValue
                    let data = MovieRankingModel(title: title, rank: rank, openDate: openDate)
                   
                    self.movieData.append(data)
                }
                
                debugPrint(self.movieData)
                // 중요!
                self.rankingTableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
    }
    @IBAction func tapSearchButton(_ sender: UIButton) {
        fetchMovieData()
    }
}

extension MovieRankingViewController: UITableViewDelegate {
    
}

extension MovieRankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = rankingTableView.dequeueReusableCell(withIdentifier: "MovieRankingTableViewCell") as? MovieRankingTableViewCell else { return UITableViewCell() }
        
        let row = movieData[indexPath.row]
        
        cell.rankingLabel.text = row.rank
        cell.dateLabel.text = row.openDate
        cell.titleLabel.text = row.title
        cell.dateLabel.sizeToFit()
       
        return cell
    }
    
    
}
