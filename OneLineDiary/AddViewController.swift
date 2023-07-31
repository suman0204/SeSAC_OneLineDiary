//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
            
        title = "추가 화면"
        
        let xmark = UIImage(systemName: "xmark")
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }

    @objc
    func closeButtonClicked() {
        
        //Present - Dismiss / present로 화면 전환 시 dismiss로  // push로 화면 전환 시 pop으로
        dismiss(animated: true)
        
    }

}

