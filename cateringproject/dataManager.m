

#import "dataManager.h"
#import "EventDataModel.h"
#import "CKCalendarEvent.h"

@interface dataManager()
{
}

@end

static 	PFObject *fetchedObject;


@implementation dataManager

+ (void)storeDatainUserDefaults:(NSString *)userId customerName:(NSString *)customerName eventDescription:(NSString *)eventDescription dateTime:(NSString *)dateTime subItems:(NSArray *)subItems isCompleted:(BOOL)isCompleted
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	EventDataModel *eventModel = [EventDataModel new];
	eventModel.userId = userId;
	eventModel.customerName = customerName;
	eventModel.eventDescription = eventDescription;
	eventModel.dateTime = dateTime;
	eventModel.subItems = subItems;
	eventModel.isCompleted = [NSNumber numberWithBool:isCompleted];

	NSMutableArray *eventsArray = [NSMutableArray array];
	
	NSData *data = [defaults objectForKey:@"UserDefaultsEvents"];
	NSArray *prevEvents = [NSKeyedUnarchiver unarchiveObjectWithData:data];

	if(prevEvents)
	{
		[eventsArray addObjectsFromArray:prevEvents];
	}
	
	[eventsArray addObject:eventModel];
	
	[defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:eventsArray] forKey:@"UserDefaultsEvents"];
	[defaults synchronize];
	[dataManager storeDataInPaser:eventsArray callback:^(NSArray *obj) {
		
	}];
}


+ (void)getDatainUserDefaults:(void (^)(NSArray *obj))block
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	NSData *data = [defaults objectForKey:@"UserDefaultsEvents"];
	NSArray *prevEvents = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
//	[dataManager fetchDataFromParser:^(NSArray *obj) {
//		
//	}];
	
	//return prevEvents1;
	//return prevEvents;
}

+ (NSArray *)getDataFromUserDefaults
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSData *data = [defaults objectForKey:@"UserDefaultsEvents"];
	NSArray *prevEvents = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	//return prevEvents1;
	return prevEvents;
}


//+ (void)getAllEventsForDate:(NSDate*) date callback:(void (^)(NSArray *obj))block
+ (NSArray *)getAllEventsForDate:(NSDate*) date
{
	NSArray *allEvents = [dataManager getDataFromUserDefaults];
	
	NSMutableArray *filteredEventsForDate = [NSMutableArray new];

	[allEvents filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EventDataModel  * _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
		
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		dateFormatter.dateFormat = @"MM-dd-yyyy";
		NSDate *dateValue = [dateFormatter dateFromString:evaluatedObject.dateTime];
		//yaper ns date current date ka chek laga do
        
		if([dateValue isEqual:date])
		{
			NSDictionary *infoDict = [NSDictionary dictionaryWithObject:evaluatedObject forKey:@"infoDictionary"];
			
            NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.todayextensionclass"];

//            NSArray *extensionsArray = [sharedDefaults objectForKey:@"extensiondata"] ?: @[];
			
            NSDate * nowdate = [NSDate date];
            [dateFormatter setDateFormat:@"MMM dd, yyyy"];
            NSString *datestring = [dateFormatter stringFromDate:nowdate];
            if([[dateFormatter stringFromDate:dateValue] isEqual:datestring])
            {
                

                NSDictionary * objectDict = @{@"name": evaluatedObject.customerName ?: @"", @"date":evaluatedObject.dateTime ?: @""};
				if(objectDict.count)
				{
					[sharedDefaults setObject:evaluatedObject.customerName forKey:@"extensiondata"];
				}
				else
				{
					[sharedDefaults setObject:@"No Event" forKey:@"extensiondata"];
				}
			
			
//                if (![extensionsArray containsObject:objectDict]) {
//                    NSMutableArray *newarray = [[NSMutableArray alloc] initWithArray:extensionsArray];
//                    [newarray addObject:objectDict];
//                    extensionsArray = [NSArray arrayWithArray:newarray];
//                }
//            }
//            
//            if (extensionsArray && [extensionsArray isKindOfClass:[NSArray class]]) {
//                [sharedDefaults setObject:extensionsArray forKey:@"extensiondata"];
            }
            
            [sharedDefaults synchronize];

			UIColor *eventColor = [UIColor greenColor];
			if(!evaluatedObject.isCompleted.boolValue)
			{
				eventColor = [UIColor redColor];
			}
			
			CKCalendarEvent *calendarEvent = [CKCalendarEvent eventWithTitle:evaluatedObject.customerName andDate:dateValue andInfo:infoDict andColor:eventColor];
			[filteredEventsForDate addObject:calendarEvent];

			return YES;
		}
		
		return NO;

	}]];
	
	return filteredEventsForDate;
	
}

