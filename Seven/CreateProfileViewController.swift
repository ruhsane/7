//
//  createProfile.swift
//  Seven
//
//  Created by Ruhsane Sawut on 10/17/18.
//  Copyright © 2018 Ruhsane Sawut. All rights reserved.
//

import Foundation
import UIKit

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGesture)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    
    @objc func openImagePicker(_ sender: Any){
        //OPEN IMAGE PICKER
        print("tapped")
        self.present(imagePicker, animated: true, completion: nil)
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
