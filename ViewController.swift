//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Anton Haastrup on 03/04/2020.
//  Copyright © 2020 Anton Haastrup. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var facebookData: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var firebaseManager: FirebaseManager?
    var faceBookManager: FacebookManager?

    override func viewDidLoad() {
        super.viewDidLoad()
      firebaseManager = FirebaseManager(parentVC: self) // enable firebaseManager to update GUI
      faceBookManager = FacebookManager(parentVC: self)
    }
        
        
        
    
    

    @IBAction func signUpbuttonPressed(_ sender: UIButton) {
        if let email = emailField.text,  let pwd = passwordField.text{ //check if password is enough text
            if email.count > 5 && pwd.count > 5 {
            firebaseManager?.signUp(email: email, pwd: pwd)

            }
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        // warning do not hide content here do it in the listener
        firebaseManager?.signOut()
        
    }


    @IBAction func signInPressed(_ sender: UIButton) {
        if verify().isok{
            firebaseManager?.signIn(email: verify().email, pwd:  verify().pwd)
            }
        }
        

    @IBAction func facebookLoginPressed(_
        sender: UIButton) {
        faceBookManager?.loginToFacebook()
        
    }
    
    
    @IBAction func loadFBdata(_ sender: UIButton) {
        faceBookManager?.makeGraphRequest()
        
    }
    
    

func verify() -> (email: String, pwd: String, isok: Bool) {
        if let email = emailField.text,  let pwd = passwordField.text{ //check if password is enough text
    
            
    if email.count > 5 && pwd.count > 5 {
    return (email, pwd, true)
        
}
            
}
    return ("","", false)
}
    
}
