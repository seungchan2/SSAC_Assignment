//
//  HomeViewController.swift
//  Day24_Assignment_
//
//  Created by 김승찬 on 2021/11/02.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
 
    @IBAction func presentWriteView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Write", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "WriteViewController") as? WriteViewController else { return }
        
     
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
   
}
