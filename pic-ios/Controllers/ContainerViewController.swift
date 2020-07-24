//
//  ContainerViewController.swift
//  pic-ios
//
//  Created by George Zhuang on 7/24/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    private let cameraViewController = CameraViewController()
    private let scrollView = UIScrollView()
    private let selectionViewController = SelectionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(cameraViewController)
        addChild(selectionViewController)
        
        navigationController?.isNavigationBarHidden = true
        
        
        
    }

}
