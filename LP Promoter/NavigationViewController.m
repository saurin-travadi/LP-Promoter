//
//  NavigationViewController.m
//  promoter
//
//  Created by Saurin Travadi on 1/9/13.
//
//

#import "NavigationViewController.h"
#import "ServiceConsumer.h"
#import "BaseUIViewController.h"
#import "Settings.h"
#import "Utility.h"

@implementation NavigationViewController {
    MBProgressHUD *HUD;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self getSettings];
//    [self getBranches];
//    [self getProducts];
//    [self getPromoters];
//    [self getSources];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSettings {
    
    [[[ServiceConsumer alloc] init] getLeadSettings:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
        
        Settings *settings = json;
        [[Utility alloc] saveToUserSavedDataWithKey:@"AltData1" Data:settings.altData1];
        [[Utility alloc] saveToUserSavedDataWithKey:@"AltData2" Data:settings.altData2];
        [[Utility alloc] saveToUserSavedDataWithKey:@"CanViewHistory" Data:settings.canViewHistory];
        [[Utility alloc] saveToUserSavedDataWithKey:@"HshBranch" Data:settings.hshBranch];
        [[Utility alloc] saveToUserSavedDataWithKey:@"HshProduct" Data:settings.hshProduct];
        [[Utility alloc] saveToUserSavedDataWithKey:@"HshPromoter" Data:settings.hshPromoter];
        [[Utility alloc] saveToUserSavedDataWithKey:@"HshSource" Data:settings.hshSource];
        [[Utility alloc] saveToUserSavedDataWithKey:@"PromoterDropdownVisible" Data:settings.promoterDropdownVisible];
    }];
}

-(void)getBranches {

    [[[ServiceConsumer alloc] init] getListByType:@"B" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
        [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_B" Data:[json description]];
    }];
}

-(void)getProducts {

    [[[ServiceConsumer alloc] init] getListByType:@"R" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
       [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_R" Data:[json description]];
    }];
}

-(void)getPromoters {
    
    [[[ServiceConsumer alloc] init] getListByType:@"P" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
               [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_P" Data:[json description]];
    }];
}

-(void)getSources {
    
    [[[ServiceConsumer alloc] init] getListByType:@"S" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
       [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_S" Data:[json description]];
    }];
}

@end




