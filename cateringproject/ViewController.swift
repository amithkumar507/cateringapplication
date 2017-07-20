//
//  ViewController.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit

class ViewController: UIViewController, GIDSignInDelegate ,GIDSignInUIDelegate {

    @IBAction func signoutpress(sender: AnyObject) {
        
        GIDSignIn.sharedInstance().signOut()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            
            print("error \(error)")
            // Perform any operations on signed in user here.
          //  let userId = user.userID                  // For client-side use only!
           // let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
           // let givenName = user.profile.givenName
			//let familyName = user.profile.familyName
           // let email = user.profile.email            // ...
			let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("dashboard") as! MyCalendarViewController
			secondViewController.isMaster=false
			
			secondViewController.userName = fullName//NSString(string: dic2["userName"] as! String) as String
			self.navigationController?.pushViewController(secondViewController, animated: true)
			
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
	@IBAction func signinAdmin(sender: AnyObject)
	{
		let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("signup") as! signupAdminViewController
		//			secondViewController.isMaster=true
		//			secondViewController.userName = NSString(string: dic2["userName"] as! String) as String
		self.navigationController?.pushViewController(secondViewController, animated: true)
	}
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
     
 
}

