//
//  Leads.m
//  promoter
//
//  Created by Saurin Travadi on 1/13/13.
//
//

#import "Leads.h"

@implementation Leads

@synthesize leadId=_leadId;
@synthesize address =_address;
@synthesize apptDate=_apptDate;
@synthesize lastName =_lastName;
@synthesize phone=_phone;
@synthesize product=_product;

-(id)initWithId:(NSString*)leadId address:(NSString *)address appDate:(NSString*)appdate lastName:(NSString*)lastName phone:(NSString *)phone product:(NSString*)product {
    
    self = [super init];
    if (self) {
        
        _leadId=leadId;
        _address=address;
        _apptDate=appdate;
        _lastName=lastName;
        _phone=phone;
        _product=product;
        
        return self;
    }
    return nil;
    
}

@end
