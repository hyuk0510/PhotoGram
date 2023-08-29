//
//  ViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework

//Protocol 값 전달 1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol ImageDataDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {

    let mainView = AddView()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 X
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
        //ClassPublicExample.internalExample()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)

        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        //sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        
        //중복 노티 방지 체크!
        print(#function)
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonPressed() {
        
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @objc func searchProtocolButtonPressed() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func dateButtonPressed() {
        //Protocol 값 전달 5.
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonPressed() {
        let vc = TitleViewController()
        
        //Closure - 3
        vc.completionHandler = { title, num, bool in
            self.mainView.titleButton.setTitle(title + "\(num)" + "\(bool)", for: .normal)
            print("completionHandler")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func closureButtonPressed() {
        let vc = ClosureViewController()
        
        vc.completionHandler = { title in
            self.mainView.closureButton.setTitle(title, for: .normal)
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonPressed), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonPressed), for: .touchUpInside)
        mainView.closureButton.addTarget(self, action: #selector(closureButtonPressed), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("Add SetConstraints")
       
    }

}

extension AddViewController: PassDataDelegate {
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: ImageDataDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
