//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 홍수만 on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var guideLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var lottoInfoLabel: UILabel!
    
    @IBOutlet var numberLabelCollection: [UILabel]!
    @IBOutlet var bonusNumberLabel: UILabel!
    
    let pickerView = UIPickerView()
//    @IBOutlet var pickerView: UIPickerView!
    
    var list: [Int] = Array(1...1079).reversed() //Array(repeating: 100, count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guideLabel.text = "회차를 선택해주세요"
        numberTextField.text = "회차를 선택해보세요!"
        print("1")
        print("2")
        callRequest(number: 1079)
        
        print("4")
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        print("5")
    }
    
    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
//                print("3")
                let drawNumberList = [
                    json["drwtNo1"].intValue,
                    json["drwtNo2"].intValue,
                    json["drwtNo3"].intValue,
                    json["drwtNo4"].intValue,
                    json["drwtNo5"].intValue,
                    json["drwtNo6"].intValue,
                    
                ]
                
                let bonusNumber = json["bnusNo"].intValue

                let date = json["drwNoDate"].stringValue
                
                print(date, bonusNumber)
                
                
                self.lottoInfoLabel.text = "\(number)회차 (\(date))"
                for index in 0...5 {
                    self.numberLabelCollection[index].text = "\(drawNumberList[index])"
                }
                self.bonusNumberLabel.text = "\(bonusNumber)"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Select \(row)")
        
        numberTextField.text = "\(list[row])"
   
        callRequest(number: list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
        
    }
    
    
}
