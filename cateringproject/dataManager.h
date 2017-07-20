

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface dataManager : NSObject

+ (void)storeDatainUserDefaults:(NSString *)userId customerName:(NSString *)customerName eventDescription:(NSString *)eventDescription dateTime:(NSString *)dateTime subItems:(NSArray *)subItems isCompleted:(BOOL)isCompleted;
//+ (NSArray*)getDatainUserDefaults;
//+ (NSDictionary*)getCalendarEventsDictionary;
+ (NSArray *)getAllEventsForDate:(NSDate*) date;
//+ (void)updateValueForEventInfo:(NSDictionary *)eventDict;
//+ (void)removeValueForEventInfo:(NSDictionary *)eventDict;
+ (void)removeValueForEventInfo:(NSDictionary *)eventDict callback:(void (^)())block;

+ (void)getAllEventsForDate:(NSDate*) date callback:(void (^)(NSArray *obj))block;

+ (void) loginToParser;

//+ (void)storeDataInPaser:(NSArray *)dataArray;
//
//+(NSArray *)fetchDataFromParser;

+(void)fetchDataFromParser:(void (^)(NSArray *obj))block;
+ (void)deleteAllEventsFromParser:(void (^)())block;
+ (void)updateValueForEventInfo:(NSDictionary *)eventDict callback:(void (^)(NSArray *obj))block;
@end
