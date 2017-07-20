//
//  MyCalendarViewContoller.swift
//  cateringprojectTests
//
//  Created by Amith Kumar Aellanki and Jadhav Amarnath on 6/10/16.
//  Copyright © 2016 Amith Kumar Aellanki. All rights reserved.
//
//  Authors: Amit Kumar Aellanki and Jadhav Amarnath

import UIKit
import MBCalendarKit
class MyCalendarViewController: UIViewController ,CKCalendarViewDelegate, CKCalendarViewDataSource {
	var isMaster = false
	var userName = ""
	var calendar: CKCalendarView = CKCalendarView.init()
	var timer = NSTimer()

	
    override func viewDidLoad() {
        super.viewDidLoad()
        
		self.navigationController?.navigationBarHidden = false
        
		self.navigationItem.setHidesBackButton(true, animated:true);
		
		
		self.title = "Welcome \(userName)"
		if isMaster.boolValue==true
		{
			
			navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addTapped))
			
		}
		// Do any additional setup after loading the view, typically from a nib.
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(logoutTapped))

        // Do any additional setup after loading the view.
		self.fetchAndReloadCalendar()

    }
    func reloadCalendar()
    {
        self.fetchAndReloadCalendar_1()
    }
	override func viewWillAppear(animated: Bool) {
		
		super.viewWillAppear(animated) // No need for semicolon
		self.navigationController?.navigationBarHidden = false
		 timer = NSTimer.scheduledTimerWithTimeInterval(8.0, target: self, selector: #selector(MyCalendarViewController.reloadCalendar), userInfo: nil, repeats: true)
		self.calendar.reload()
	}
	
	func fetchAndReloadCalendar()
	{
		dataManager.fetchDataFromParser { (values: [AnyObject]!) in
			//Add event dynamically
			//self.calendar = CKCalendarView.init()
			self.calendar = CKCalendarView(frame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 320))
			self.calendar.delegate = self
			self.calendar.dataSource = self
			self.view.addSubview(self.calendar)
			
			self.calendar.delegate = self
			self.calendar.dataSource = self
			
			//dataManager.deleteAllEventsFromParser{}
		}

	}
	
	func fetchAndReloadCalendar_1()
	{
		dataManager.fetchDataFromParser { (values: [AnyObject]!) in
			//Add event dynamically
			self.calendar.reload()
		}
	}

	
	override func viewWillDisappear(animated: Bool) {
		 timer.invalidate()
		super.viewWillDisappear(animated) // No need for semicolon
		self.navigationController?.navigationBarHidden = true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	func addTapped(sender: AnyObject)
	{
		let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("add") as! AddViewController
		self.navigationController?.pushViewController(secondViewController, animated: true)
	}
	
	func logoutTapped(sender: AnyObject)
	{
		GIDSignIn.sharedInstance().signOut()
		self.navigationController!.popToRootViewControllerAnimated(false)
	}
	
	@IBAction func detailTapped(sender: AnyObject)
	{
		let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! detailViewController
		
		self.navigationController?.pushViewController(secondViewController, animated: true)
	}

	
	
	func calendarView(calendarView:CKCalendarView!, eventsForDate: NSDate!) -> [AnyObject]!
	{
		let filteredArray = dataManager.getAllEventsForDate(eventsForDate)
		
		return filteredArray;
		
	}
	
	func calendarView(calendarView:CKCalendarView, didSelectDate:NSDate)
	{
		print("testing calendar delegate...")
	}
	
	func calendarView(calendarView:CKCalendarView, didSelectEvent:CKCalendarEvent)
	{
		let infoDict = didSelectEvent.info as! [String:EventDataModel]
		
		let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! detailViewController
		secondViewController.infoDictionary = infoDict
		
		self.navigationController?.pushViewController(secondViewController, animated: true)
		

	}
	
}
