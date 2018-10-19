//
//  GenderViewController.swift
//  Seven
//
//  Created by Ruhsane Sawut on 10/19/18.
//  Copyright © 2018 Ruhsane Sawut. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GenderViewController: UIViewController {

    @IBOutlet weak var femaleOption: UIButton!
    @IBOutlet weak var maleOption: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedFemale(_:)))
        tapGesture.numberOfTapsRequired = 1
        femaleOption.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMale(_:)))
        tap.numberOfTapsRequired = 1
        maleOption.addGestureRecognizer(tap)

    }
    
    @objc func tappedFemale(_ sender: UIGestureRecognizer){
        print("gender female")
        let uid = Auth.auth().currentUser?.uid
        let databaseRef = Database.database().reference().child("Users").child(uid!).child("Gender")
        databaseRef.setValue("female")
        self.performSegue(withIdentifier: "toSexuality", sender: self)

    }
    
    @objc func tappedMale(_ sender: UIGestureRecognizer){
        print("gender male")
        let uid = Auth.auth().currentUser?.uid
        let databaseRef = Database.database().reference().child("Users").child(uid!).child("Gender")
        databaseRef.setValue("male")
        self.performSegue(withIdentifier: "toSexuality", sender: self)

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
