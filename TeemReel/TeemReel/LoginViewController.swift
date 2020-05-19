//
//  LoginViewController.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/15/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements() 
    }
    
    var apiController: APIController?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpElements() {
       errorLabel.alpha = 0
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
