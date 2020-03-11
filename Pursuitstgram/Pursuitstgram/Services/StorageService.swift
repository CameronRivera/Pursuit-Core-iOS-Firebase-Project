//
//  StorageService.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseStorage

enum PicturePurpose{
    case profile
    case feed
}

class StorageHandler {
    private let storageRef = Storage.storage().reference()
    
    public func uploadPhoto(_ purpose: PicturePurpose,_ id: String,_ image: UIImage, completion: @escaping (Result<URL,Error>) -> ()){
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        var photoReference: StorageReference!
        if purpose == .profile{
            photoReference = storageRef.child("UserProfilePhotos/\(id).jpeg")
        } else {
           photoReference = storageRef.child("FeedPhoto/\(id).jpeg")
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let _ = photoReference.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error{
                completion(.failure(error))
            } else {
                photoReference.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
    }
}
