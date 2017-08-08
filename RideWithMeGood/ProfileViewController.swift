//
//  ProfileViewController.swift
//  RideWithMeGood
//
//  Created by User on 2017-07-18.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import FBSDKLoginKit

import GoogleSignIn

import Firebase
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var usrLbl: UILabel!
    
    
    @IBOutlet weak var cityLbl: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    
    
    var userPr1:User = User()
    
    var userPr2:User = User()
    
    var userPr3:User = User()
    
    var userPr4:User = User()
    
    
    var userStorage: StorageReference!
    var ref: DatabaseReference!

    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
            let storage = Storage.storage().reference(forURL: "gs://ridewithmegood.appspot.com")
        
            ref = Database.database().reference()
            userStorage = storage.child("users")

        
        
        
        
            let tbvc = tabBarController as! TabBarViewController
        
        
        
            self.userPr1 = tbvc.user1
        
            
            self.userPr2 = tbvc.user2
        
        
            self.userPr3 = tbvc.user3
        
        
            self.userPr4 = tbvc.user4
            
            
   }
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        
        
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                switch userInfo.providerID {
                case "facebook.com":
                    
                    self.usrLbl.text = userPr1.first_Name()+" "+userPr1.last_Name()
                    
                    self.cityLbl.text = userPr1.city
                    
                     self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: userPr1.picture)! as URL)! as Data)
                    
                    
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
                    
                    self.imageView.clipsToBounds = true;
                    
                    
                    print("user is signed in with facebook")
                    
                case "password":
                    
                   
                   
                   
                   let userID : String = (Auth.auth().currentUser?.uid)!
                   
                   self.ref.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
                    
                    let url = (snapshot.value as! NSDictionary)["urlToImage"]
                    
                    let fullName = (snapshot.value as! NSDictionary)["full name"]
                    
                    
                    
                    self.usrLbl.text = fullName as! String?
                    
                    self.cityLbl.text = userInfo.email
                    
                    self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: url as! String)! as URL)! as Data)
                    
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
                    
                    self.imageView.clipsToBounds = true;
                    
                    
                    print(url)
                    
                    
                   })

                   
                    print("user is signed with password")
                    
                    
                case "google.com":
                    
                    self.usrLbl.text = userPr2.first_Name()+" "+userPr2.last_Name()
                    
                    self.cityLbl.text = userPr2.email
                    
                    if(userInfo.photoURL != nil){
                    
                  
                        let url = userInfo.photoURL
                        
                        let data = NSData(contentsOf:url!)
                        
                        if (data != nil) {
                            self.imageView.image = UIImage(data:data! as Data)
                            
                         } else{
                        
                            self.imageView.image = nil
                            
                        }
                        
                    }
                    
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
                    
                    self.imageView.clipsToBounds = true;
                    
                     print("user is signed in with google")
                    
                default:
                    
                    
                    self.usrLbl.text = self.userPr3.first_Name()+" "+self.userPr3.last_Name()
                    
                    self.cityLbl.text = self.userPr3.email
                    
                    self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: userPr3.picture)! as URL)! as Data)
                    
                    
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
                    
                    self.imageView.clipsToBounds = true;
                    
                    
                    print("user is signed in with \(userInfo.providerID)")
                    
                    
               }
            }
            
        }
            
        
   }
    
    
    
    @IBAction func Logout(_ sender: Any) {
        
        
        
        
        
        if(FBSDKAccessToken.current() != nil){
            
            
            let loginManagerFB = FBSDKLoginManager()
            
            FBSDKAccessToken.setCurrent(nil)
            
             loginManagerFB.logOut()
            
            loginManagerFB.loginBehavior = FBSDKLoginBehavior.web
          
            do{
                try Auth.auth().signOut()
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }

            
            
        }
        
        if(GIDSignIn.sharedInstance().hasAuthInKeychain()){
            
            
            let loginManagerGG = GIDSignIn.sharedInstance()
            
            loginManagerGG?.signOut()
            
        }
        
        if(Auth.auth().currentUser != nil){
            
            
            try! Auth.auth().signOut()
            
            
        }
        
        
        
        
       let vc2:LoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
        
       self.present(vc2, animated: true, completion: nil)
        
        
        
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

