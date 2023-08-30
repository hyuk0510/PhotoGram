//
//  BaseViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setConstraints()
    }

    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
    }
}
