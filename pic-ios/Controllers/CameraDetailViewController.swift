//
//  CameraDetailViewController.swift
//  pic-ios
//
//  Created by George Zhuang on 7/30/20.
//  Copyright © 2020 George, Jonna, Judy. All rights reserved.
//

import SnapKit
import UIKit

class CameraDetailViewController: UIViewController {
    
    private let againButton = UIButton()
    private let downloadButton = UIButton()
    private let overallComment = UILabel()
    private let picLogo = UIImageView(image: UIImage(named: "picLogo"))
    private let primaryDetailComment = UILabel()
    private let secondaryDetailComment = UILabel()
    private let symbolMarker = UIImageView(image: UIImage(named: "checkImage"))
    
    private var aspectRatio : CGFloat!
    private var photo : UIImageView!
    
    init(photoTaken: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        aspectRatio = photoTaken.size.height / photoTaken.size.width
        photo = UIImageView(image: photoTaken)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        picLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picLogo)
        
        photo.layer.cornerRadius = 5.0
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photo)
        
        symbolMarker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(symbolMarker)
        
        overallComment.text = "Looks good!"
        overallComment.font = ._30NunitoBold
        overallComment.numberOfLines = 0
        overallComment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overallComment)
        
        primaryDetailComment.text = "download the photo!"
        primaryDetailComment.font = ._30NunitoBold
        primaryDetailComment.numberOfLines = 0
        primaryDetailComment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(primaryDetailComment)
        
        downloadButton.setImage(UIImage(named: "downloadButton"), for: .normal)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.addTarget(self, action: #selector(save(_:)), for: .touchUpInside)
        view.addSubview(downloadButton)
        
        secondaryDetailComment.text = "a few more details..."
        secondaryDetailComment.font = ._30NunitoBold
        secondaryDetailComment.numberOfLines = 0
        secondaryDetailComment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondaryDetailComment)
        
        againButton.setImage(UIImage(named: "againImage"), for: .normal)
        againButton.addTarget(self, action: #selector(runAgain), for: .touchUpInside)
        againButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(againButton)
        
        setupConstraints()
    }
    
    @objc func save(_ sender: Any) {
        guard let image = photo.image else { return }

        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func runAgain() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        let againButtonBottomTrailingOffset = -25
        let downloadButtonTopOffset = 10
        let overallCommentTopOffset = 24
        let photoLeadingOffset = 25
        let photoTopOffset = 35
        let photoWidth = CGFloat(190)
        let picLogoTopOffset = 60
        let picLogoWidth = 100
        let primaryDetailCommentTopOffset = 22
        let secondaryDetailCommentTopOffset = 26
        let symbolMarkerLeadingOffset = 45
        let symbolMarkerSize = 114
        let symbolMarkerTopOffset = 50
        
        
        picLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(picLogoTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(picLogoWidth)
        }
        
        photo.snp.makeConstraints { make in
            make.top.equalTo(picLogo.snp.bottom).offset(photoTopOffset)
            make.leading.equalToSuperview().offset(photoLeadingOffset)
            make.width.equalTo(photoWidth)
            make.height.equalTo(photoWidth * aspectRatio)
        }
        
        symbolMarker.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.top).offset(symbolMarkerTopOffset)
            make.leading.equalTo(photo.snp.trailing).offset(symbolMarkerLeadingOffset)
            make.size.equalTo(symbolMarkerSize)
        }
        
        overallComment.snp.makeConstraints { make in
            make.top.equalTo(symbolMarker.snp.bottom).offset(overallCommentTopOffset)
            make.centerX.equalTo(symbolMarker.snp.centerX)
        }
        
        primaryDetailComment.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom).offset(primaryDetailCommentTopOffset)
            make.centerX.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(primaryDetailComment.snp.bottom).offset(downloadButtonTopOffset)
            make.centerX.equalToSuperview()
        }
        
        secondaryDetailComment.snp.makeConstraints { make in
            make.top.equalTo(downloadButton.snp.bottom).offset(secondaryDetailCommentTopOffset)
            make.centerX.equalToSuperview()
        }
        
        againButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(againButtonBottomTrailingOffset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
