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

class LoginViewController: UIViewController, GIDSignInUIDelegate{
    
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        gifView.loadGif(name: "courier")
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 65, y: 523, width: 130, height: 30)
        googleButton.layer.cornerRadius = 18
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfile")
        
        self.present(vc, animated: true, completion: nil)
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
            
            if user != nil {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC")
                
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

