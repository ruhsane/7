//
//  createProfile.swift
//  Seven
//
//  Created by Ruhsane Sawut on 10/17/18.
//  Copyright © 2018 Ruhsane Sawut. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.addTarget(self, action: #selector(handleProfileData), for: .touchUpInside)

        //dismiss keyboard when tapped outside of the textfield
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        //open image picker when clicked
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker(_:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageTap)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    func errorMessage(){
        // create the alert
        let alert = UIAlertController(title: "Please Complete Filling Out The Profile", message: "Please Complete Filling Out The Profile", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleProfileData(){
        guard let name = nameTextField.text else{return errorMessage()}
        guard let age = ageTextField.text else{return errorMessage()}
        guard let description = descriptionTextField.text else{return errorMessage()}
        guard let image = profileImage.image else{return errorMessage()}
        
        //store the profile image to firebase storage
//        self.uploadProfileImage(image, url)
        
        self.uploadProfileImage(image) { url in
            
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User picture changed!")
                        
                        self.saveProfile(name:name, age:age, description:description, profileImageURL: url!) { success in
                            if success {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
            } else {
                // Error unable to upload profile image
            }
            
        }
        
    }
    
    func saveProfile(name:String, age:String, description:String, profileImageURL: URL, completion: @escaping ((_ success:Bool)->())){
        //store the name, age and description to databse

        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("Users").child(uid)
        
        let userObject = [
            "Name": name,
            "Age": age,
            "Description": description,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.updateChildValues(userObject) { error, ref in
            completion(error == nil)
        
        }
    }
    
    @objc func openImagePicker(_ sender: Any){
        //OPEN IMAGE PICKER
        print("tapped")
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()

    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let storageRef = Storage.storage().reference().child("Users").child(uid)
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL(completion: { (url, error) in
                    print(url)
                    if error != nil {
                        //failed
                        completion(nil)
                    } else {
                        //success
                        completion(url?.absoluteURL)
                    }
                })
            }
        }
    }
    
}

extension CreateProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil )
    }
    
    
    
}
