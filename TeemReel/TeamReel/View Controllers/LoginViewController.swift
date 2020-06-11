//
//  LoginViewController.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/15/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import SwiftUI

protocol Authorized {
    func userWasAuthorized()
}

class LoginViewController: UIViewController {
    
    var delegate: Authorized?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
    }
    
    var customTextField: CustomTextField?
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
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var createAButton: UIButton!
    

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
            
//            self.delegate?.userWasAuthorized()
            
            DispatchQueue.main.async {
                let parent = self.presentingViewController
                self.dismiss(animated: true, completion: nil)
                parent?.dismiss(animated: false, completion: nil)
                
            }
        }
   }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
