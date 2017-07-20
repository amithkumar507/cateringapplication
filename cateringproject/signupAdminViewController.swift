//
//  signupAdminViewController.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit


class signupAdminViewController: UIViewController {
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = false
		
		let defaults = NSUserDefaults.standardUserDefaults()
		
        let dict1: [String:String] = [
            "userName" : "john",
            "password" : "123456",
            "userType" : "Master"
        ]
//		let dict1: Array = [[ "userName" : "charli", "password" : "123456", "userType" : "Normal"], [ "userName" : "john", "password" : "123456", "userType" : "Master"], [ "userName" : "johny", "password" : "123456", "userType" : "Normal"],[ "userName" : "katie", "password" : "123456", "userType" : "Master"],[ "userName" : "jenny", "password" : "123456", "userType" : "Normal"],[ "userName" : "amar", "password" : "123456", "userType" : "Master"],[ "userName" : "amit", "password" : "123456", "userType" : "Master"]];
		defaults.setObject(dict1, forKey: "SavedDict")
		defaults.synchronize()
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	@IBAction func login(sender: AnyObject)
 {
	let username = self.loginTextField.text
	let password = self.passwordTextField.text
    let demoType =  "Master"
	var Error = true
    	let defaults = NSUserDefaults.standardUserDefaults()
//	
    let dict12 = defaults.valueForKey("SavedDict") as! [String:String]
    
    //print (dict12)
//	for  dic2  in dict12
//	{
		if demoType.isEqual(dict12["userType"] ) && username!.isEqual(dict12["userName"] ) &&  password!.isEqual(dict12["password"] )
		{
			print("Master")
			let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("dashboard") as! MyCalendarViewController
			secondViewController.isMaster=true
			secondViewController.userName = username!//NSString(string: dic2["userName"] as! String) as String
			self.navigationController?.pushViewController(secondViewController, animated: true)
			
			
			//(secondViewController, animated: true)/		
            Error = false
            //break;
		}
////		else if username! .isEqual (dic2["userName"]) && password! .isEqual (dic2["password"])
////		{
////			
////			print("Normal")
////			let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("dashboard") as! MyCalendarViewController
////			self.navigationController?.pushViewController(secondViewController, animated: true)
////			
////
////			
////			Error = false
////			break;
////		}
////	}
////	
	if Error
	{
		let alert = UIAlertController(title: "Error", message: "Username and Password is Incorrect", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	}
	
}
