//
//  LoginView.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    public lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Log in Screen"
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
       let tf = UITextField()
        tf.autocapitalizationType = .sentences
        tf.placeholder = " Enter email address here"
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1.0
        return tf
    }()
    
    public lazy var passwordTextField: UITextField = {
       let tf = UITextField()
        tf.autocapitalizationType = .sentences
        tf.placeholder = " Enter password here"
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1.0
        return tf
    }()
    
    public lazy var signInButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    public lazy var newAccountButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create New Account", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpTitleLabelConstraints()
        setUpEmailTextFieldConstraints()
        setUpPasswordTextFieldConstraints()
        setUpSignInButtonConstraints()
        setUpCreateNewAccountButtonConstraints()
    }
    
    private func setUpTitleLabelConstraints(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30), titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
    
    private func setUpEmailTextFieldConstraints(){
        addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 90), emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), emailTextField.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpPasswordTextFieldConstraints(){
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20), passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), passwordTextField.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpSignInButtonConstraints(){
        addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50), signInButton.centerXAnchor.constraint(equalTo: centerXAnchor), signInButton.heightAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setUpCreateNewAccountButtonConstraints(){
        addSubview(newAccountButton)
        newAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([newAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20), newAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),newAccountButton.heightAnchor.constraint(equalToConstant: 44)])
    }

}
