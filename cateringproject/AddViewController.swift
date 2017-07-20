//
//  AddViewController.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit

class AddViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
	@IBOutlet weak var userIDTextField: UITextField!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var addRowButton: UIButton!
	@IBOutlet weak var descTextField: UITextField!
	var data: [String] =  []
	@IBOutlet var tableView: UITableView!
	@IBOutlet weak var dateTextField: UITextField!
	var datePicker : UIDatePicker!
	var items: [String] = []
	let cellIdentifier = "Cell"
	var dice1: Int = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = false
		self.title = "Add Items";
		let someNSDate = NSDate()
		
		let myTimeStamp = someNSDate.timeIntervalSince1970
		let  time = Int(myTimeStamp);
		
		dice1 = Int(arc4random_uniform(1000)) + 33 + time
		
		self.userIDTextField.text =  String(dice1)
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(doneTapped))
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func viewWillAppear(animated: Bool) {
		
		items = mainInstance.items
		tableView .reloadData()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
		
		cell.textLabel?.text = self.items[indexPath.row]
		
		return cell
	}
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.0
	}
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print("You selected cell #\(indexPath.row)!")
	}

	
		func textFieldDidBeginEditing(textField: UITextField) {
			self.pickUpDate(self.dateTextField)
		}
		func textFieldShouldReturn(textField: UITextField) -> Bool {
		print("TextField should return method called")
		textField.resignFirstResponder();
		return true;
 }
	//MARK:- Function of datePicker
	func pickUpDate(textField : UITextField){
		
		// DatePicker
		self.datePicker = UIDatePicker(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
		self.datePicker.backgroundColor = UIColor.whiteColor()
		self.datePicker.datePickerMode = UIDatePickerMode.DateAndTime
		textField.inputView = self.datePicker
		
		// ToolBar
		let toolBar = UIToolbar()
		toolBar.barStyle = .Default
		toolBar.translucent = true
		toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
		toolBar.sizeToFit()
		
		// Adding Button ToolBar
		let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(AddViewController.doneClick))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(AddViewController.cancelClick))
		toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
		toolBar.userInteractionEnabled = true
		textField.inputAccessoryView = toolBar
		
	}
	
	// MARK:- Button Done and Cancel
	func doneClick() {
		let dateFormatter1 = NSDateFormatter()
		dateFormatter1.dateStyle = .MediumStyle
		dateFormatter1.timeStyle = .NoStyle
		dateTextField.text = dateFormatter1.stringFromDate(datePicker.date)
		dateTextField.resignFirstResponder()
	}
	func cancelClick() {
		dateTextField.resignFirstResponder()
	}
	func doneTapped(sender: AnyObject)
	{
		let userID = self.userIDTextField.text

		var userName = self.nameTextField.text
		userName = "  " + userName!
		print(userName)
		let dateandtime = self.dateTextField.text
		let desc = self.descTextField.text

		if userID == ""
		{
			let alert = UIAlertController(title: "Error", message: "UserID should not be blank", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
		else if userName == ""
		{
			let alert = UIAlertController(title: "Error", message: "Username should not be blank", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
		else if desc == ""
		{
			let alert = UIAlertController(title: "Error", message: "Description should not be blank", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
		else if dateandtime == ""
		{
			let alert = UIAlertController(title: "Error", message: "Please Select date", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
		else if items.count == 0
		{
			let alert = UIAlertController(title: "Error", message: "Please Select Items", preferredStyle: UIAlertControllerStyle.Alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
		else
		{
	
			dataManager.storeDatainUserDefaults(userID, customerName: userName, eventDescription: desc, dateTime: dateandtime, subItems: items, isCompleted: false)
		
			mainInstance.items .removeAll()
		self.navigationController!.popViewControllerAnimated(true)
		}
	}
	
}