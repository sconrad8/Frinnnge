//
//  ProfileController.swift
//  Frinnnge
//
//  Created by Samuel Conrad on 10/28/17.
//  Copyright © 2017 assignment. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        checkAuthentication()
        setupViews()
    }
    
    func setupViews() {
        setupLogOutButton()
    }
    
    fileprivate func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                self.present(loginController, animated: true, completion: nil)
            }
            return
        }
    }
    
    //MARK: Logout
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                self.present(LoginController(), animated: true, completion: nil)
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
