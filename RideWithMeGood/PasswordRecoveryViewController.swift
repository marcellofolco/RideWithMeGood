//
//  PasswordRecoveryViewController.swift
//  
//
//  Created by Marcello Folco on 2017-07-12.
//
//

import UIKit
import Firebase

class PasswordRecoveryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var gifView: UIImageView!
    
    let rootRef = Database.database().reference()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifView.loadGif(name: "courier")
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        emailTF.inputAccessoryView = toolBar

        
        self.emailTF.delegate = self
        
    }
    
    func doneClicked() {
        view.endEditing(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func recoverButtonPressed(_ sender: Any) {
        
        let userEmail = emailTF.text
        
        Auth.auth().sendPasswordReset(withEmail: userEmail!) { error in
            if error != nil {
                self.displayMyAlertMessage(userMessage: "Email does not exist")
            } else {
                self.displayMyAlertMessage(userMessage: "Email successfully sent to \(userEmail!)")
            }
        }
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
        
    }


    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Hide TouchGesture Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
}
