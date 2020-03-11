//
//  ProfileView.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    public lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "person")
        return iv
    }()
    
    public lazy var logOutButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.title = "Sign Out"
        return button
    }()
    
    public lazy var displayNameTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = " Enter profile name here"
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1.0
        return tf
    }()
    
    public lazy var editProfilePictureButton: UIButton = {
       let button = UIButton()
        button.setTitle("Edit profile picture", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    public lazy var commitChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Commit Changes", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
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
        setUpProfileImageConstraints()
        setUpDisplayNameTextFieldConstraints()
        setUpEditProfilePictureButtonConstraints()
        setUpCommitChangesButtonConstraints()
    }
    
    private func setUpProfileImageConstraints() {
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), profileImage.centerXAnchor.constraint(equalTo: centerXAnchor), profileImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23), profileImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)])
    }
    
    private func setUpDisplayNameTextFieldConstraints() {
        addSubview(displayNameTextField)
        displayNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([displayNameTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 50), displayNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), displayNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), displayNameTextField.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpEditProfilePictureButtonConstraints() {
        addSubview(editProfilePictureButton)
        editProfilePictureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([editProfilePictureButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 20), editProfilePictureButton.centerXAnchor.constraint(equalTo: centerXAnchor), editProfilePictureButton.heightAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setUpCommitChangesButtonConstraints() {
        addSubview(commitChangesButton)
        commitChangesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([commitChangesButton.topAnchor.constraint(equalTo: editProfilePictureButton.bottomAnchor, constant: 20), commitChangesButton.centerXAnchor.constraint(equalTo: centerXAnchor), commitChangesButton.heightAnchor.constraint(equalToConstant: 44)])
    }
}
