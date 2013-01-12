//
//  BaseUIViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>  
#import "MBProgressHUD.h"
#import "UserInfo.h"
#import <CoreLocation/CoreLocation.h>

@class SidebarViewController;

@interface BaseUIViewController : UIViewController <MBProgressHUDDelegate, UITextFieldDelegate> {
    MBProgressHUD *HUD;
    CLLocationManager *locationManager;
}

-(void)setUserInfo:(UserInfo*)userInfo;
-(UserInfo*)getUserInfo;
-(void)makeRoundRect:(UIButton*)sender;
-(void)makeRoundRectView:(UIView*)view;
-(void)logout;

-(UIBarButtonItem*)setBarButton:(NSString*)title;

@end
