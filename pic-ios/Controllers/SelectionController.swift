//
//  SelectionControllerViewController.swift
//  pic-ios
//
//  Created by Judy Ng on 7/16/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import TLPhotoPicker
import Photos
import SnapKit
import UIKit

class SelectionController: UIViewController,TLPhotosPickerViewControllerDelegate {
    
    private let addButton = UIButton()
    private let cameraButton = UIButton()
    private let instructionsLabel = UILabel()
    private let picLogo = UIImageView(image: UIImage(named: "picLogo"))

    var selectedAssets = [TLPHAsset]()
    var imgSelectedAssets = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        picLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picLogo)
        
        instructionsLabel.text = "Photos all look the same?\nDon’t know which one to use?"
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textAlignment = .center
        instructionsLabel.font = ._27NunitoRegular
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)
                
        addButton.setImage(UIImage(named: "uploadImage"), for: .normal)
        addButton.addTarget(self, action: #selector(pickerButtonTap), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        cameraButton.setImage(UIImage(named: "cameraImage"), for: .normal)
        cameraButton.addTarget(self, action: #selector(nextButtonAction(_:)), for: .touchUpInside)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraButton)
        
        setupConstraints()
    }
    
    @objc func nextButtonAction(_ sender: Any){
        let pageViewController = self.parent as! ContainerPageViewController
        pageViewController.nextPageWithIndex(index: 0)
    }
    
    func setupConstraints() {
        let addButtonTopOffset = 22
        let cameraButtonBottomTrailingOffset = -22
        let instructionsLabelLeadingOffset = 20
        let instructionsLabelTopOffset = 200
        let instructionsLabelTrailingOffset = -20
        let picLogoTopOffset = 60
        let picLogoWidth = 100
        
        picLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(picLogoTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(picLogoWidth)
        }
        
        instructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(picLogo.snp.bottom).offset(instructionsLabelTopOffset)
            make.leading.equalToSuperview().offset(instructionsLabelLeadingOffset)
            make.trailing.equalToSuperview().offset(instructionsLabelTrailingOffset)
            make.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(instructionsLabel.snp.bottom).offset(addButtonTopOffset)
            make.centerX.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(cameraButtonBottomTrailingOffset)
        }
        
    }
    
    @objc func pickerButtonTap() {
        let viewController = TLPhotosPickerViewController()
        viewController.delegate = self
        var configure = TLPhotosPickerConfigure()
        configure.numberOfColumn = 3
        viewController.configure = configure
        viewController.selectedAssets = self.selectedAssets
        self.present(viewController, animated: true, completion: nil)
    }

    func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        // use selected order, fullresolution image
        self.selectedAssets = withTLPHAssets
        // TODO: here, run the function where all the self.selectedAssets are being fed into the PyTorch stuff to be analyzed. selectedAssets are all selected photos but in TLPHAsset format!
        // now self.imgSelectedAssets is array of all the full res images of type UIImage. Send this to PyTorch!
        for image in withTLPHAssets {
            self.imgSelectedAssets.append(image.fullResolutionImage)
        }
        // Probably now will change view controllers to a new view where you can see maybe a loading screen, then once pytorch has analyzed all the photos then u see the grid view.
    return true
    }

    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        let alert = UIAlertController(title: "", message: "Denied camera permissions granted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
    }
    
    // Prob won't use this method, rn gets the first image
    /*func displayImage() {
        let asset = self.selectedAssets.first
        let image = asset?.fullResolutionImage
        // image is the first image chosen in the selected assets!
    }*/
}
