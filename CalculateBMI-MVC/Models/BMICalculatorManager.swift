//
//  BMICalculatorManager.swift
//  CalculateBMI-MVC
//
//  Created by 하연주 on 2023/02/22.
//

import Foundation
import UIKit

struct BMICalculatorManager {
    var bmi : BMI = BMI(value: 0.0, matchColor: .clear , advice: "")
    
    // 구조체에서 본인의 속성을 바꾸려면 mutating 키워드 필요
    mutating func calculateBMI (h:String, w:String) {
        guard let w = Double(w) ,let h = Double(h) else{return }
        let bmiNum = w / (h*h) * 10000
        //소수점 한자리까지 반올림
        self.bmi.value = round(bmiNum * 10)/10
        
        switch bmi.value {
        case ..<18.6:
            bmi.matchColor = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            bmi.matchColor = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            bmi.matchColor = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            bmi.matchColor = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            bmi.matchColor = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            bmi.matchColor = UIColor.black
        }
        
        switch bmi.value {
        case ..<18.6:
            bmi.advice = "저체중"
        case 18.6..<23.0:
            bmi.advice = "표준"
        case 23.0..<25.0:
            bmi.advice = "과체중"
        case 25.0..<30.0:
            bmi.advice = "중도비만"
        case 30.0...:
            bmi.advice = "고도비만"
        default:
            bmi.advice = ""
        }
        
        
    }
    
    
}
