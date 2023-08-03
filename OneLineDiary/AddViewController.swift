//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

class AddViewController: UIViewController {
    
    var type: TransitionType = .add
    
    // 의미 없는 값을 넣어주는 것 보다 옵셔널로 놓기
//    var contents: String?

    var contents: String = ""
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        title = type.rawValue
        textView.text = contents

        switch type {
        case .add:
            title = type.rawValue
            
            let xmark = UIImage(systemName: "xmark")
            
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
            
            navigationItem.leftBarButtonItem?.tintColor = .black
            
            
        case .edit:
            
            print("")
            
            //contents가 옵셔널일 때
//            guard let contents else {
//                return
//            }
        }
            

        
    }

    @objc
    func closeButtonClicked() {
        
        //Present - Dismiss / present로 화면 전환 시 dismiss로  // push로 화면 전환 시 pop으로
        dismiss(animated: true)
        
    }

}

