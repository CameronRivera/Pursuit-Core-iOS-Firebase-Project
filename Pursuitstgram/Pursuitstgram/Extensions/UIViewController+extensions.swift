//
//  UIViewController+extensions.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(_ title: String?, _ message: String?, completion: ((UIAlertAction) -> ())? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public static func resetWindow(with viewController: UIViewController){
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate = scene.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            fatalError("Could not reset window rootViewController.")
        }
        window.rootViewController = viewController
    }
    
    public static func showViewController(storyboardName: String? = nil, viewControllerId: String? = nil){
        if let sb = storyboardName, let vcID = viewControllerId{
            let storyboard = UIStoryboard(name: sb, bundle: nil)
            let newVC = storyboard.instantiateViewController(identifier: vcID)
            resetWindow(with: newVC)
        } else {
            let rootViewController = UINavigationController(rootViewController: LoginViewController())
            resetWindow(with: rootViewController)
        }
    }
}
