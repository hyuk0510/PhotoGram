//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/28.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    var imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    var photoList: Photos = Photos(total: 0, totalPages: 0, results: [])
    
    var delegate: ImageDataDelegate?
    var completionHandelr: ((String) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UnSplashAPIManager.unsplashRequest(query: "sky") { photos, error in
            guard let photos = photos else { return }
            //dump(photos)
            self.photoList = photos
            self.mainView.collectionView.reloadData()
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver(notification: )), name: NSNotification.Name("RecommandKeyword"), object: nil)
        
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print("recommandKeywordNotificationObserver")
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        let url = URL(string: photoList.results[indexPath.row].urls.raw)
        
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        //
        completionHandelr?(photoList.results[indexPath.row].urls.raw)
        
        //Notification을 통한 값전달
        //NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "선상혁"])
        
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder()
    }
}
