//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Philip Yu on 5/8/19.
//  Copyright © 2019 Philip Yu. All rights reserved.
//

import UIKit
import Parse
import ProgressHUD

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setup button properties
        loginButton.makeRounded(withRadius: 8)
        registerButton.makeRounded(withRadius: 8)
        
    }

    // MARK: - IBAction Section
    
    @IBAction func onLogin(_ sender: Any) {

        let username = usernameField.text!
        let password = passwordField.text!

        let minUserLength = 1
        let minPasswordLength = 1

        // Validate text fields
        if username.count < minUserLength {
            ProgressHUD.showError("Username must be at least \(minUserLength) characters")
        } else if password.count < minPasswordLength {
            ProgressHUD.showError("Password must be at least \(minPasswordLength) characters")
        } else {
            // Check for empty fields
            if username.isEmpty || password.isEmpty {
                ProgressHUD.showError("All fields are required")
            }

            // Sign in the user asynchronously
            PFUser.logInWithUsername(inBackground: username, password: password) { (success, error) in
                if success != nil {
                    ProgressHUD.showSuccess("Logged In")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    ProgressHUD.showError("Invalid username/password")
                    print("Error: \(String(describing: error!.localizedDescription))")
                }
            }
        }

    }

    @IBAction func onSignUp(_ sender: Any) {

        // Initialize user object
        let user = PFUser()

        // Set User properties
        user.username = usernameField.text
        user.password = passwordField.text

        // Call sign up function on the object
        user.signUpInBackground { (_: Bool, error: Error?) in
            if let error = error {
                ProgressHUD.showError(error.localizedDescription)
                print(error.localizedDescription)
            } else {
                ProgressHUD.showSuccess("Successfully registered account!")
                print("User Registered successfully")
            }
        }

    }

}
