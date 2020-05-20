//
//  LoginViewController.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/15/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    var apiController: APIController?
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.tintColor = UIColor.lightGray
            emailTextField.setIcon(UIImage(named: "icon-user")!)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tintColor = UIColor.lightGray
            passwordTextField.setIcon(UIImage(named: "icon-lock")!)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var createAButton: UIButton!
    
    func setUpElements() {
        
       errorLabel.alpha = 0
       loginButton.layer.cornerRadius = 8.0
        createAButton.layer.cornerRadius = 8.0
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard let apiController = apiController else { return }
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
        apiController.signIn(with: email, password: password) { (error) in
            if let error = error {
              NSLog("Error logging in: \(error)")
                return
            }
            print("Login successful")
            
            
            DispatchQueue.main.async {
                let parent = self.presentingViewController
                self.dismiss(animated: true, completion: nil)
                parent?.dismiss(animated: true, completion: nil)
                
            }
        }
   }

}

extension UITextField {
    
func setIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 10, y: 5, width: 20, height: 20))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 20, y: 0, width: 30, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
  }
}
