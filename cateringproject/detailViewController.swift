//
//  detailViewController.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit

class detailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
	var data: [String] =  []
	@IBOutlet var tableView: UITableView!
	
	@IBOutlet weak var deletButton: UIButton!
	@IBOutlet weak var updateButton: UIButton!
	
	var infoDictionary = [String:EventDataModel]()
	let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)

	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = false
		self.title = "Detail";
		
	    let eventValue1:EventDataModel = self.infoDictionary["infoDictionary"]!
		
		data =  ["ID:-\(eventValue1.userId)", "Name:-\(eventValue1.customerName)", "Description:-\(eventValue1.eventDescription)","Date:-\(eventValue1.dateTime)"]
		
		if let eventValue:EventDataModel = self.infoDictionary["infoDictionary"]
		{
			if eventValue.isCompleted.boolValue
			{
				self.updateButton.hidden = true
			}
		}
		
	}
	
	override func viewWillAppear(animated: Bool) {
		
		super.viewWillAppear(animated) // No need for semicolon
		
	}
	override func viewWillDisappear(animated: Bool) {
		
		super.viewWillDisappear(animated) // No need for semicolon
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	 func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 2;
	}
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		let eventValue:EventDataModel = self.infoDictionary["infoDictionary"]!
		
		if section == 0
		{
			return 4
		}
		else if section == 1
		{
			return eventValue.subItems.count
		}
		return 0
		
	}
	 func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
		if section == 0
		{
			return  nil
		}
		else if section == 1
		{
			return "Sub Items"
		}
		return nil

	}
	
	 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
		
		// Fetch Fruit
		if indexPath.section == 0
		{
		let data1 = data[indexPath.row]
		
		// Configure Cell
		cell.textLabel?.text = data1
		}
		else if indexPath.section == 1
		{
			let eventValue:EventDataModel = self.infoDictionary["infoDictionary"]!
			
			let data1 = eventValue.subItems[indexPath.row]
			
			// Configure Cell
			cell.textLabel?.text = data1 as? String
			
		}
		return cell
	}
	
	
	@IBAction func detailTapped(sender: AnyObject)
	{
		self.showActivityIndicator()

		dataManager.removeValueForEventInfo(self.infoDictionary, callback: {
			self.navigationController!.popViewControllerAnimated(true)
			self.hideActivityIndicator()
		})
	}

	@IBAction func deTapped(sender: AnyObject)
	{
		self.showActivityIndicator()
		
		dataManager.updateValueForEventInfo(self.infoDictionary, callback: { (_: [AnyObject]!) in
			self.navigationController!.popViewControllerAnimated(true)
			self.hideActivityIndicator()
		})
		
	}

	func showActivityIndicator()
	{
//		let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
		indicator.center = view.center
		view.addSubview(indicator)
		indicator.startAnimating()
	}
	
	func hideActivityIndicator()
	{
		indicator.stopAnimating()
		indicator.hidden = true
	}
}