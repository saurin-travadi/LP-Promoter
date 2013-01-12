//
//  DataList.m
//  promoter
//
//  Created by Saurin Travadi on 1/11/13.
//
//

#import "DataList.h"

@implementation DataList

@synthesize key=_key;
@synthesize value=_value;

-(id)initWithKey:(NSString *)key value:(NSString *)value
{
    self = [super init];
    if (self) {
        
        _key=key;
        _value=value;
        
        return self;
    }
    return nil;
}

@end
