//
//  SetUpTableViewController.swift
//  Day10_Assignment-Memo
//
//  Created by 김승찬 on 2021/10/12.
//

import UIKit

class SetUpTableViewController: UITableViewController {

    var allSettingArray : [String] = ["공지사항", "실험실", "버전 정보"]
    var personalSettingArray : [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 옵션: 섹션 타이틀 : titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "전체 설정"
        case 1:
            return "개인 설정"
        default:
            return "기타"
        }
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           let header = view as! UITableViewHeaderFooterView
           header.textLabel?.textColor = UIColor.gray
    }
    override func numberOfSections(in tableView:    UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return allSettingArray.count
        case 1:
            return personalSettingArray.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = allSettingArray[indexPath.row]
            cell.textLabel?.font = .systemFont(ofSize: 13)
        
        case 1:
            cell.textLabel?.text = personalSettingArray[indexPath.row]
            cell.textLabel?.font = .systemFont(ofSize: 13)
        default:
            cell.textLabel?.text = "고객센터/도움말"
            cell.textLabel?.font = .systemFont(ofSize: 13)
        }
        return cell
    }
  


}
