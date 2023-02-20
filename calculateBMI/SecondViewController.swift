//
//  SecondViewController.swift
//  calculateBMI
//
//  Created by 하연주 on 2023/02/20.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviseLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var bmi : Double?
    var labelColor : UIColor?
    var adviseComment : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    func makeUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 15
        //계산 결과에 따라 다름
        bmiNumberLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 8
        
        //계산 결과에 따라 다름
//        adviseLabel.text = "표준체중입니다."
        
        guard let bmi = bmi else {return}
        bmiNumberLabel.text = String(bmi)
        adviseLabel.text = adviseComment ?? "-"
        bmiNumberLabel.backgroundColor = labelColor ?? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
