//
//  WebViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    // MARK: - Properties
    
    let mediaInformation = MediaInformation()
    var destinationURL: String = "https://www.apple.com"
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var mediaTitleLabel: UILabel!
    @IBOutlet var urlSearchBar: UISearchBar!
    @IBOutlet var webView: WKWebView!
   
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlSearchBar.delegate = self
        openWebPage(to: destinationURL)
    }
    
    // MARK: - Functions
    
    func openWebPage(to urlStr: String) {
        guard let url = URL(string: urlStr) else {
            print("error URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    // MARK: - @IBAction Properties
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    @IBAction func dismissButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
// MARK: - UISearchBarDelegate
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(to: searchBar.text!)
    }
}
