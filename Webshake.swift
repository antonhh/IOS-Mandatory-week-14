//
//  Webshake.swift
//  FirebaseLogin
//
//  Created by Anton Haastrup on 18/05/2020.
//  Copyright © 2020 Anton Haastrup. All rights reserved.
//

import UIKit
import WebKit

class Webshake: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var text: UITextField!
   
    
    
    
      override func viewDidLoad() {
            super.viewDidLoad()
            
           
        }
        
    
        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake{
                loadWebsite()
            }
        }
        
        
        
        func loadWebsite(){
            let string = text.text ?? ""
             let url = URL (string: "https://" + string)
                   let requestObj = URLRequest(url: url!)
                   webView.load(requestObj)
                   
        }
        
        

    }
