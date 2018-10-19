//
//  SexualityViewController.swift
//  Seven
//
//  Created by Ruhsane Sawut on 10/19/18.
//  Copyright © 2018 Ruhsane Sawut. All rights reserved.
//

import UIKit
import Firebase

class SexualityViewController: UIViewController {


    @IBOutlet weak var likeFemale: UIButton!
    @IBOutlet weak var likeMale: UIButton!
    @IBOutlet weak var likeBoth: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedFemale(_:)))
        tapGesture.numberOfTapsRequired = 1
        likeFemale.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMale(_:)))
        tap.numberOfTapsRequired = 1
        likeMale.addGestureRecognizer(tap)
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tappedBoth(_:)))
        tap.numberOfTapsRequired = 1
        likeBoth.addGestureRecognizer(tapped)
        
    }
    
    @objc func tappedFemale(_ sender: UIGestureRecognizer){
        print("sexuality female")
        let uid = Auth.auth().currentUser?.uid
        let databaseRef = Database.database().reference().child("Users").child(uid!).child("Sexuality")
        databaseRef.setValue("female")
        self.performSegue(withIdentifier: "toBrowse", sender: self)
        
    }
    
    @objc func tappedMale(_ sender: UIGestureRecognizer){
        print("sexuality male")
        let uid = Auth.auth().currentUser?.uid
        let databaseRef = Database.database().reference().child("Users").child(uid!).child("Sexuality")
        databaseRef.setValue("male")
        self.performSegue(withIdentifier: "toBrowse", sender: self)
        
    }
    
    @objc func tappedBoth(_ sender: UIGestureRecognizer){
        print("sexuality both")
        let uid = Auth.auth().currentUser?.uid
        let databaseRef = Database.database().reference().child("Users").child(uid!).child("Sexuality")
        databaseRef.setValue("both")
        self.performSegue(withIdentifier: "toBrowse", sender: self)
//
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
