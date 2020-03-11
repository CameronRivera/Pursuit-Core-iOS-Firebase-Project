//
//  ProfileViewController.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    private let imagePicker = UIImagePickerController()
    private let storageHandler = StorageHandler()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        updateProfilePic()
    }
    
    private func setUp(){
        view.backgroundColor = .systemBackground
        profileView.displayNameTextField.delegate = self
        navigationItem.rightBarButtonItem = profileView.logOutButton
        profileView.logOutButton.target = self
        profileView.logOutButton.action = #selector(logOutButtonPressed)
        profileView.editProfilePictureButton.addTarget(self, action: #selector(editProfilePictureButtonPressed(_:)), for: .touchUpInside)
        profileView.commitChangesButton.addTarget(self, action: #selector(commitChangesButtonPressed(_:)), for: .touchUpInside)
        navigationItem.title = "My Profile"
        imagePicker.delegate = self
        profileView.displayNameTextField.text = Auth.auth().currentUser?.displayName
    }
    
    private func updateProfilePic(){
        guard let user = Auth.auth().currentUser else {
            return
        }
        if let _ = user.photoURL{
            profileView.profileImage.kf.setImage(with: user.photoURL)
        } else {
            profileView.profileImage.image = UIImage(systemName: "person")
        }
    }
    
    @objc
    private func logOutButtonPressed(_ sender: UIBarButtonItem){
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController()
        } catch {
            showAlert("Error", "Could not sign out: \(error.localizedDescription)")
        }
    }
    
    @objc
    private func editProfilePictureButtonPressed(_ sender: UIButton){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] action in
            self?.imagePicker.sourceType = .camera
            self?.present(self!.imagePicker, animated: true, completion: nil)
        }
        let galleryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] action in
            self?.imagePicker.sourceType = .photoLibrary
            self?.present(self!.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            actionSheet.addAction(cameraAction)
        }
        
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc
    private func commitChangesButtonPressed(_ sender: UIButton){
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let request = user.createProfileChangeRequest()
        var nameString = ""
        
        if let name = profileView.displayNameTextField.text, !name.isEmpty{
            nameString = name
        }
        
        if let image = profileView.profileImage.image {
            storageHandler.uploadPhoto(.profile, user.uid, image) {[weak self] result in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async{
                        self?.showAlert("Error", "Could not upload photo to storage: \(error.localizedDescription)")
                    }
                case .success(let url):
                    request.photoURL = url
                    request.displayName = nameString
                    request.commitChanges { [weak self] error in
                        if let error = error {
                            DispatchQueue.main.async{
                                self?.showAlert("Error", "Could not update profile: \(error)")
                            }
                        } else {
                            DispatchQueue.main.async{
                                self?.showAlert("Profile Updated", "Your profile has been updated.")
                            }
                        }
                    }
                }
            }
        }
        
    }
}

extension ProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        let newImage = UIImage.resizeImage(originalImage: image, rect: profileView.profileImage.bounds)
        profileView.profileImage.image = newImage
        dismiss(animated: true, completion: nil)
    }
}
