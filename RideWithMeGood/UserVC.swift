//
//  UserVC.swift
//  RideWithMeGood
//
//  Created by Martin Nadeau on 2017-07-17.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

struct  StretchyHeader {
    let headerHeight: CGFloat = 355
    let headerCut: CGFloat = 50
}

class UserVC: UIViewController {
    
    let storageREF = FIRStorage.storage().reference()
    let databaseRef = FIRData.database().reference()
    
    @IBOutlet weak var userUII: UIImageView!
    @IBOutlet weak var userNameL: UILabel!
    
    var headerView: UIView
    var newHeaderLayer: CAShapeLayer!
    
    var databaseRef: FIRDatabaseReference!
        return FIRDatabase.database().reference()
    }

    var storageRef: FIRStorage {
    
        return FIRStorage.storage
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userUII.layer.cornerRadius = 65
        updateView()
        
       
    }



    override func viewWillAppear(_ animated:Bool) {
    super.viewWillAppear(true)
    loadUserInfo()
        
    }

    func loadUserInfo() {
    
        
        let  userRef = DatabaseRef.friends("users"/\(FIRAuth.auth()!.currentUser!.uid)")
             userRef.observe(.value, with: { (snapShot) in
            
                let user = User(snapshot: snapShot)
                self.userNameL.text = user.username
                
                let imageURL = user.photoURL!
                
                self.storageRef.reference(forURL: imageURL).data(withMaxSize: 1 * 1024 * 1024, completion: { (imgData,
                     error) in
                    
                    if error == nil {
                        
                        if let data = imgData {
                            self.userUII.image = UIImage(data: data)
                        }
                    
                    }else {
                        
                    }
                        
                        
                })
                
                }){ (error) in
                    print(error.localizedDescription)
        }
        
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
