//
//  Leads.h
//  promoter
//
//  Created by Saurin Travadi on 1/13/13.
//
//

#import <Foundation/Foundation.h>

@interface Leads : NSObject

@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *apptDate;
@property (nonatomic, retain) NSString *leadId;

-(id)initWithId:(NSString*)leadId address:(NSString *)address appDate:(NSString*)appdate lastName:(NSString*)lastName phone:(NSString *)phone product:(NSString*)product;

    
@end
