//
//  ClosureViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/29.
//

import UIKit

class ClosureViewController: BaseViewController {
    
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var completionHandler: ((String) -> Void)?
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        completionHandler?(textView.text)
    }

}
