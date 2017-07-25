//
//  ProfileViewController.swift
//  RideWithMeGood
//
//  Created by User on 2017-07-18.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import FBSDKLoginKit

import Firebase
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    
    
    
    
    var userPr:User = User()
    
    
    
    @IBOutlet weak var usrLbl: UILabel!
   
    
    @IBOutlet weak var cityLbl: UILabel!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
  
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        let tbvc = tabBarController as! TabBarViewController
        
        self.userPr = tbvc.user1
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        

        self.usrLbl.text = userPr.first_Name()+" "+userPr.last_Name()
        
        self.cityLbl.text = userPr.city
        
        self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: userPr.picture)! as URL)! as Data)
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        
        self.imageView.clipsToBounds = true;
        
        
        
        
    }
    
    
    @IBAction func logoutFromFacebook(_ sender: Any) {
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logOut()
        
        //loginManager.loginBehavior = FBSDKLoginBehavior.web
        
        
        //var cookie: HTTPCookie?
        //var storage = HTTPCookieStorage.shared
        
        //storage.deleteCookie(cookie!)
        
        
        
       /* var cookie: HTTPCookie!
        var storage = HTTPCookieStorage.shared
        //var cookie = ()
        storage.cookies
        do {
            storage.deleteCookie(cookie)
        }
        UserDefaults.standard.synchronize()*/
        
        let vc2:LoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        

        
        
        self.present(vc2, animated: true, completion: nil)
        
        
        
        
        
    }
    
    /*func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        
        if error != nil{
            print(error)
        }
        else{
            print("User is SUccessfully Logged in....")
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString! else {
                return
            }
            let credentials =
                FacebookAuthProvider.credential(withAccessToken: accessTokenString )
            
            Auth.auth().signIn(with: credentials, completion: { (user, error) in
                
                
                if error != nil{
                    print(error!)
                    
                }
                print(user!)
                
                
                FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name,location{location},picture.type(large)"]).start { (connection, result, error) -> Void in
                    
                    let response = result as AnyObject?
                    let first_name = response?.object(forKey: "first_name") as AnyObject?
                    let strFirstName: String = (first_name as? String)!
                    
                    let last_name = response?.object(forKey: "last_name") as AnyObject?
                    
                    
                    
                    let strLastName: String = (last_name as? String)!
                    
                    let city = (response?.object(forKey: "location") as AnyObject?)?.object(forKey: "location") as AnyObject?
                    
                    let strCity: String = (city?.value(forKey: "city") as? String)!
                    
                    print(strCity)
                    
                    let strPictureURL: String = (((response?.object(forKey:"picture") as AnyObject).object(forKey:"data") as AnyObject).object(forKey:"url") as? String)!
                    
                    self.usrLbl.text = (strFirstName)+" "+(strLastName)
                    
                    self.cityLbl.text = strCity
                    
                    self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: strPictureURL)! as URL)! as Data)
                    
                    
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
                    
                    self.imageView.clipsToBounds = true;
                    
                    
                    
                    
                
                
                
                
                
                
                
                
                
                }
                
                
                
            })
        
        
        
            
            
        
        
    
    
        
        
        
        
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
        
        
        
        
        
    }*/
    
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

