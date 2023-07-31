//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    var list = ["테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1", "테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2", "테스트3"] // 저장프로퍼티

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        // XIB로 테이블뷰셀을 생성할 경우, 테이블뷰에 사용할 셀을 등록해주는 과정이 필요!
        let nib = UINib(nibName: "DiaryTableViewCell", bundle: nil) // bundel: nil로 설정시 Navigation bar가 기본 경로로 지정됨
        tableView.register(nib, forCellReuseIdentifier: "DiaryTableViewCell")
        
        
//        tableView.backgroundColor = .clear
        
        //Dynamic Height: 1. automaticDimension, 2. labe numberOfLines, 3. AutoLayout(여백)
        tableView.rowHeight = UITableView.automaticDimension
    }

    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        // Search 아이콘 클릭 시 SearchCollectionViewController Push!
        
        //1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //2. 스토리보드 파일 내 뷰컨트롤러 찾기
        let vc = sb.instantiateViewController(withIdentifier: "SearchCollectionViewController") as! SearchCollectionViewController
        
        // Push를 위해선 네비게이션뷰컨트롤러가 연결되어 있어야함
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func addBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        //1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //2. 스토리보드 파일 내 뷰컨트롤러 찾기
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController // 옵셔널 바인딩으로 바꿔보기...
        
        //2-1(옵션). 네비게이션 컨트롤러가 있는 형태(제목바)로 Present 하고 싶은 경우
        //nav를 사용한다면, present와 화면 전환 방식도 nav로 수정해주어야 함!!
        let nav = UINavigationController(rootViewController: vc)
        
        //3. 화면 전환 방식 설정하기
        //        nav.modalTransitionStyle = .crossDissolve //모달 애니메이션
        nav.modalPresentationStyle = .fullScreen
        //4. 화면 띄우기
        present(nav, animated: true) //modal
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.indentifier) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentLabel.numberOfLines = 0
        cell.contentLabel.text = list[indexPath.row]
        cell.backgroundColor = .clear
        
        return cell
    }

    
    
    
    // Cell Swipe
    // * System Swipe
    //1. System Delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //2. System Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row)
        
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //present, DetailViewController(UIViewController) 생성해서 present 해보기!
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
//        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .automatic
        
        //Pass Data 2. vc가 가지고 있는 프로퍼티에 데이터 추가
        vc.contents = list[indexPath.row]
        
        //인터페이스 빌더에서 생성하는 순서가 여기서 할당하는 순서보다 늦기 때문에 nil..
//        vc.contentsLabel.text = list[indexPath.row]
        
        //인터페이스 빌더에 네비게이션 컨트롤러가 임베드 되어 있어야만 Push가 동작합니다!
        navigationController?.pushViewController(vc, animated: true) // interface builder에서의 show 기능
//        present(vc, animated: true)
        
    }
    
//    //Custom Swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        //UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//    }
//    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
}
