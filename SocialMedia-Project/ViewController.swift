//
//  ViewController.swift
//  SocialMedia-Project
//
//  Created by Eric Pinedo on 7/19/16.
//  Copyright © 2016 Eric PInedo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //If the user is already logged in take them straight to the next screen
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func attemptLogin(sender: UIButton!) {
        
        //Make sure there is an email and a password
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
           // DataService.ds.REF_BASE.authUser(email, password: pwd) { error, authData in
            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (user, error) in
        
                if error != nil {
                    print(error)
                    
                    if error!.code == STATUS_ACCOUNT_NONEXIST {
        
                        FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (user, error) in

                                                            if error != nil {
                                                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                                                            } else {
                                                                let uid = user!.uid as? String
                                                                NSUserDefaults.standardUserDefaults().setValue(uid, forKey: KEY_UID)
                                                                
                                                                    //Store what type of account this is
                                                                    let userData = ["provider": "email"]
                                                                    DataService.ds.createFirebaseUser(user!.uid, user: userData)
                                                                    
//                                                                })
                                                                self.performSegueWithIdentifier("loggedIn", sender: nil)
                                                            }
                        })
                    } else {
                        self.showErrorAlert("Error loggin in", msg: "Could not log in. Check your username and password")
                    }
                    
                } else {
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                }
            })
        } else {
            showErrorAlert("Email & Password Required", msg: "You must enter an email address and a password")
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                

                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                
                    FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in


                
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged In! \(user)")
                        
                        //Store what type of account this is
                        let userData = ["provider": credential.provider]
                        DataService.ds.createFirebaseUser(user!.uid, user: userData)
                        
                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                    }
                })
            }
        }
    }
    
    
}

