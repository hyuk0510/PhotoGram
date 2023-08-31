//
//  TitleViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textfield = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    //Closure - 1
    var completionHandler: ((String) -> Void)?
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textfield)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonPressed))
    }
    
    @objc func doneButtonPressed() {
        
        completionHandler?(textfield.text!)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        textfield.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //Closure - 2
        completionHandler?(textfield.text!)
    }
    
    deinit {
        print("deinit", self)
    }
}
