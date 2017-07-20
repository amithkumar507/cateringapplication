

#import <Foundation/Foundation.h>

@interface EventDataModel : NSObject

@property(nonatomic, strong) NSString *userId;
@property(nonatomic, strong) NSString *customerName;
@property(nonatomic, strong) NSString *eventDescription;
@property(nonatomic, strong) NSString *dateTime;
@property(nonatomic, strong) NSArray *subItems;
@property(nonatomic, strong) NSNumber *isCompleted;

@end
