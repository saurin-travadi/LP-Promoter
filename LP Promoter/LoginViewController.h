//
//  LoginViewController.h
//  leadperfection
//
//  Created by Saurin Travadi on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "SFHFKeychainUtils.h"
#import "BaseUIViewController.h"

@protocol LoginDelegate

@required
- (void)successfullyLoggedIn;
@end

@interface LoginViewController : BaseUIViewController <UITextFieldDelegate>

@property (nonatomic, assign) NSObject <LoginDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *logOnButton;

@property (nonatomic, retain) IBOutlet UIView *altViewFromNib;
@property (weak, nonatomic) IBOutlet UITextField *rUserName;
@property (weak, nonatomic) IBOutlet UITextField *rPssword;
@property (weak, nonatomic) IBOutlet UITextField *clientID;
@property (weak, nonatomic) IBOutlet UITextField *siteUrl;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;


- (IBAction)login:(id)sender;
-(IBAction)help:(id)sender;
-(IBAction)signup:(id)sender;

@end
