//
//  PhotoDetailView.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class PhotoDetailView: UIView {
    
    public lazy var imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    public lazy var uploaderDisplayNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    public lazy var uploaderEmailLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    public lazy var datePostedLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    public lazy var numberOfPhotosSubmittedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
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
        setUpUploaderDisplayNameLabelConstraints()
        setUpUploaderEmailLabelConstraints()
        setUpDatePostedLabelConstraints()
    }
    
    private func setUpImageViewConstraints(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),imageView.centerXAnchor.constraint(equalTo: centerXAnchor), imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5), imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)])
    }
    
    private func setUpUploaderDisplayNameLabelConstraints(){
        addSubview(uploaderDisplayNameLabel)
        uploaderDisplayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([uploaderDisplayNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), uploaderDisplayNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), uploaderDisplayNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
    
    private func setUpUploaderEmailLabelConstraints(){
        addSubview(uploaderEmailLabel)
        uploaderEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([uploaderEmailLabel.topAnchor.constraint(equalTo: uploaderDisplayNameLabel.bottomAnchor, constant: 20), uploaderEmailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), uploaderEmailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
    
    private func setUpDatePostedLabelConstraints(){
        addSubview(datePostedLabel)
        datePostedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([datePostedLabel.topAnchor.constraint(equalTo: uploaderEmailLabel.bottomAnchor, constant: 20), datePostedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), datePostedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }

}
