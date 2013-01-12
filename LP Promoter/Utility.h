//
//  Utility.h
//  sales and tracking
//
//  Created by Sejal Pandya on 9/5/12.
//
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+(NSString*)retrieveFromUserDefaults:(NSString*)key;
-(NSString*)retrieveFromUserSavedData:(NSString*)key;
-(void)saveToUserSavedDataWithKey:(NSString*)key Data:(NSString*)object;

-(void)setUserSettings:(NSInteger)keyValue keyName:(NSString *)keyName;
-(NSInteger)getUserSettings:(NSString *)keyName;

@end
