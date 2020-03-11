//
//  FeedViewController.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FeedViewController: UIViewController {

    private var listener: ListenerRegistration?
    private let emptyState = EmptyStateView("No pictures currently in your feed", "Tap on the upload photo button to add a new picture to your feed.")
    private var photoArr = [Photo](){
        didSet{
            collectionView.reloadData()
            setEmptyState()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillLayoutSubviews() {
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.borderWidth = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setEmptyState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener = Firestore.firestore().collection("FeedPhotos").addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async{
                    self?.showAlert("Error", "Could not retrieve feed photos: \(error.localizedDescription)")
                }
            } else if let snapshot = snapshot{
                let pics = snapshot.documents.map{Photo(using:$0.data())!}
                self?.photoArr = pics
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    private func setEmptyState(){
        if photoArr.isEmpty {
            collectionView.backgroundView = emptyState
        } else {
            collectionView.backgroundView = nil
        }
    }
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem){
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func uploadPhotoButtonPressed(_ sender: UIBarButtonItem){
        if let _ = Auth.auth().currentUser?.displayName {
            let uploadPhotoVC = UploadPhotoController()
            navigationController?.pushViewController(uploadPhotoVC, animated: true)
        } else {
            showAlert("Add A Display Name", "You cannot upload a photo without first adding a display name to your profile. Press the \"My Profile\" button in order to add a display name to your profile.")
        }
    }

}

extension FeedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            fatalError("Could not dequeue cell as class FeedCell")
        }
        xCell.configureCell(photoArr[indexPath.row])
        xCell.layer.borderColor = UIColor.black.cgColor
        xCell.layer.borderWidth = 1.0
        return xCell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.8, height: collectionView.bounds.height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = PhotoDetailController(photoArr[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
