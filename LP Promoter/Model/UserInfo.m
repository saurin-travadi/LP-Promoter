//
//  UserInfo.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize userName = _userName;
@synthesize password = _password;
@synthesize clientID = _clientID;
@synthesize siteURL = _siteURL;
@synthesize email = _email;


-(id)initWithUserName:(NSString *)userName Password:(NSString*)pwd ClientID:(NSString*)clientID SiteURL:(NSString*)url
{
    self = [super init];
    if (self) {
        _userName = userName;
        _password = pwd;
        _clientID = clientID;
        _siteURL = url;
        _email  =@"";
        
        return self;
    }
    return nil;
}

@end
