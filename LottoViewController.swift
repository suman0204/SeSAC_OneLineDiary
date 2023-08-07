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
        
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var bonusNumberLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let pickerView = UIPickerView()
//    @IBOutlet var pickerView: UIPickerView!
    
    var list: [Int] = Array(1...1100).reversed() //Array(repeating: 100, count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                print("3")
                let data = json["drwNoDate"].stringValue
                let bonusNumber = json["bnusNo"].intValue
                
                print(data, bonusNumber)
                self.dateLabel.text = data
                self.bonusNumberLabel.text = "\(bonusNumber)번"
                
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
