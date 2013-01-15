//
//  NavigationViewController.m
//  promoter
//
//  Created by Saurin Travadi on 1/9/13.
//
//

#import "NavigationViewController.h"
#import "ServiceConsumer.h"
#import "Settings.h"
#import "Utility.h"

@implementation NavigationViewController {
    MBProgressHUD *HUD;
    BOOL bSettingsLoaded[5];
    
    BOOL bLoad;
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
    bLoad=YES;
	// Do any additional setup after loading the view.
    
    [self.view bringSubviewToFront:[self.view viewWithTag:100]];
    [self.navigationController setToolbarHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if(!bLoad){

        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    else {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        bLoad=NO;
        
        [self getSettings];
        
        [self performSelector:@selector(didSettingsLoad) withObject:nil afterDelay:1.0];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didSettingsLoad {
    
    if(bSettingsLoaded[0] && bSettingsLoaded[1] && bSettingsLoaded[2] && bSettingsLoaded[3] && bSettingsLoaded[4]){
        [HUD hide:YES];
        [self performSegueWithIdentifier:@"NaviagationSegue" sender:self];
    }
    else{
        [self performSelector:@selector(didSettingsLoad) withObject:nil afterDelay:1.0];
    }
}

-(void)getSettings {
    
    [[[ServiceConsumer alloc] init] getLeadSettings:[super getUserInfo] :^(id json) {
        //exiting hash values for branch, product, promoter and source list
        NSString *branchHash = [[Utility alloc] retrieveFromUserSavedData:@"HshBranch"];
        NSString *productHash = [[Utility alloc] retrieveFromUserSavedData:@"HshProduct"];
        NSString *promoterHash = [[Utility alloc] retrieveFromUserSavedData:@"HshPromoter"];
        NSString *sourceHash = [[Utility alloc] retrieveFromUserSavedData:@"HshSource"];

        Settings *settings = json;
        
        [[Utility alloc] saveToUserSavedDataWithKey:@"AltData1" Data:settings.altData1];
        [[Utility alloc] saveToUserSavedDataWithKey:@"AltData2" Data:settings.altData2];
        [[Utility alloc] saveToUserSavedDataWithKey:@"CanViewHistory" Data:settings.canViewHistory];
        [[Utility alloc] saveToUserSavedDataWithKey:@"PromoterDropdownVisible" Data:settings.promoterDropdownVisible];
        
        if(![[settings.hshBranch description] isEqualToString:[branchHash description]])
        {
            [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_B" Data:@""];
            [self getBranches];

            [[Utility alloc] saveToUserSavedDataWithKey:@"HshBranch" Data:settings.hshBranch];
        }
        else
        {
            bSettingsLoaded[1]=YES;
        }
        
        if(![[settings.hshProduct description] isEqualToString:[productHash description]])
        {
            [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_R" Data:@""];
            [self getProducts];
            
            [[Utility alloc] saveToUserSavedDataWithKey:@"HshProduct" Data:settings.hshProduct];
        }
        else
        {
            bSettingsLoaded[2]=YES;
        }

        if(![[settings.hshPromoter description] isEqualToString:[promoterHash description]])
        {
            [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_P" Data:@""];
            [self getPromoters];
            
            [[Utility alloc] saveToUserSavedDataWithKey:@"HshPromoter" Data:settings.hshPromoter];
        }
        else
        {
            bSettingsLoaded[3]=YES;
        }
        
        if(![[settings.hshSource description] isEqualToString:[sourceHash description]])
        {
            [[Utility alloc] saveToUserSavedDataWithKey:@"DataList_S" Data:@""];
            [self getSources];
            
            [[Utility alloc] saveToUserSavedDataWithKey:@"HshSource" Data:settings.hshSource];
        }
        else
        {
            bSettingsLoaded[4]=YES;
        }
        
        bSettingsLoaded[0]=YES;
        
        //now schedule next refresh in 2 minutes
        [self performSelector:@selector(getSettings) withObject:nil afterDelay:2000];
        
    }];
}

-(void)getBranches {

    [[[ServiceConsumer alloc] init] getListByType:@"B" UserInfo:[super getUserInfo] :^(id json) {
        bSettingsLoaded[1]=YES;
    }];
}

-(void)getProducts {

    [[[ServiceConsumer alloc] init] getListByType:@"R" UserInfo:[super getUserInfo] :^(id json) {
        bSettingsLoaded[2]=YES;
    }];
}

-(void)getPromoters {
    
    [[[ServiceConsumer alloc] init] getListByType:@"P" UserInfo:[super getUserInfo] :^(id json) {
        bSettingsLoaded[3]=YES;
    }];
}

-(void)getSources {
    
    [[[ServiceConsumer alloc] init] getListByType:@"S" UserInfo:[super getUserInfo] :^(id json) {
        bSettingsLoaded[4]=YES;
    }];
}

@end




