//
//  ViewController.swift
//  curculateBMI
//
//  Created by 하연주 on 2023/02/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculateBMIButton: UIButton!
    var bmi : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    func makeUI () {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        calculateBMIButton.clipsToBounds = true
        calculateBMIButton.layer.cornerRadius = 8//버튼을 둥글게
        calculateBMIButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        heightTextField.clipsToBounds = true
        heightTextField.layer.cornerRadius = 15
//        heightTextField.keyboardType = .numberPad //숫자만 입력 가능하도록
        
        weightTextField.placeholder = "kg 단위로 입력해주세요"
        weightTextField.clipsToBounds = true
        weightTextField.layer.cornerRadius = 15
//        weightTextField.keyboardType = .numberPad //숫자만 입력 가능하도록
    }

    
    @IBAction func calculateBMIButtonTapped(_ sender: UIButton) {
        //bmi 값 계산
        self.bmi = calculateBMI(h: heightTextField.text ?? "0.0", w: weightTextField.text ?? "0.0")
    }
    
    func calculateBMI (h:String, w:String) -> Double {
        let bmi = Double(w)! / (Double(h)!*Double(h)!) * 10000
        //소수점 한자리까지 반올림
        return round(bmi * 10)/10
    }
    
    // 색깔 얻는 메서드
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    // 문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("키보드 외의 영역 클릭")
        self.view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text != "" && weightTextField.text != "" {
            mainLabel.text = "키와 몸무게를 입력해주세요"
            mainLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            return true
        }
        mainLabel.text = "빈칸을 채워주세요"
        mainLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            
            secondVC.bmi = self.bmi
            secondVC.adviseComment = getBMIAdviceString()
            secondVC.labelColor = getBackgroundColor()
        }
        
        //다음 화면으로 넘어갈 때 텍스트필드 비워주기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
}


extension ViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //backspace 누른건 유효하도록
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        guard Int(string) != nil else {
            print("숫자가 아니다")
            return false
            
        }
        print("숫자다")
        return true
        
        //방법2
//        if Int(string) != nil || string.isEmpty {
//            return true
//        }
//        return false
    }
    
    
    //키 입력창에서 엔터키 누르면 다음 입력창(몸무게)로 이동할 수 있도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == heightTextField {
            print("키 텍스트필드 눌렸다")
            weightTextField.becomeFirstResponder()
        }
        
        return true
    }
}

