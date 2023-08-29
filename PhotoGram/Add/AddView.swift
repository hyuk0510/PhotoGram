//
//  AddView.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/28.
//

import UIKit
import SnapKit

class AddView: BaseView {
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.contentMode = .scaleToFill
        return view
    }()
    
    let searchButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        return button
    }()
    
    let searchProtocolButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let closureButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("클로저로 값 전달 버튼", for: .normal)
        return view
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(searchProtocolButton)
        addSubview(dateButton)
        addSubview(titleButton)
        addSubview(closureButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(photoImageView)
            make.size.equalTo(50)
        }
        searchProtocolButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(photoImageView)
            make.size.equalTo(50)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.size.equalTo(50)
        }
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        closureButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
}
