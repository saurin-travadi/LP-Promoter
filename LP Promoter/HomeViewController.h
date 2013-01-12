//
//  HomeViewController.h
//  sales and tracking
//
//  Created by Sejal Pandya on 8/30/12.
//
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface HomeViewController : BaseUIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *thirdButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
-(IBAction)logout:(id)sender;


@end
