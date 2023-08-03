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

//1. UITextViewDelegate
//2. textView.delegate = self
class AddViewController: UIViewController, UITextViewDelegate {
    
    var type: TransitionType = .add
    
    // 의미 없는 값을 넣어주는 것 보다 옵셔널로 놓기
//    var contents: String?
    var contents: String = ""
    
    //placeholder
    let placeholderText = "내용을 입력해주세요"
    
    @IBOutlet var contentsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentsTextView.delegate = self
        
        setBackgroundColor()
        
        title = type.rawValue
        contentsTextView.text = contents

        switch type {
        case .add:
            title = type.rawValue
            
            let xmark = UIImage(systemName: "xmark")
            
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
            
            navigationItem.leftBarButtonItem?.tintColor = .black

            contentsTextView.text = placeholderText
            contentsTextView.textColor = .lightGray
            
            
        case .edit:
            
            print("")
            
            //contents가 옵셔널일 때
//            guard let contents else {
//                return
//            }
        }
        
        
    }

    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = "\(textView.text.count)"
    }
    
    //textView의 placeholder만들기
    //편집이 시잘될 때 (커서가 시작될 때)
    //플레이스 홀더와 텍스트뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝날 때 (커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
    
    @objc
    func closeButtonClicked() {
        
        //Present - Dismiss / present로 화면 전환 시 dismiss로  // push로 화면 전환 시 pop으로
        dismiss(animated: true)
        
    }

}

