//
//  Consumer.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consumer : NSObject<NSXMLParserDelegate> {
    NSURLConnection *conn;
    NSMutableData *webData;
    
    NSXMLParser *xmlParser;
    
    void (^_OnSuccess)(id json);
    void (^_OnFailure)(NSError* error);
}

-(void)getDataForElement:(NSString*)element Request:(NSMutableURLRequest *)req :(void (^)(id))Success :(void(^)(NSError *))Failure;
- (void)missingBaseUrl;

@end
