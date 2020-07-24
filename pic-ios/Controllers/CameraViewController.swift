//
//  CameraViewController.swift
//  pic-ios
//
//  Created by George Zhuang on 7/21/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import CameraManager
import SnapKit
import UIKit


class CameraViewController: UIViewController {
    
    private let cameraManager = CameraManager()
    private let captureButton = UIButton()
    private let captureButtonSize = CGFloat(85)
    private let cameraContainer = UIView()
    private let interfaceContainer = UIView()
    
    private var myImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(cameraContainer)
        
        cameraManager.cameraDevice = .back
        cameraManager.shouldEnableTapToFocus = true
        cameraManager.shouldEnablePinchToZoom = true
        cameraManager.shouldEnableExposure = true
        cameraManager.flashMode = .off
        cameraManager.cameraOutputMode = .stillImage
        cameraManager.cameraOutputQuality = .high
        cameraManager.focusMode = .continuousAutoFocus
        cameraManager.exposureMode = .continuousAutoExposure
        cameraManager.shouldUseLocationServices = false
        cameraManager.addPreviewLayerToView(cameraContainer)
        
        interfaceContainer.backgroundColor = .clear
        view.addSubview(interfaceContainer)
        view.bringSubviewToFront(interfaceContainer)
        
        captureButton.layer.cornerRadius = captureButtonSize / 2.0
        captureButton.backgroundColor = UIColor(red: 0.839, green: 0.839, blue: 0.839, alpha: 1.0)
        captureButton.layer.borderColor = UIColor.white.cgColor
        captureButton.layer.borderWidth = 7
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        interfaceContainer.addSubview(captureButton)
        
        setupConstraints()
    }
    
    @objc func capturePhoto() {
        cameraManager.capturePictureWithCompletion({ result in
            switch result {
                case .failure:
                    print("FAIL")
                case .success(let content):
                    self.myImage = content.asImage;
            }
        })
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
    }
    
    func setupConstraints() {
        let captureButttonBottomOffset = -26
        
        captureButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(captureButttonBottomOffset)
            make.size.equalTo(captureButtonSize)
            make.centerX.equalToSuperview()
        }
        
        cameraContainer.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        interfaceContainer.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
}
