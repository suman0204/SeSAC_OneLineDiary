//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사과", "사자", "호랑이"]
    var searchList: [String] = ["0"]

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        //XIB 등록
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        setCollectionViewLayout()
        
    }
    
    
    
    //CollectionView 셀 레이아웃 잡는 함수
    func setCollectionViewLayout() {
        
        //cell estimated size none으로 인터페이스 빌더에서 설정할 것!
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        //디바이스 너비: UIScreen.main.bounds.width
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        //클래스이기 때문에 let으로 선언해도 값 수정 가능
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        //컬렉션 뷰에 변경된 레이아웃을 적용시키는 코드
        collectionView.collectionViewLayout = layout
        
    }
    
    
    //1. 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    //2. 셀 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell // guard 구문으로 바인딩해보기
        
        cell.backgroundColor = .brown
        cell.contentsLabel.text = searchList[indexPath.row]
        
        return cell
    }

}

extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("=====")
        
        searchList.removeAll()
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
                print(searchList)
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchList.removeAll()
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
        
        collectionView.reloadData()
    }
    
}
