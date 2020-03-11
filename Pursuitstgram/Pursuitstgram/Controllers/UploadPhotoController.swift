//
//  UploadPhotoController.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UploadPhotoController: UIViewController {
    
    private let uploadPhotoView = UploadPhotoView()
    private let imagePicker = UIImagePickerController()
    private let storageHandler = StorageHandler()
    private let databaseHandler = FirestoreHandler()
    
    override func loadView() {
        view = uploadPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Upload New Photo"
        setUp()
    }
    
    private func setUp(){
        imagePicker.delegate = self
        view.addGestureRecognizer(uploadPhotoView.longPressGesture)
        uploadPhotoView.longPressGesture.addTarget(self, action: #selector(longPressHappened(_:)))
        uploadPhotoView.uploadButton.addTarget(self, action: #selector(uploadPhotoButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc
    private func longPressHappened(_ sender: UILongPressGestureRecognizer){
        if sender.state == .began || sender.state == .ended{
            return
        }
        showOptions()
    }
    
    @objc
    private func uploadPhotoButtonPressed(_ sender: UIButton){
        guard let uploadImage = uploadPhotoView.imageView.image, let user = Auth.auth().currentUser else {
            return
        }
        
        let resizedImage = UIImage.resizeImage(originalImage: uploadImage, rect: uploadPhotoView.imageView.bounds)
        
        let newPhoto = Photo(imageURL: "", date: Timestamp(date: Date()), uid: user.uid, uploaderEmail: user.email ?? "", uploaderDisplayName: user.displayName ?? "")
        
        databaseHandler.createFeedPhoto(newPhoto) { [weak self] result in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.showAlert("Error", "Could not save data to database: \(error.localizedDescription)")
                }
            case .success(let docID):
                self?.uploadPhoto(resizedImage, docID)
            }
        }
        
    }
    
    private func uploadPhoto(_ image: UIImage, _ docID: String){
        storageHandler.uploadPhoto(.feed, docID, image) { [weak self] result in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.showAlert("Error", "Could not upload photo to storage :\(error.localizedDescription)")
                }
            case .success(let url):
                self?.updatePhotoURL(url, docID)
            }
        }
    }
    
    private func updatePhotoURL(_ url: URL, _ docID: String){
        Firestore.firestore().collection("FeedPhotos").document(docID).updateData(["imageURL":url.absoluteString]) { [weak self] error in
            if let error = error {
                DispatchQueue.main.async{
                    self?.showAlert("Error", "Could not update imageURL: \(error.localizedDescription)")
                }
            } else {
                DispatchQueue.main.async{
                    self?.showAlert("Photo Uploaded", "Your photo was successfully uploaded.")
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func showOptions(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { [weak self] action in
            self?.imagePicker.sourceType = .camera
            self?.present(self!.imagePicker, animated: true, completion: nil)
        }
        let photoLibraryAction = UIAlertAction(title: "Gallery", style: .default){ [weak self] action in
            self?.imagePicker.sourceType = .photoLibrary
            self?.present(self!.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            actionSheet.addAction(cameraAction)
        }
        
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }
}

extension UploadPhotoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        uploadPhotoView.imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
