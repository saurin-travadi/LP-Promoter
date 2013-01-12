//
//  UserInfo.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consumer.h"

@interface UserInfo : Consumer

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *clientID;
@property (nonatomic, retain) NSString *siteURL;
@property (nonatomic, retain) NSString *email;

-(id)initWithUserName:(NSString *)userName Password:(NSString*)pwd ClientID:(NSString*)clientID SiteURL:(NSString*)url;


@end
