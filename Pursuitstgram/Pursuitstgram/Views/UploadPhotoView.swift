//
//  UploadPhotoView.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class UploadPhotoView: UIView {
    
    public lazy var directionsLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Long press on the imageView to load a photo"
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "moon")
        return imageView
    }()
    
    public lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload Photo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    public lazy var longPressGesture: UILongPressGestureRecognizer = {
       let lp = UILongPressGestureRecognizer()
        return lp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpImageViewConstraints()
        setUpDirectionsLabelConstraints()
        setUpUploadButtonConstraints()
    }
    
    private func setUpImageViewConstraints(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.centerYAnchor.constraint(equalTo: centerYAnchor), imageView.centerXAnchor.constraint(equalTo: centerXAnchor), imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0), imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)])
    }
    
    private func setUpDirectionsLabelConstraints(){
        addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([directionsLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20), directionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8), directionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
    }
    
    private func setUpUploadButtonConstraints(){
        addSubview(uploadButton)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), uploadButton.centerXAnchor.constraint(equalTo: centerXAnchor), uploadButton.heightAnchor.constraint(equalToConstant: 44)])
    }

}
