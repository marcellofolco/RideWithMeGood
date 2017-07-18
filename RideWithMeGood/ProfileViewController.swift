//
//  ProfileViewController.swift
//  RideWithMeGood
//
//  Created by User on 2017-07-14.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import FBSDKLoginKit

import Firebase
import FirebaseAuth


class ProfileViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    
    let loginButton = FBSDKLoginButton()
    
    
    
    @IBOutlet weak var usrLbl: UILabel!
    
    
    @IBOutlet weak var cityLbl: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*let  handle = Auth.auth().addStateDidChangeListener { (auth, user) in
         // ...
         }*/
        
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        //self.loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        self.loginButton.frame = CGRect(x: 0, y: 508, width: 320, height: 60)
        
        
        self.loginButton.readPermissions = ["public_profile", "email","user_friends"]
        
        
        self.loginButton.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("User logged in...")
        
        // let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        
        print("User logged in firebase app")
        
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name,city, picture.type(large)"]).start { (connection, result, error) -> Void in
            
            let response = result as AnyObject?
            let first_name = response?.object(forKey: "first_name") as AnyObject?
            let strFirstName: String = (first_name as? String)!
            
            let last_name = response?.object(forKey: "last_name") as AnyObject?
            
            
            
            let strLastName: String = (last_name as? String)!
            
            let city = response?.object(forKey: "city") as AnyObject?
            
            let strCity: String = (city as? String)!
            
            let strPictureURL: String = (((response?.object(forKey:"picture") as AnyObject).object(forKey:"data") as AnyObject).object(forKey:"url") as? String)!
            
            self.usrLbl.text = (strFirstName)+" "+(strLastName)
            
            self.cityLbl.text = strCity
            
            self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: strPictureURL)! as URL)! as Data)
            
            
            
            
        }
        
    }
    
    
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

