//
//  ViewController.swift
//  Seven
//
//  Created by Ruhsane Sawut on 10/15/18.
//  Copyright © 2018 Ruhsane Sawut. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGoogleButtons()
    }
    
    
    fileprivate func setupGoogleButtons(){
        // add google sign in button
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        // automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print("Failed to login to Google")
            
            return
        }
        
        print("successfully logged into Google", user)
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("Problem at signing in with google with error : \(error)")
                return
            }
            // User is signed in
            // ...
            print("user successfully signed in through GOOGLE! uid:\(Auth.auth().currentUser!.uid)")
            print("signed in")
            self.performSegue(withIdentifier: "createProfile", sender: nil)
        }
        
    }
    
    
    
}

