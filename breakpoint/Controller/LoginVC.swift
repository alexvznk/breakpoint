//
//  LoginVC.swift
//  breakpoint
//
//  Created by Alex on 2/24/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func signInBtnWasPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("LoginSuccess")
                } else {
                    print(String(describing:loginError?.localizedDescription))
                
                    print("Hello time to register")
                    AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registrationError) in
                        if success {
                            AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, error) in
                                self.dismiss(animated: true, completion: nil)
                            })
                        } else {
                            print(String(describing: registrationError?.localizedDescription))
                }
                })
            }
            }
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    
}
