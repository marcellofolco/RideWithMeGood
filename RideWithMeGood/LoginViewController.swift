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
        
        if emailTF.text! == "" && passwordTF.text! == ""  {
            displayMyAlertMessage(userMessage: "Please enter valid credentials")
            
        } else if passwordTF.text! == "" {
            displayMyAlertMessage(userMessage: "Please enter a valid password")
        
        } else if emailTF.text! == "" {
            displayMyAlertMessage(userMessage: "Please enter a valid email address")
        }

        
        guard emailTF.text != "", passwordTF.text != "" else {return }
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (user, error) in
            
            if error != nil {
                self.displayMyAlertMessage(userMessage: "Invalid Login")
            }
            
            if let user = user {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapVC")
                
                self.present(vc, animated: true, completion: nil)
            }
            
        })
        
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
        
    }

    
}

