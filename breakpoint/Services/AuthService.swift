//
//  AuthService.swift
//  breakpoint
//
//  Created by Alex on 2/24/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": result.user.providerID, "email": result.user.email]
            DataService.instance.createDBUser(uid: result.user.uid, userData: userData)
            userCreationComplete(true, nil)

        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                loginComplete(false, error)
                return
            }
            
            loginComplete(true, nil)
            
        }
        
    }
    
}
