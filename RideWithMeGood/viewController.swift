//
//  ViewController.swift
//  RideWithMeGood
//
//  Created by Marcello Folco on 2017-07-11.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class viewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var gifView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        gifView.loadGif(name: "courier")
        
        self.userNameTF.delegate = self
        self.passwordTF.delegate = self
        
    }
    
    func textFieldShouldReturn(_ userNameTF: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Hide Keyboard Gesture
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

