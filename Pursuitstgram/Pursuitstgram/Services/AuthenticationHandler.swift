//
//  AuthenticationHandler.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationHandler{
    
    public func logInWithExistingAccount(_ email: String, _ password: String, completion: @escaping (Result<AuthDataResult,Error>) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = authResult {
                completion(.success(result))
            }
        }
    }
    
    public func createNewAccount(_ email: String, _ password: String, completion: @escaping (Result<AuthDataResult,Error>) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = authResult{
                completion(.success(result))
            }
        }
    }
}
