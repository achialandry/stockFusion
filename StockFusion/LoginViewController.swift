//
//  LoginViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-08-02.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftyButton

class LoginViewController: UIViewController {
    
    // MARK: Constants
    let loginToFbDb = "LoginToFbDb"
    
    // MARK: Outlets
    
    @IBOutlet weak var loginFieldTextField: UITextField!
    @IBOutlet weak var passwordFieldTextField: UITextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backgroundImage = UIImage.init(named: "login_bg")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.3
        
        self.view.insertSubview(backgroundImageView, at: 0)
        
        let button  = PressableButton()
        
        button.colors = .init(button: .red, shadow: .white)
        button.shadowHeight = 5
        button.cornerRadius = 5
        button.depth = 0.5
        
        //Login in the User by performing segue on login button
        Auth.auth().addStateDidChangeListener() { auth, user in
            //checking if user is not nil from backend
            if user != nil {
                self.performSegue(withIdentifier: self.loginToFbDb, sender: nil)
               
                //setting fields to nil so user must enter login info again.
                self.loginFieldTextField.text = nil
                self.passwordFieldTextField.text = nil
            }
        }
    }
    
    
    
    // MARK: Actions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        //assigning text field variable and checking to see if its not empty
        guard
            let email = loginFieldTextField.text,
            let password = passwordFieldTextField.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        
        //signing in user
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            //checking to see if there's an error or if user is not available on db
            if let error = error, user == nil {
                print("error: \(error)")
                let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    

    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Up",
                                      message: "You can only Track after signing up",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Register", style: .default) { _ in
            let emailField = alert.textFields![0].text
            let passwordField = alert.textFields![1].text
            
            Auth.auth().createUser(withEmail: emailField!, password: passwordField!) { user, error in
               
                print("Email: \(String(describing: emailField)))")
                print("Password: \(String(describing: passwordField)))")
                print("User: \(String(describing: user))")
                if error == nil {
                    Auth.auth().signIn(withEmail: self.loginFieldTextField.text!, password: self.passwordFieldTextField.text!)
                    print("Error after signup: \(String(describing: error))")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginFieldTextField {
            passwordFieldTextField.becomeFirstResponder()
        }
        if textField == passwordFieldTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
