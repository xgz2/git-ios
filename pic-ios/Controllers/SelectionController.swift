//
//  SelectionControllerViewController.swift
//  pic-ios
//
//  Created by Judy Ng on 7/16/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import TLPhotoPicker
import Photos
import UIKit

class SelectionController: UIViewController,TLPhotosPickerViewControllerDelegate {

    var selectedAssets = [TLPHAsset]()
    var imgSelectedAssets = [UIImage?]()
    var label: UILabel!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
