//
//  FeedViewController.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FeedViewController: UIViewController {

    private let emptyState = EmptyStateView("No pictures currently in your feed", "Tap on the upload photo button to add a new picture to your feed.")
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem){
        
    }
    
    @IBAction func uploadPhotoButtonPressed(_ sender: UIBarButtonItem){
        
    }

}
