//
//  SearchViewController.swift
//  Day24_Assignment_
//
//  Created by 김승찬 on 2021/11/02.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func assignDelegate() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchTableView.register(nibName, forCellReuseIdentifier: "SearchTableViewCell")
    }

}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell()}
        return cell
    }
    
    
}
