//
//  PhotoDetailController.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoDetailController: UIViewController {

    private let detailView = PhotoDetailView()
    private let currentPhoto: Photo
    
    override func loadView(){
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpUI()
    }
    
    private func setUp(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "Photo Details"
    }
    
    private func setUpUI(){
        detailView.imageView.kf.setImage(with: URL(string: currentPhoto.imageURL))
        detailView.datePostedLabel.text = "Uploaded on: \(DateConverter.makeMyDateIntoAString(Date(timeIntervalSince1970: Double(currentPhoto.date.seconds))))"
        detailView.uploaderDisplayNameLabel.text = "Uploaded By: \(currentPhoto.uploaderDisplayName)"
        detailView.uploaderEmailLabel.text = "Uploader email: \(currentPhoto.uploaderEmail)"
    }
    
    init(_ photo: Photo){
        currentPhoto = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
