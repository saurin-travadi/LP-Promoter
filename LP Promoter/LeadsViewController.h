
#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface LeadsViewController : BaseUIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@end
