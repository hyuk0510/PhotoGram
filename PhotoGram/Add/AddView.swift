//
//  AddView.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/28.
//

import UIKit

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
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.horizontalEdges.equalTo(self).inset(10)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(photoImageView.snp.bottom)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.size.equalTo(40)
        }
    }
}
