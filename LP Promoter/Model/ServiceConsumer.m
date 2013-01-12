//
//  ServiceConsumer.m
//  leadperfection
//
//  Created by Saurin Travadi on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceConsumer.h"
#import "Utility.h"
#import "AppDelegate.h"

@implementation ServiceConsumer {
    NSString *baseURL;
}

-(id)init {
    self = [super init];
    if (self) {
        
        baseURL = [Utility retrieveFromUserDefaults:@"baseurl_preference"];
        if([baseURL isEqualToString:@""]) {
            [super missingBaseUrl];
            return nil;
        }
            
        return self;
    }
    return nil;
}

-(id)initWithoutBaseURL {
    self = [super init];
    if (self) {
        return self;
    }
    return nil;
}

-(void)registerUser:(NSString*)userName Password:(NSString*)pwd ClientId:(NSString*)clientId SiteURL:(NSString*)url EmailAddress:(NSString*)email :(void (^)(bool*))Success {

        
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> <soap:Body> <ValidateLogin xmlns=\"http://webservice.leadperfection.com/\"> <clientid>%@</clientid> <username>%@</username> <password>%@</password> <email>%@</email></ValidateLogin> </soap:Body> </soap:Envelope>",clientId,userName,pwd,email];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/ValidateLogin" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"ValidateLoginResult" Request:req :^(id json) {
        NSString* result = [NSString stringWithFormat:@"%@",[json description]];
        
        bool success = true;
        if([result isEqualToString:@"\"NOT VALID USER\""])
            success=false;
        
        _OnLoginSuccess(&success);
    } :^(NSError *error) {
        bool success = false;
        _OnLoginSuccess(&success);
    }];

}

-(void)performLogin:(UserInfo *)userInfo :(void (^)(bool*))Success {
    
    _OnLoginSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> <soap:Body> <ValidateLogin xmlns=\"http://webservice.leadperfection.com/\"> <clientid>%@</clientid> <username>%@</username> <password>%@</password> </ValidateLogin> </soap:Body> </soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/ValidateLogin" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"ValidateLoginResult" Request:req :^(id json) {
        NSString* result = [NSString stringWithFormat:@"%@",[json description]];
        
        bool success = true;
        if([result isEqualToString:@"\"NOT VALID USER\""])
            success=false;
        
        _OnLoginSuccess(&success);
    } :^(NSError *error) {
        bool success = false;
        _OnLoginSuccess(&success);
    }];
}

-(void)getLoginMessages:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><LeadsLoginMessage xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></LeadsLoginMessage></soap:Body></soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/LeadsLoginMessage" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"LeadsLoginMessageResult" Request:req :^(id json) {
        NSMutableArray *messages = [[NSMutableArray alloc] init];
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            NSMutableArray *data = [NSMutableArray arrayWithObjects:[obj valueForKey:@"Message"],[obj valueForKey:@"From"],[obj valueForKey:@"MessageDateDisplay"], nil];
            [messages addObject: data];
        }
        
        
        _OnSearchSuccess(messages);
        
    } :^(NSError *error) {
        
        
        _OnSearchSuccess(nil);
    }];
}

-(void)getLeadSettings:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLeadsSettings xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password></GetLeadsSettings></soap:Body></soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password];
    
    NSURL *url = [NSURL URLWithString: baseURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://webservice.leadperfection.com/GetLeadsSettings" forHTTPHeaderField:@"SOAPAction"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self getDataForElement:@"GetLeadsSettingsResult" Request:req :^(id json) {
        Settings *settings;
        
        NSArray *result = [json JSONValue];
        for (id obj in result) {
            
            settings = [[Settings alloc] initWithAltData1:[obj valueForKey:@"AltData1"] altData2:[obj valueForKey:@"AltData2"] canViewHistory:[obj valueForKey:@"CanViewHistory"] hshBranch:[obj valueForKey:@"HshBranch"] hshProduct:[obj valueForKey:@"HshProduct"] hshPromoter:[obj valueForKey:@"HshPromoter"] hshSource:[obj valueForKey:@"HshSource"] promoterDropdown:[obj valueForKey:@"PromoterDropdownVisible"]];
        }
        
        
        _OnSearchSuccess(settings);
        
    } :^(NSError *error) {
        
        _OnSearchSuccess(nil);
    }];
}

-(void)getListByType:(NSString *)type UserInfo:(UserInfo *)userInfo :(void (^)(id))Success {
    
    _OnSearchSuccess = [Success copy];
    
    NSString *jsonString = [[Utility alloc] retrieveFromUserSavedData:[@"" stringByAppendingFormat:@"DataList_%@",type]];
    if(jsonString==NULL || [jsonString isEqualToString:@""])
    {
        NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLeadsSourceSubPromoter xmlns=\"http://webservice.leadperfection.com/\"><clientid>%@</clientid><username>%@</username><password>%@</password><type>%@</type></GetLeadsSourceSubPromoter></soap:Body></soap:Envelope>",userInfo.clientID,userInfo.userName,userInfo.password,type];
        
        NSURL *url = [NSURL URLWithString: baseURL];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
        [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [req addValue:@"http://webservice.leadperfection.com/GetLeadsSourceSubPromoter" forHTTPHeaderField:@"SOAPAction"];
        [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        
        [self getDataForElement:@"GetLeadsSourceSubPromoterResult" Request:req :^(id json) {
            
            NSArray *result = [json JSONValue];
            
            
            _OnSearchSuccess(nil);
            
        } :^(NSError *error) {

            
            _OnSearchSuccess(nil);
        }];
    }
    else{
        
    }
}

@end





