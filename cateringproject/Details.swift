//
//  Details.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit

class Details: UITableViewController {
	
	// MARK: Properties
	
	// MARK: Variables
	var items: [String] = []
	let cellIdentifier = "CustomTableCell1"
	let defaults = NSUserDefaults.standardUserDefaults()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let add = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(addTapped))
		navigationItem.rightBarButtonItems = [add]
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true);
		
		
		// Save data to file

		do {
		if let path = NSBundle.mainBundle().pathForResource("DataFile", ofType: "json")
		{
			if let jsonData = NSData(contentsOfFile: path)
			{
				if let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSArray
				{
					print(jsonResult)
					items = jsonResult as! [String];
				}
			}
		}
		}catch let error as NSError {
			print(error.localizedDescription)
		}

        //items = ["Data 4", "Data 5", "Data 6" , "Data 7", "Data 8" , "Data 9", "Data 10" ]
		//TODO
	}
	
	func itemSelected() -> Bool
	{
		return true;
	}
	
	func addTapped() -> Void
	{
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//TableViewMethods
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count;
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyCell
		
		cell.lblText.text = self.items[indexPath.row]
		cell.selectedItem = indexPath.row;
		cell.checkArrayElement(indexPath.row)
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print("You selected cell #\(indexPath.row)!")
	}
}
