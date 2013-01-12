//
//  Settings.h
//  promoter
//
//  Created by Saurin Travadi on 1/11/13.
//
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (nonatomic, retain) NSString *altData1;
@property (nonatomic, retain) NSString *altData2;
@property (nonatomic, retain) NSString *canViewHistory;
@property (nonatomic, retain) NSString *hshBranch;
@property (nonatomic, retain) NSString *hshProduct;
@property (nonatomic, retain) NSString *hshPromoter;
@property (nonatomic, retain) NSString *hshSource;
@property (nonatomic, retain) NSString *promoterDropdownVisible;

-(id)initWithAltData1:(NSString *)altData1 altData2:(NSString *)altData2 canViewHistory:(NSString *)canViewHistory hshBranch:(NSString *)hshBranch
           hshProduct:(NSString *)hshProduct hshPromoter:(NSString *)hshPromoter hshSource:(NSString *)hshSource promoterDropdown:(NSString *)promoterDropDown;


@end
