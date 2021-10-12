//
//  MemoTableViewController.swift
//  Day10_Assignment-Memo
//
//  Created by 김승찬 on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {

    var list: [String] = ["장 보기", "메모메모", "영화 보러 가기", "WWDC 시청하기"]
    
    
    @IBOutlet weak var memoTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        //배열에 텍스트뷰의 텍스트 값 추가
        if let text = memoTextView.text {
        
            list.append(text)
            
            tableView.reloadData()
            print(list)
        } else {
            print("빈 값")
        }
    }
    
    // 옵션: 섹션의 수: numberifSections (default가 1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 옵션: 섹션 타이틀 : titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "나이스"
        default:
            return "엥"
        
        }
    }
    
    
    
    //1. (필수) 셀의 갯수 -> numberofRowsinSection -> 몇 개의 셀을 생성?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : list.count
    }
    
    //2. (필수) 셀의 디자인 및 데이터 처리 -> cellForRowAt -> 셀의 수만큼 반복적으로 호출 IndexPath
    // 재사용 매커니즘, 옵셔널 체이닝, 옵셔널 바인딩
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else { return UITableViewCell()
            
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "첫번째 섹션 입니다~ \(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        } else {
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textColor = .blue
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        return cell
    }
    
    // 옵션 셀을 클릭했을 때 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택")
    }
    
    //3. (옵션) 셀의 높이 -> 스토리보드 / 코드 -> 대부분 코드로
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 44 : 80
        return indexPath.row == 0 ? 44 : 80
    }
    // IndexPaths 특정 섹션의 특정 행에 대한 위치 정보
    // 섹션과 행의 속성을 통해 엑세스 가능 indexPath.row / indexPath.section
    
    // 옵션 셀 스와이프 on / off
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    // (옵션) 셀 편집 상태 editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if editingStyle == .delete {
                list.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
}
