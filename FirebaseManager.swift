//
//  FirebaseManager.swift
//  FirebaseLogin
//
//  Created by Anton Haastrup on 03/04/2020.
//  Copyright © 2020 Anton Haastrup. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager{
    
    var auth = Auth.auth() // Firebase authentication class.
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
        if user != nil {
            print("Status: user is logged in: \(String(describing: user))") // show some GUI
            parentVC.performSegue(withIdentifier: "Facebook", sender: self)
                }else {
                print("Status: user is logged out") // hide content
                                        
                }
         }
    }
    
    func signUp(email:String, pwd:String) {
         auth.createUser(withEmail: email, password: pwd) { (result, error) in
             if error == nil { // success
                 print("successfully signed up to Firebase \(result.debugDescription)")
             }else {
                 print("Failed to log in \(error.debugDescription)")
             }
         }
     }
     
     func signIn(email:String, pwd:String) {
         auth.signIn(withEmail: email, password: pwd) { (result, error) in
             if error == nil { // success
                    print("successfully logged in to Firebase \(result.debugDescription)")
                    // call parentVC to display something, such as parentVC.showPanel()
                    }else {
                    print("Failed to log in \(error.debugDescription)")
             }
         }
     }
     
     func signOut() {
         do {
             try auth.signOut()
         }catch let error{
             print("error signing out \(error.localizedDescription)")
         }
     }
    
    func signInUsingFacebook(tokenString : String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        auth.signIn(with: credential) { (result, error) in
            if error == nil{
            print("logged in to firebase with facebook \(result?.description)")
      
        }else{
            print("error \(error)")
        }
    }
    
}
}
