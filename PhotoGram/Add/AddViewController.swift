//
//  ViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework
import Kingfisher

//Protocol 값 전달 1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol ImageDataDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {

    let mainView = AddView()
    let picker = UIImagePickerController()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 X
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    deinit {
        print("deinit", self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
        
        showAlert()
    }
    
    @objc func searchProtocolButtonPressed() {
        let vc = SearchViewController()
        
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func dateButtonPressed() {
        //Protocol 값 전달 5.
//        let vc = DateViewController()
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonPressed() {
        let vc = TitleViewController()
        
        //Closure - 3
        vc.completionHandler = { title in
            self.mainView.titleButton.setTitle(title, for: .normal)
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
        mainView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonPressed), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonPressed), for: .touchUpInside)
        mainView.closureButton.addTarget(self, action: #selector(closureButtonPressed), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
       
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            self.showGallery()
        }
        let web = UIAlertAction(title: "웹에서 검색하기", style: .default) { _ in
            let vc = SearchViewController()
            vc.completionHandelr = { photoURL in
                let url = URL(string: photoURL)
                self.mainView.photoImageView.kf.setImage(with: url)
            }
            self.present(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(gallery)
        alert.addAction(web)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func showGallery() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
                        
        present(picker, animated: true)
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

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.mainView.photoImageView.image = image
        }
        
        dismiss(animated: true)
    }
}
