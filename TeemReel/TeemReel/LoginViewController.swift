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
    
    let apiController = APIController()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    func setUpElements() {
       errorLabel.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {

    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
        apiController.signIn(with: email, password: password) { (error) in
            if let error = error {
              NSLog("Error logging in: \(error)")
                return
            }
            print("Login successful")
            
            
            DispatchQueue.main.async {
//                self.dismiss(animated: true, completion: nil)
                let orgVC = OrganizationsTableViewController()
//                self.parent?.navigationController?.pushViewController(orgVC, animated: true)
                self.navigationController?.pushViewController(orgVC, animated: true)
            }
        }
   }
}
