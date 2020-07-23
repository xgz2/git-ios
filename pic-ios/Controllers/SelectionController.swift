//
//  SelectionControllerViewController.swift
//  pic-ios
//
//  Created by Judy Ng on 7/16/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Photos

import Foundation
import TLPhotoPicker

class SelectionController: UIViewController,TLPhotosPickerViewControllerDelegate {

    var selectedAssets = [TLPHAsset]()
    var label: UILabel!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PIC"
        
        // Placeholder UI for now
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickerButtonTap))
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
        // So we have TLPHAssets, to get the full res image you do:
        // let image = asset.fullResolutionImage, where asset is one item in withTLPHAssets
        
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
}
