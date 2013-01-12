//
//  Settings.m
//  promoter
//
//  Created by Saurin Travadi on 1/11/13.
//
//

#import "Settings.h"

@implementation Settings

@synthesize altData1=_altData1;
@synthesize altData2=_altData2;
@synthesize canViewHistory=_canViewHistory;
@synthesize hshBranch=_hshBranch;
@synthesize hshProduct=_hshProduct;
@synthesize hshPromoter=_hshPromoter;
@synthesize hshSource=_hshSource;
@synthesize promoterDropdownVisible=_promoterDropdownVisible;

-(id)initWithAltData1:(NSString *)altData1 altData2:(NSString *)altData2 canViewHistory:(NSString *)canViewHistory hshBranch:(NSString *)hshBranch
hshProduct:(NSString *)hshProduct hshPromoter:(NSString *)hshPromoter hshSource:(NSString *)hshSource promoterDropdown:(NSString *)promoterDropDown
{
    self = [super init];
    if (self) {
        
        _altData1=altData1;
        _altData2=altData2;
        _canViewHistory = canViewHistory;
        _hshBranch=hshBranch;
        _hshProduct=hshProduct;
        _hshPromoter=hshPromoter;
        _hshSource=hshSource;
        _promoterDropdownVisible=promoterDropDown;
        
        
        return self;
    }
    return nil;
}

@end
