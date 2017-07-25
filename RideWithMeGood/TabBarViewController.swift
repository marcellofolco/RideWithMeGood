//
//  TabBarViewController.swift
//  RideWithMeGood
//
//  Created by User on 2017-07-20.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate{
    
    
    
    var user1:User = User()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.delegate = self
        
       // print(user1)
        
        
      // Do any additional setup after loading the view.
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        
        
    }
    
    
    
    
  /*  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
        
        
        //let barViewControllers = self.tabBarController?.viewControllers
        //let svc = barViewControllers![3] as! ProfileViewController
        
        //let vc2 = storyboard?.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
        
        
        //usrLbl.text = user1.first_Name()
        
        
       //let tabOne = ProfileViewController()
        
       //tabOne.userPr = self.user1
        
        
        //tabOne.usrLbl.text = tabOne.userPr.first_Name()

        let vc = self.tabBarController?.viewControllers?[3] as? ProfileViewController
        
        //vc?.delegate = self
        
        vc?.userPr = self.user1
        
        vc?.usrLbl.text = vc?.userPr.firstName
        
        
        
        
    }*/
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
