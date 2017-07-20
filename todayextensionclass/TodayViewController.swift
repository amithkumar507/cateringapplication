//
//  TodayViewController.swift
//  todayextensionclass
//
//  Created by Amith Kumar Aellanki on 6/17/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var Todayslbl: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
		var name = "";
		let defaults = NSUserDefaults(suiteName: "group.todayextensionclass")
		
		//  let defaults = NSUserDefaults.standardUserDefaults();
		if (defaults!.objectForKey("extensiondata") != nil)
		{
			name = defaults!.objectForKey("extensiondata") as! String
		}
		
		
		
		Todayslbl.text = name

		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: #selector(userDefaultsDidChange),
			name: NSUserDefaultsDidChangeNotification,
			object: nil)
		
		
          //NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.todayextensionclass"];
		
        /// today event show karna hai
        
        // Do any additional setup after loading the view from its nib.
    }
	
	@objc func userDefaultsDidChange(notification: NSNotification){
	
	
	var name = "";
	let defaults = NSUserDefaults(suiteName: "group.todayextensionclass")
	
	//  let defaults = NSUserDefaults.standardUserDefaults();
	if (defaults!.objectForKey("extensiondata") != nil)
	{
	name = defaults!.objectForKey("extensiondata") as! String
	}
	
	
	
	Todayslbl.text = name

	
	}
	
	// check updatedDate and update widget UI

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
