//
//  AppDelegate.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *baseUrl;
@property (nonatomic, retain) NSString *localSettingsPath;

#define UIAppDelegate \
((AppDelegate *)[UIApplication sharedApplication].delegate)

- (void)populateLocalSettingsPath;
-(int)getNext;

@end


