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

import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate,FBSDKLoginButtonDelegate,GIDSignInDelegate{
    
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    var userFB: User = User()
    
    var userGG: User = User()
    
    
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        gifView.loadGif(name: "courier")
        
        
        
        let facebookButton = FBSDKLoginButton()
        
        facebookButton.frame = CGRect(x: 199, y: 526, width: 110, height: 42)
        facebookButton.layer.cornerRadius = 18
        view.addSubview(facebookButton)
        
        facebookButton.readPermissions = ["public_profile", "email","user_friends","user_location"]
        
        
        facebookButton.delegate = self

        
        
        
        
        
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 65, y: 523, width: 100, height: 30)
        googleButton.layer.cornerRadius = 18
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /*func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfile")
        
        self.present(vc, animated: true, completion: nil)
    }*/
    
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
    
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        if(error != nil){
            
            print(error)
            
            return
            
        } else {
            
            //let  user = Auth.auth().currentUser
            
            
            
            
            print(user.profile.email)
            
            print(user.profile.familyName)
            
            print(user.profile.name)
            
            print(user.profile.givenName)
            
            //print(user.profile.name)
            
            print(user.profile.imageURL(withDimension: 100))
            
            
            let strFirst:String = user.profile.familyName
            
            let strLast:String = user.profile.givenName
            
            let strCity:String = ""
            
            let strEmail:String = user.profile.email
            
            let picture: String = String(describing: user.profile.imageURL(withDimension: 100))
            
            
            
            
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! TabBarViewController
            
            self.present(viewController, animated: true, completion: nil)
            
            
            
            self.userGG = User()
            
            
            self.userGG.setFirstName(firstName: strFirst)
            
            self.userGG.setLasttName(lastName:strLast)
            
            self.userGG.setCity(city: strCity)
            
            self.userGG.setEmail(email: strEmail)
            
            
            
            self.userGG = User(firstName: strFirst,lastName: strLast,email: strEmail,picture:picture)
            
            
            
            
            viewController.user2 = self.userGG
            
            
        }
        
        
        
        
        
        /*  let userInfo = Auth.auth().currentUser?.providerData[(index as NSIndexPath).row]
         cell?.textLabel?.text = userInfo?.providerID
         // Provider-specific UID
         cell?.detailTextLabel?.text = userInfo?.uid*/
        
        
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        
        if(error != nil){
            
            print("Process Error!")
            
        } else if(result.isCancelled){
            
            print("User cancelled")
            
            
            
        } else{
            
            
            print("User is SUccessfully Logged in....")
            
            
            
            
            let accessToken = FBSDKAccessToken.current()
            
            let accessTokenString = accessToken?.tokenString!
            
            
            
            let credentials =
                FacebookAuthProvider.credential(withAccessToken: accessTokenString! )
            
            Auth.auth().signIn(with: credentials, completion: { (user, error) in
                
                
                if error != nil{
                    
                    print(error!)
                    
                }
                
                print(user!)
                
                
                
                
                let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarViewController
                self.present(vc1, animated: true, completion: nil)
                
                
                
                FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name,location{location},picture.type(large)"]).start { (connection, result, error) -> Void in
                    
                    let response = result as AnyObject?
                    let first_name = response?.object(forKey: "first_name") as AnyObject?
                    
                    let strFirstName:String = (first_name as? String)!
                    
                    let last_name = response?.object(forKey: "last_name") as AnyObject?
                    
                    
                    
                    let strLastName:String = (last_name as? String)!
                    
                    let city = (response?.object(forKey: "location") as AnyObject?)?.object(forKey: "location") as AnyObject?
                    
                    let strCity:String = (city?.value(forKey: "city") as? String)!
                    
                    //print(strCity)
                    
                    let strPictureURL: String = (((response?.object(forKey:"picture") as AnyObject).object(forKey:"data") as AnyObject).object(forKey:"url") as? String)!
                    
                    
                    
                    //self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: strPictureURL)! as URL)! as Data)
                    
                    
                    // let barViewControllers = self.tabBarController?.viewControllers
                    //let svc = barViewControllers![3] as! ProfileViewController
                    
                    
                    self.userFB = User()
                    
                    
                    self.userFB.setFirstName(firstName: strFirstName)
                    
                    self.userFB.setLasttName(lastName:strLastName)
                    
                    self.userFB.setCity(city: strCity)
                    
                    
                    
                    self.userFB = User(firstName: strFirstName,lastName: strLastName,city: strCity,picture:strPictureURL)
                    
                    
                    
                    
                    vc1.user1 = self.userFB
                    
                    
                    
                }
                
                
                
                
                
            })
            
            /* let accessToken = FBSDKAccessToken.current()
             guard let accessTokenString = accessToken?.tokenString!
             
             
             else {
             return
             }*/
            
            
            //print("User logged in...")
            
            // let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            
            // print("User logged in firebase app")
            
            
            
        }
        
    }
    


    

    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User logged out")
        
        
        try! Auth.auth().signOut()
        
        
        FBSDKAccessToken.setCurrent(nil)
        
        
        /*usrLbl.text = ""
         
         cityLbl.text = ""
         
         imageView.image = nil*/
        
        
        
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        self.present(vc!, animated: true, completion: nil)
        
        
        
        
        
    }





    
    
    
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
        
    }






    
    
}

