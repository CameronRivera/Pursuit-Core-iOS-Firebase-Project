//
//  Photo.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Photo{
    let imageURL: String
    let date: Timestamp
    let uid: String
    let uploaderEmail: String
    let uploaderDisplayName: String
    
    init(imageURL: String, date: Timestamp, uid: String, uploaderEmail: String, uploaderDisplayName: String){
        self.imageURL = imageURL
        self.date = date
        self.uid = uid
        self.uploaderEmail = uploaderEmail
        self.uploaderDisplayName = uploaderDisplayName
    }
    
    init? (using dict: [String:Any]){
        guard let url = dict["imageURL"] as? String,
              let date = dict["date"] as? Timestamp,
              let uid = dict["uid"] as? String,
              let uploaderEmail = dict["email"] as? String,
            let uploaderDisplayName = dict["displayName"] as? String else {
                return nil
        }
        self.imageURL = url
        self.date = date
        self.uid = uid
        self.uploaderEmail = uploaderEmail
        self.uploaderDisplayName = uploaderDisplayName
    }
    
    var dictionary: [String: Any]{
        return [
            "imageURL": imageURL,
            "date": date,
            "uid": uid,
            "email": uploaderEmail,
            "displayName": uploaderDisplayName
        ]
    }
}
