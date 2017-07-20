

#import "EventDataModel.h"

@implementation EventDataModel

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.userId forKey:@"userId"];
	[coder encodeObject:self.customerName forKey:@"customerName"];
	[coder encodeObject:self.eventDescription forKey:@"eventDescription"];
	[coder encodeObject:self.dateTime forKey:@"dateTime"];
	[coder encodeObject:self.subItems forKey:@"subItems"];
	[coder encodeObject:self.isCompleted forKey:@"isCompleted"];

}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.userId = [coder decodeObjectForKey:@"userId"];
		self.customerName = [coder decodeObjectForKey:@"customerName"];
		self.eventDescription = [coder decodeObjectForKey:@"eventDescription"];
		self.dateTime = [coder decodeObjectForKey:@"dateTime"];
		self.subItems = [coder decodeObjectForKey:@"subItems"];
		self.isCompleted = [coder decodeObjectForKey:@"isCompleted"];

	}
	return self;
}

@end
