//
//  Lookup.h
//  promoter
//
//  Created by Saurin Travadi on 1/12/13.
//
//

#import <Foundation/Foundation.h>

@interface Lookup : NSObject

@property (nonatomic, retain) NSString *displayDate;
@property (nonatomic, retain) NSMutableArray *tmsDesc;
@property (nonatomic, retain) NSMutableArray *tmsValue;
@property (nonatomic, retain) NSString *branchId;

-(id)initWithDate:(NSString*)date desc:(NSMutableArray*)desc val:(NSMutableArray*)val branch:(NSString *)branchId;
-(NSInteger)columnCount;

@end
