//
//  SignUpViewController.swift
//  RideWithMeGood
//
//  Created by Marcello Folco on 2017-07-11.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gifView: UIImageView!
    
    let picker = UIImagePickerController()
    var userStorage: StorageReference!
    var ref: DatabaseReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        self.imageView.clipsToBounds = true;
        self.imageView.layer.borderWidth = 5.5;
        self.imageView.layer.borderColor = UIColor.white.cgColor
        
        gifView.loadGif(name: "courier")
        
        picker.delegate = self
        
        let storage = Storage.storage().reference(forURL: "gs://ridewithmegood.appspot.com")
        
        ref = Database.database().reference()
        userStorage = storage.child("users")

    }

    
    @IBAction func changeProfilePicPressed(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary

        present(picker, animated: true, completion: nil)
    }
//        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
//            self.showPicker(sourceType: .camera)
//        }))
//        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
//            self.showPicker(sourceType: .photoLibrary)
//        }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//        
//    }
    
//    func showPicker(sourceType:UIImagePickerControllerSourceType){
//        let picker = UIImagePickerController()
//        //picker.delegate = self
//        picker.sourceType = sourceType
//        present(picker, animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        
        guard firstNameTF.text != "", lastNameTF.text != "", passwordTF.text != "", emailTF.text != "", confirmPasswordTF.text != "" else {
            
            displayMyAlertMessage(userMessage: "All fields are required")
            
            return
        }
        
        if(passwordTF.text == confirmPasswordTF.text){
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let user = user {
                    
                    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                    changeRequest.displayName = self.firstNameTF.text! + self.lastNameTF.text!
                    changeRequest.commitChanges(completion: nil)
                    
                    let imageRef = self.userStorage.child("\(user.uid).jpg")
                    
                    let data = UIImageJPEGRepresentation(self.imageView.image!, 0.5)
                    
                    let uploadTask = imageRef.putData(data!, metadata: nil, completion: { (metadata, err) in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        
                        imageRef.downloadURL(completion: { (url, er) in
                            if er != nil{
                                print(er!.localizedDescription)
                            }
                            
                            if let url = url {
                                
                                let userInfo: [String : Any] = ["uid" : user.uid,
                                                                "full name" : self.firstNameTF.text! + " " + self.lastNameTF.text!,
                                                                "urlToImage" : url.absoluteString]
                                
                                self.ref.child("users").child(user.uid).setValue(userInfo)
                                
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapVC")
                                
                                self.present(vc, animated: true, completion: nil)
                                
                            }
                        
                        })
                    
                    })
                    
                    uploadTask.resume()
                    
                }
                
            })
            
            
            
        } else {
            displayMyAlertMessage(userMessage: "Passwords do not match")
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


}
