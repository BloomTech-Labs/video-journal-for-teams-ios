//
//  SignUpViewController.swift
//  TeemReel
//
//  Created by Elizabeth Wingate on 5/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class SignUpViewController: UIViewController {
    
    var apiController: APIController?
    var loginType = LoginType.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiController = APIController()

        // Do any additional setup after loading the view.
         setUpElements()
    }
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
     func setUpElements() {
        errorLabel.alpha = 0
     }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
                  
          if error != nil {
        
          showError(error!)
              
        } else {
        
            if let username = usernameTF.text,
            !username.isEmpty,
            let password = passwordTF.text,
            !password.isEmpty,
            let firstN = firstNameTF.text,
            !firstN.isEmpty,
            let lastN = lastNameTF.text,
            !lastN.isEmpty,
            let email = emailTF.text,
            !email.isEmpty {
            let user = User(username: username, password: password, firstName: firstN, lastName: lastN, email: email, id: nil)
            apiController?.signUp(with: user, completion: { (result) in
                do {
                    let success = try result.get()
                    if success {
                        DispatchQueue.main.async {
                         self.transitionToHome()
                        }
                    }
                } catch {
                    print("Error signing up: \(error)")
                }
              })
            }
        }
    }
          
func showError(_ message:String) {
    errorLabel.text = message
    errorLabel.alpha = 1
}

 func validateFields() -> String? {
          
       if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
          usernameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
              
          return "Please fill in all fields."
    }
          
          let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
          if Utilities.isPasswordValid(cleanedPassword) == false {
              // Password isn't secure enough
              return "Please make sure your password is at least 8 characters, contains a special character and a number."
          }
          return nil
      }
    
    // MARK: - Navigation
    func transitionToHome() {
        
    }
}
