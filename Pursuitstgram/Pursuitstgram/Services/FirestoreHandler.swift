//
//  FirestoreHandler.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FirestoreHandler {
    public func createFeedPhoto(_ photo: Photo, completion: @escaping (Result<String, Error>) -> ()){
//        guard let user = Auth.auth().currentUser else {
//            return
//        }
        
        let document = Firestore.firestore().collection("FeedPhotos").document()
        Firestore.firestore().collection("FeedPhotos").document(document.documentID).setData(photo.dictionary){ error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(document.documentID))
            }
        }
    }
}
