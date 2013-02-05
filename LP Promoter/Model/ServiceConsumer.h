//
//  ServiceConsumer.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "Consumer.h"
#import "UserInfo.h"
#import "Settings.h"
#import "DataList.h"
#import "Lookup.h"
#import "Leads.h"

@interface ServiceConsumer : Consumer {
    
    void (^_OnLoginSuccess)(bool*);
    void (^_OnSearchSuccess)(id);
}


-(id)initWithoutBaseURL;

-(void)registerUser:(NSString*)userName Password:(NSString*)pwd ClientId:(NSString*)clientId SiteURL:(NSString*)url EmailAddress:(NSString*)email :(void (^)(bool*))Success;                    //validate username and password and store site URL forever

-(void)performLogin:(UserInfo *)userInfo :(void (^)(bool*))Success;                     //validate username and password

-(void)getLoginMessages:(UserInfo *)userInfo :(void (^)(id))Success;                 //welcome messages

-(void)getLeadSettings:(UserInfo *)userInfo :(void (^)(id))Success;                 //lead settings, to be called after every login and every few hours

-(void)getListByType:(NSString *)type UserInfo:(UserInfo *)userInfo :(void (^)(id))Success;

-(void)getForwardLookup:(UserInfo *)userInfo branch:(NSString *)branch product:(NSString *)product zip:(NSString *)zip :(void (^)(id))Success;

-(void)getLeads:(UserInfo *)userInfo :(void (^)(id))Success;

-(void)updateLead:(UserInfo *)userInfo firstName:(NSString*)fname lastName:(NSString*)lname homePhone:(NSString*)homePhone workPhone:(NSString*)workPhone cellPhone:(NSString*)cellPhone address:(NSString*)address city:(NSString*)city state:(NSString*)state zip:(NSInteger)zip email:(NSString*)email source:(NSInteger)source promoter:(NSInteger)promoter product:(NSString*)product altData1:(NSString*)altData1 altData2:(NSString*)altData2 appDate:(NSString*)appDate appTime:(NSString*)appTime waiver:(NSInteger)waiver notes:(NSString*)notes :(void (^)(bool*))Success;

@end
