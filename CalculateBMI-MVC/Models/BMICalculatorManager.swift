//
//  BMICalculatorManager.swift
//  CalculateBMI-MVC
//
//  Created by 하연주 on 2023/02/22.
//

import Foundation
import UIKit

struct BMICalculatorManager {
    var bmi : Double?
    
    // 구조체에서 본인의 속성을 바꾸려면 mutating 키워드 필요
    mutating func calculateBMI (h:String, w:String) {
        guard let w = Double(w) ,let h = Double(h) else{return }
        let bmi = w / (h*h) * 10000
        //소수점 한자리까지 반올림
        self.bmi = round(bmi * 10)/10
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
    
    
}