//+ (void)updateValueForEventInfo:(NSDictionary *)eventDict
+ (void)updateValueForEventInfo:(NSDictionary *)eventDict callback:(void (^)(NSArray *obj))block
{
	EventDataModel *event = [eventDict objectForKey:@"infoDictionary"];
	event.isCompleted = [NSNumber numberWithBool:YES];
	
	NSMutableArray *allEvents = [NSMutableArray arrayWithArray:[dataManager getDataFromUserDefaults]];
	NSMutableArray *updatedEvents = [NSMutableArray array];
	
	
	[allEvents enumerateObjectsUsingBlock:^(EventDataModel  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		if([obj.userId isEqualToString:event.userId])
		{
			obj.isCompleted = [NSNumber numberWithBool:YES];
			//*stop = YES;
		}
		[updatedEvents addObject:obj];
	}];

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:updatedEvents] forKey:@"UserDefaultsEvents"];
	[defaults synchronize];
	
	[dataManager storeDataInPaser:updatedEvents callback:^(NSArray *obj) {
		block(nil);
	}];
}

+ (void)removeValueForEventInfo:(NSDictionary *)eventDict callback:(void (^)())block
{
	EventDataModel *event = [eventDict objectForKey:@"infoDictionary"];
	event.isCompleted = [NSNumber numberWithBool:YES];
	
	NSMutableArray *allEvents = [NSMutableArray arrayWithArray:[dataManager getDataFromUserDefaults]];
	NSMutableArray *updatedEvents = [NSMutableArray array];
	
	[allEvents enumerateObjectsUsingBlock:^(EventDataModel  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		if(![obj.userId isEqualToString:event.userId])
		{
			[updatedEvents addObject:obj];
		}
	}];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:updatedEvents] forKey:@"UserDefaultsEvents"];
	[defaults synchronize];
	
	[dataManager storeDataInPaser:updatedEvents callback:^(NSArray *obj) {
		block();
	}];

}

+ (void) loginToParser
{
	[PFUser logInWithUsernameInBackground:@"test000000" password:@"000000" block:^(PFUser *user, NSError *error) {
		if (user) {
			
			NSLog(@"%@", user);
			
		} else {
			//Something bad has ocurred
			NSString *errorString = [[error userInfo] objectForKey:@"error"];
			UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[errorAlertView show];
		}
	}];
	
}

//+ (void)storeDataInPaser:(NSArray *)dataArray
+ (void)storeDataInPaser:(NSArray *)dataArray callback:(void (^)(NSArray *obj))block
{
	[dataManager deleteAllEventsFromParser:^{
		
		if(dataArray.count)
		{
			PFObject *imageObject = [PFObject objectWithClassName:@"EventClass"];
			[imageObject setObject:[NSKeyedArchiver archivedDataWithRootObject:dataArray] forKey:@"event"];
			
			[imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
				
				fetchedObject = imageObject;
				
				
				
				
				if (succeeded){
					
				}
				else{
					NSString *errorString = [[error userInfo] objectForKey:@"error"];
					NSLog(@"%@", errorString);
				}
				
				block(nil);
				
			}];

		}
		else
		{
			block(nil);
		}

	}];
	
	
}

+(void)fetchDataFromParser:(void (^)(NSArray *obj))block
{
	__block NSArray *fetchedEvents = nil;
	
	PFQuery *query = [PFQuery queryWithClassName:@"EventClass"];
	//	[query orderByDescending:@"name"];
	
	//dispatch_sync(dispatch_get_main_queue(), ^{
		
		[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			
//			[self deleteAllEventFromParser:objects];
			
			if (!error) {
				
				fetchedObject = [objects firstObject];
				
				NSLog(@"%@", objects);
				fetchedEvents = [NSKeyedUnarchiver unarchiveObjectWithData:[[objects valueForKey:@"event"] firstObject]];
				
				[[NSUserDefaults standardUserDefaults] setValue:[NSKeyedArchiver archivedDataWithRootObject:fetchedEvents] forKey:@"UserDefaultsEvents"];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				block(fetchedEvents);
				
				
			} else {
				NSString *errorString = [[error userInfo] objectForKey:@"error"];
				NSLog(@"%@", errorString);
				block(nil);

			}
		}];

}

+ (void)deleteAllEventFromParser:(NSArray*)objects
{
	[objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		[obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
			
		}];
		
	}];
	
}

+ (void)deleteEventFromParser:(PFObject*)object
{
	[object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
		
	}];
}

+ (void)deleteAllEventsFromParser:(void (^)())block
{
	if(fetchedObject)
	{
		[fetchedObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
			
			fetchedObject = nil;
			block();
		}];
	}
	else
	{
		block();
	}
}


@end
