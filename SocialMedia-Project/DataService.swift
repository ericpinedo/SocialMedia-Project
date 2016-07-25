//
//  DataService.swift
//  SocialMedia-Project
//
//  Created by Eric Pinedo on 7/20/16.
//  Copyright © 2016 Eric PInedo. All rights reserved.
//
import Foundation
import Firebase
import FirebaseStorage

let URL_BASE = FIRDatabase.database().reference()
let URL_STORAGE = FIRStorage.storage().reference()


class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = URL_BASE
    private var _REF_POSTS = URL_BASE.child("posts")
    private var _REF_USERS = URL_BASE.child("users")
    private var _REF_IMAGES = URL_STORAGE.child("images")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    var REF_IMAGES: FIRStorageReference {
        return _REF_IMAGES
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference{
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = URL_BASE.child("users").child(uid)
        return user
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(user)
    }
}