//
//  MyCell.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit

class MyCell: UITableViewCell {
	
	// MARK: Properties
	//var listItem: [String] = mainInstance.items
	var selectedItem: Int!
	var indexOfElement: Int!
	
	@IBOutlet var btnCheck: UIButton!

	@IBOutlet var lblText: UILabel!
	
	@IBAction func checkAction(sender: AnyObject)
	{
		if self.btnCheck.currentImage!.isEqual(UIImage(named: "uncheck"))
		{
			self.btnCheck .setImage(UIImage(named: "check"), forState: .Normal)
			mainInstance.items .append(lblText.text!)
		}
		else if self.btnCheck.currentImage!.isEqual(UIImage(named: "check"))
		{
			self.btnCheck .setImage(UIImage(named: "uncheck"), forState: .Normal)
			indexOfElement = mainInstance.items.indexOf(lblText.text!)
			mainInstance.items.removeAtIndex(indexOfElement);
		}
	}
	
	func checkArrayElement(index: Int) -> Void
	{
		for item in mainInstance.items
		{
			if item == lblText.text
			{
				self.btnCheck .setImage(UIImage(named: "check"), forState: .Normal)
			}
		}
	}
	
}
