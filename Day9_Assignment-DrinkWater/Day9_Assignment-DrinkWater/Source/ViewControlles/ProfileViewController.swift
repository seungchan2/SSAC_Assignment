//
//  ProfileViewController.swift
//  Day9_Assignment-DrinkWater
//
//  Created by 김승찬 on 2021/10/10.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {
    
    // MARK: - Property
    enum EmptyError: Error {
        case emptyNickname
        case emptyHeight
        case emptyWeight
    }
    
    // MARK: - @IBOutlets
    @IBOutlet var plantImageView: UIImageView!
    @IBOutlet var nicknameTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        dismissTextFieldKeyboard()
        checkNicknameTextField()
    }

    // MARK: - Functions
    private func setUI() {
        // NavigationBar
        self.view.backgroundColor = .backgroundGreen
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchSaveButton))
        self.navigationController?.navigationBar.tintColor = .white
        
        // TextField
        setTextField(textField: nicknameTextField, text: "닉네임을 설정해주세요(2~6자)")
        setTextField(textField: heightTextField, text: "키(cm)를 설정해주세요")
        setTextField(textField: weightTextField, text: "몸무게(kg)를 설정해주세요")
    }
    
    private func setTextField(textField: HoshiTextField, text: String) {
        textField.textColor = .white
        textField.placeholderColor = .white
        textField.borderActiveColor = .white
        textField.borderInactiveColor = .white
        textField.borderStyle = .line
        textField.placeholder = text
        textField.placeholderFontScale = 0.8
        textField.textAlignment = .left
        textField.autocorrectionType = .no
        textField.keyboardType = .namePhonePad
    }
    
    private func checkEmptyTextField() {
        if let nickname = nicknameTextField.text, let height = heightTextField.text, let weight = weightTextField.text {
            nickname == "" ? self.showEmptyErrorAlert(error: .emptyNickname) : print(nickname)
            height == "" ? self.showEmptyErrorAlert(error: .emptyHeight) : print(height)
            weight == "" ? self.showEmptyErrorAlert(error: .emptyWeight) : print(weight)
            nickname != "" && height != "" && weight != "" ? self.showOkAlert() : print(nickname, height, weight)
        }
    }
    
    @objc func touchSaveButton(_ sender: UIBarButtonItem) {
        checkEmptyTextField()
        if let nickname = nicknameTextField.text, let height = heightTextField.text, let weight = weightTextField.text {
            UserDefaults.standard.setValue(nickname, forKey: "nickname")
            UserDefaults.standard.setValue(height, forKey: "height")
            UserDefaults.standard.setValue(weight, forKey: "weight")
        }
    }
    
    private func setTextField() {
        guard let nickName = UserDefaults.standard.string(forKey: "nickname") else { return }
        self.nicknameTextField.text = nickName
        self.heightTextField.text = "\(UserDefaults.standard.integer(forKey: "height"))"
        self.weightTextField.text = "\(UserDefaults.standard.integer(forKey: "weight"))"
    }
    
    private func showEmptyErrorAlert(error: EmptyError) {
        let ok = UIAlertAction(title: "확인", style: .default)
        let alert: UIAlertController
        switch error {
        case .emptyNickname:
            alert = UIAlertController(title: "닉네임을 입력해주세요", message: .none, preferredStyle: .alert)
        case .emptyHeight:
            alert = UIAlertController(title: "키를 입력해주세요", message: .none, preferredStyle: .alert)
        case .emptyWeight:
            alert = UIAlertController(title: "몸무게를 입력해주세요", message: .none, preferredStyle: .alert)
        }
        alert.addAction(ok)
        self.present(alert,animated: true)
    }
    
    private func showOkAlert() {
        let ok = UIAlertAction(title: "확인", style: .default)
        let alert = UIAlertController(title: "저장 완료!", message: .none, preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func validateNickName(nickname: String) -> Bool {
        // 닉네임 정규식
        let nicknameRegEx = "[가-힣]{1,6}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: nickname)
    }
    
    private func checkNicknameTextField() {
        nicknameTextField.addTarget(self, action: #selector(ProfileViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let nickname = nicknameTextField.text else { return }
        if 1 < nickname.count && nickname.count < 7 {
            nicknameTextField.placeholderColor = .white
        } else {
            nicknameTextField.placeholderColor = .red
            if !validateNickName(nickname: nickname) {
                nicknameTextField.placeholder = "올바르지 않은 닉네임입니다"
            } else {
                setTextField(textField: nicknameTextField, text: "올바른 닉네임입니다")
            }
        }
    }
    
    private func dismissTextFieldKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
