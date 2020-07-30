//
//  ContainerControllerViewController.swift
//  pic-ios
//
//  Created by George Zhuang on 7/29/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import SnapKit
import UIKit

class ContainerControllerViewController: UIViewController {
    
    private let cameraView = CameraViewController()
    private let scrollView = UIScrollView()
    private let selectionView = SelectionController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        addChild(selectionView)
        scrollView.addSubview(selectionView.view)

        addChild(cameraView)
        scrollView.addSubview(cameraView.view)
        
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: 1)
        view.addSubview(scrollView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
