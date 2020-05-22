//
//  FacebookManager.swift
//  FirebaseLogin
//
//  Created by Anton Haastrup on 03/04/2020.
//  Copyright © 2020 Anton Haastrup. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookManager{
    
    let parentVC: ViewController
    
    init(parentVC: ViewController) {
        self.parentVC = parentVC
    }
    
    
    
    func loginToFacebook() {
        print("facebook log")
               let manager = LoginManager()
               manager.logIn(permissions: [.publicProfile], viewController: parentVC)
               {  (result)  in
                   print("logged in \(result)")
                    
                   switch result{
                   case.cancelled :
                       print("Login was cancelled")
                       break
                   case.failed(let error):
                       print("login failed \(error)")
                       break
                   case let.success(granted: _, declined: _, token: token):
                       print("facebook login sucess \(token.userID)")
                       self.parentVC.firebaseManager?.signInUsingFacebook(tokenString: token.tokenString)
                   }
           }
            
    }
    
    func makeGraphRequest() {
        if let tokenStr = AccessToken.current?.tokenString{
                  let graphRequest = GraphRequest(graphPath: "/me", parameters: ["Fields": "id, name, email, picture"], tokenString: tokenStr, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
                  let connection = GraphRequestConnection()
                  connection.add(graphRequest) { (connection, result, error) in
                      if error == nil , let res = result{
                          let dict = res as! [String: Any]
                          let name = dict["name"] as! String
                          
                          print("got name from facebook \(name)")
                          print(dict)
                      }else{
                          print("error getting data \(error)")
                      }
                  }
                  connection.start()
              }
    }
    
}


