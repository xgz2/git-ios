//
//  SelectionControllerViewController.swift
//  pic-ios
//
//  Created by Judy Ng on 7/16/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class SelectionController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageView: UIImageView!
    var intensity: UISlider!
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PIC"
        
        // Calls importPicture() and starts the importing process to import a photo
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    // Presents the photo library picker
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // When the user selects the photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        currentImage = image
    }
    
    // currentImage is the image selected!
    // TODO: change from UIImagePickerController to BSImagePicker to allow for multiple selection
}
