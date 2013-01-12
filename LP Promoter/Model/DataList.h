//
//  DataList.h
//  promoter
//
//  Created by Saurin Travadi on 1/11/13.
//
//

#import <Foundation/Foundation.h>

@interface DataList : NSObject

@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *value;

-(id)initWithKey:(NSString *)key value:(NSString *)value;

@end
