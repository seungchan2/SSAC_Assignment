//
//  ViewController.swift
//  Day9_Assignment-DrinkWater
//
//  Created by 김승찬 on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let userDefaults = UserDefaults.standard
    var todayDrinkWater = Int()
    
    // MARK: @IBOutlets
    @IBOutlet var resetBarButton: UIBarButtonItem!
    @IBOutlet var profileBarButton: UIBarButtonItem!
    @IBOutlet var infoUserLabel: UILabel!
    @IBOutlet var infoTodayLabel: UILabel!
    @IBOutlet var infoTodayDrinkLabel: UILabel!
    @IBOutlet var infoTodayGoalLabel: UILabel!
    @IBOutlet var infoDrinkImage: UIImageView!
    @IBOutlet var todayDrinkTextField: UITextField!
    @IBOutlet var textFieldBottomView: UIView!
    @IBOutlet var mlLabel: UILabel!
    @IBOutlet var recommendWaterLabel: UILabel!
    @IBOutlet var drinkWaterButton: UIButton!
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        dissmissTextFieldKeyboard()
    }
    
    // MARK: - Functions
    private func setUI() {
        self.view.backgroundColor = .backgroundGreen
        
        // NavigationBar
        self.title = "물 마시기"
        self.profileBarButton.image = UIImage(systemName: "person.circle")
        self.profileBarButton.title = .none
        self.resetBarButton.image = UIImage(systemName: "arrow.clockwise")
        self.resetBarButton.title = .none
        self.resetBarButton.tintColor = .white
        self.profileBarButton.tintColor = .white
        
        // Label
        self.infoUserLabel.text = "반갑습니다!"
        self.infoUserLabel.textColor = .white
        self.infoUserLabel.font = .systemFont(ofSize: 18, weight: .medium)
        self.infoTodayLabel.text = "오늘 마신 양은"
        self.infoTodayLabel.numberOfLines = 2
        self.infoTodayLabel.textColor = .white
        self.infoTodayLabel.font = .systemFont(ofSize: 23, weight: .medium)
        
        self.infoTodayDrinkLabel.textColor = .white
        self.infoTodayDrinkLabel.text = "얼마일까요?"
        self.infoTodayDrinkLabel.font = .systemFont(ofSize: 27, weight: .medium)
        
        self.infoTodayGoalLabel.textColor = .white
        self.infoTodayGoalLabel.font = .systemFont(ofSize: 12, weight: .medium)
        self.infoTodayGoalLabel.text = "목표의 ?%"
        
        self.recommendWaterLabel.text = "프로필을 등록해주세요!"
        
        self.todayDrinkTextField.textColor = .white
        self.todayDrinkTextField.font = .systemFont(ofSize: 25, weight: .medium)
        self.todayDrinkTextField.borderStyle = .none
        self.todayDrinkTextField.backgroundColor =  .backgroundGreen
        self.todayDrinkTextField.placeholder = ""
        self.todayDrinkTextField.textAlignment = .right
        self.todayDrinkTextField.keyboardType = .numberPad
        self.mlLabel.text = "ml"
        self.mlLabel.textColor = .white
        
        self.recommendWaterLabel.textColor = .white
        self.recommendWaterLabel.font = .systemFont(ofSize: 14, weight: .medium)
        self.drinkWaterButton.backgroundColor = .white
        self.drinkWaterButton.tintColor = .black
        self.drinkWaterButton.setTitle("물마시기", for: .normal)
        self.drinkWaterButton.layer.cornerRadius = drinkWaterButton.frame.height / 3
        self.drinkWaterButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    func changeTextColor(color: UIColor) {
        self.infoUserLabel.textColor = color
        self.infoTodayDrinkLabel.textColor = color
        self.infoTodayGoalLabel.textColor = color
        self.infoTodayLabel.textColor = color
    }
    
    private func caculateRecommendDrinkWater() -> Float  {
        let height = userDefaults.integer(forKey: "height")
        let weight = userDefaults.integer(forKey: "weight")
        return Float(height + weight) / 100.0
    }
    
    private func dissmissTextFieldKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setProfileImage(percentGoal: Int) {
        switch percentGoal {
        case 0...10:
            infoDrinkImage.image = UIImage(named: "1-1")
        case 10...20:
            infoDrinkImage.image = UIImage(named: "1-2")
        case 20...30:
            infoDrinkImage.image = UIImage(named: "1-3")
        case 30...40:
            infoDrinkImage.image = UIImage(named: "1-4")
        case 40...50:
            infoDrinkImage.image = UIImage(named: "1-5")
        case 50...60:
            infoDrinkImage.image = UIImage(named: "1-6")
        case 60...70:
            infoDrinkImage.image = UIImage(named: "1-7")
        case 70...80:
            infoDrinkImage.image = UIImage(named: "1-8")
        case 80...90:
            infoDrinkImage.image = UIImage(named: "1-9")
        default:
            infoDrinkImage.image = UIImage(named: "1-9")
        }
    }
    
    private func setDrinkWaterButton() {
        guard let mlWater = todayDrinkTextField.text, mlWater != "", let ml = Int(mlWater) else { return }
        let nickName = userDefaults.string(forKey: "nickname")!
        self.infoUserLabel.text = "잘하셨어요!\n 오늘 마신 양은"
        self.todayDrinkWater += ml
        self.userDefaults.setValue(todayDrinkWater, forKey: "todayDrinkWater")
        self.infoTodayDrinkLabel.text = "\(todayDrinkWater)ml"
        
        let caculateWater = caculateRecommendDrinkWater()
        let percentGoal = Int(Float(todayDrinkWater) / (caculateWater * 1000.0) * 100.0)
        self.recommendWaterLabel.text = nickName + "님의 하루 물 권장 섭취량을 \(caculateWater)L입니다."
        
        if todayDrinkWater > Int(caculateWater * 1000) {
            self.infoUserLabel.text = "축하합니다 하루 권장량을 채웠어요!\n오늘 마신 양은"
            changeTextColor(color: .black)
        }
        self.infoTodayGoalLabel.text = "목표의 \(percentGoal)%"
        setProfileImage(percentGoal: percentGoal)
    }
    
    private func setResetButton() {
        self.infoUserLabel.text = "반갑습니다!\n 오늘 마신 양은"
        self.userDefaults.setValue(0, forKey: "todayDrinkWater")
        self.infoTodayGoalLabel.text = "목표의 0%"
        self.recommendWaterLabel.text = "프로필 등록해주세요!"
        self.infoTodayDrinkLabel.text = "0ml"
        changeTextColor(color: .white)
    }
    
    // MARK: - @IBActions
    @IBAction func touchDrinkWaterButton(_ sender: UIButton) {
        setDrinkWaterButton()
    }
    
    @IBAction func touchResetButton(_ sender: UIBarButtonItem) {
        setResetButton()
    }
}





