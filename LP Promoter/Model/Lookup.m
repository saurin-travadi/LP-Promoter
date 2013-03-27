//
//  Lookup.m
//  promoter
//
//  Created by Saurin Travadi on 1/12/13.
//
//

#import "Lookup.h"

@implementation Lookup


@synthesize displayDate=_displayDate;
@synthesize tmsDesc=_tmsDesc;
@synthesize tmsValue=_tmsValue;
@synthesize branchId=_branchId;

-(id)initWithDate:(NSString*)date desc:(NSMutableArray*)desc val:(NSMutableArray*)val branch:(NSString *)branchId {
    
    self = [super init];
    if (self) {
        
        _displayDate=date;
        _tmsDesc=desc;
        _tmsValue=val;
        _branchId=branchId;
        
        return self;
    }
    return nil;
    
}

-(NSInteger)columnCount {

    NSInteger cnt = 6;
    if ([[self.tmsDesc objectAtIndex:5] isEqualToString:@""]) {
        cnt=5;
    }
    if ([[self.tmsDesc objectAtIndex:4] isEqualToString:@""]) {
        cnt=4;
    }
    if ([[self.tmsDesc objectAtIndex:3] isEqualToString:@""]) {
        cnt=3;
    }
    if ([[self.tmsDesc objectAtIndex:2] isEqualToString:@""]) {
        cnt=2;
    }
    if ([[self.tmsDesc objectAtIndex:1] isEqualToString:@""]) {
        cnt=1;
    }

    return cnt;
}

@end
