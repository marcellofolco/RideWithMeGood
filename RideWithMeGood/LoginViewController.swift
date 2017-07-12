//
//  LoginViewController.swift
//  RideWithMeGood
//
//  Created by Marcello Folco on 2017-07-11.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.loadGif(name: "courier")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        guard emailTF.text != "", passwordTF.text != "" else {return }
        
        Auth.auth().signIn(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
        
    }
    
}

