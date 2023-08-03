//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

enum TransitionType {
    case add
    case edit
}

class AddViewController: UIViewController {
    
    var type: TransitionType = .add
    
    var contents: String?

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        switch type {
        case .add:
            title = "추가 화면"
            
            let xmark = UIImage(systemName: "xmark")
            
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
            
            navigationItem.leftBarButtonItem?.tintColor = .black
            
//            textView.text = ""
            
        case .edit:
            title = "수정 화면"
            
            guard let contents else {
                return
            }
            textView.text = contents
        }
            

        
    }

    @objc
    func closeButtonClicked() {
        
        //Present - Dismiss / present로 화면 전환 시 dismiss로  // push로 화면 전환 시 pop으로
        dismiss(animated: true)
        
    }

}

