//
//  LoginViewController.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState{
    case existingUser
    case newAccount
}

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let firebaseAuthentication = AuthenticationHandler()
    private var state = AccountState.existingUser
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
    }
    
    private func setUp(){
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        loginView.signInButton.addTarget(self, action: #selector(loginProcedureEngaged(_:)), for: .touchUpInside)
        loginView.newAccountButton.addTarget(self, action: #selector(createNewAccountPressed(_:)), for: .touchUpInside)
    }
    
    @objc
    private func loginProcedureEngaged(_ sender: UIButton){
        state = AccountState.existingUser
        unwrapEmailAndPassword()
    }
    
    @objc
    private func createNewAccountPressed(_ sender: UIButton){
        state = AccountState.newAccount
        unwrapEmailAndPassword()
    }
    
    private func unwrapEmailAndPassword(){
        guard let emailText = loginView.emailTextField.text, !emailText.isEmpty, let passwordText = loginView.passwordTextField.text, !passwordText.isEmpty else {
            showAlert("Login Error", "One or more fields is missing. Please fill in all fields and try again.")
            return
        }
        loginProcedure(emailText, passwordText)
    }
    
    private func loginProcedure(_ email: String, _ password: String){
        if state == .existingUser{
            firebaseAuthentication.logInWithExistingAccount(email, password) { [weak self] result in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async{
                        self?.showAlert("Authentication Error", "\(error.localizedDescription)")
                    }
                case .success:
                    DispatchQueue.main.async{
                        UIViewController.showViewController(storyboardName: "UserAccount", viewControllerId: "FeedNavigationController")
                    }
                }
            }
        } else {
            firebaseAuthentication.createNewAccount(email, password) { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async{
                        self?.showAlert("Login Error", "\(error.localizedDescription)")
                    }
                case .success:
                    DispatchQueue.main.async{
                        UIViewController.showViewController(storyboardName: "UserAccount", viewControllerId: "FeedNavigationController")
                    }
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
