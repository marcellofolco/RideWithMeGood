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
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let tbvc = tabBarController as! TabBarViewController
        
       /* if let accessToken = FBSDKAccessToken.current() {
            
            self.userPr1 = tbvc.user1
        } else if(Auth.auth().currentUser != nil){
            
            self.userPr2 = tbvc.user2
            
            
            
        }*/
        
        self.userPr1 = tbvc.user1

    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        
        /*
        if let accessToken1 = FBSDKAccessToken.current() {
            
            self.usrLbl.text = userPr1.first_Name()+" "+userPr1.last_Name()
            
            self.cityLbl.text = userPr1.city
            
            self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: userPr1.picture)! as URL)! as Data)
            
            self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
            
            self.imageView.clipsToBounds = true;
            
        } else if Auth.auth().currentUser != nil{
            
            self.usrLbl.text = userPr2.firstName+" "+userPr2.lastName
            
            self.cityLbl.text = userPr2.email
            
            //self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string:userPr2.picture)! as URL)! as Data)
            
            
            //print(userPr2.currentUser())
            
        }*/
        
        
        
        
        self.usrLbl.text = userPr1.first_Name()+" "+userPr1.last_Name()
        
        self.cityLbl.text = userPr1.city
        
        self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: userPr1.picture)! as URL)! as Data)
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        
        self.imageView.clipsToBounds = true;
        
        
        
    }
    
    
    
    @IBAction func Logout(_ sender: Any) {
        
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logOut()
        
        
        
        
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

