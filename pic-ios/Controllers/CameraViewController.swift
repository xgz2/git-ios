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
    private let loadingView = LoadingView()
    private let selectionButton = UIButton()
    
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
        cameraManager.writeFilesToPhoneLibrary = false
        cameraManager.addPreviewLayerToView(cameraContainer)
        
        interfaceContainer.backgroundColor = .clear
        view.addSubview(interfaceContainer)
        view.bringSubviewToFront(interfaceContainer)
        
        captureButton.layer.cornerRadius = captureButtonSize / 2.0
        captureButton.backgroundColor = UIColor(red: 0.839, green: 0.839, blue: 0.839, alpha: 1.0)
        captureButton.layer.borderColor = UIColor.white.cgColor
        captureButton.layer.borderWidth = 7
        captureButton.layer.shadowColor = UIColor.black.cgColor
        captureButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        captureButton.layer.shadowRadius = 5
        captureButton.layer.shadowOpacity = 0.5
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        interfaceContainer.addSubview(captureButton)
        
        selectionButton.setImage(UIImage(named: "selectImage"), for: .normal)
        selectionButton.addTarget(self, action: #selector(selectionButtonAction(_:)), for: .touchUpInside)
        selectionButton.translatesAutoresizingMaskIntoConstraints = false
        interfaceContainer.addSubview(selectionButton)
        
        view.addSubview(loadingView)
        
        setupConstraints()
    }
    
    @objc func selectionButtonAction(_ sender: Any){
        let pageViewController = self.parent as! ContainerPageViewController
        pageViewController.nextPageWithIndex(index: 1)
    }
    
    @objc func capturePhoto() {
        self.cameraManager.capturePictureWithCompletion({ result in
            switch result {
                case .failure:
                    print("FAIL")
                case .success(let content):
                    self.myImage = content.asImage;
            }
        })
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            let vc = CameraDetailViewController(photoTaken: self.myImage!)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        })
        loadingView.startAnimation()
        CATransaction.commit()
    }
    
    func setupConstraints() {
        let captureButttonBottomOffset = -36
        let selectionButtonTrailingOffset = -35
        
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
        
        selectionButton.snp.makeConstraints { make in
            make.centerY.equalTo(captureButton.snp.centerY)
            make.trailing.equalToSuperview().offset(selectionButtonTrailingOffset)
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
}
