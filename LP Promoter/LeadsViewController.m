

#import "LeadsViewController.h"
#import "ServiceConsumer.h"


@implementation LeadsViewController {
    NSMutableArray *leads;
}


@synthesize tableView;

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
    
    [self getLeads]; 
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:NO];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)getLeads
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getLeads:[super getUserInfo] :^(id json) {
        
        leads = json;
        [self.tableView reloadData];
        
        [HUD hide:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [leads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    CGRect frame = cell.frame;
    frame.origin.y = frame.size.height-10;
    frame.size.height = 10;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = [UIImage imageNamed:@"DottedLine.png"];
    [cell addSubview:imgView];
    
    Leads *ld = [leads objectAtIndex:indexPath.row];

    ((UILabel *)[cell viewWithTag:100]).text = ld.lastName;
    ((UILabel *)[cell viewWithTag:101]).text = [ld address];
    ((UILabel *)[cell viewWithTag:102]).text = [ld phone];
    ((UILabel *)[cell viewWithTag:103]).text = [ld product];
    ((UILabel *)[cell viewWithTag:104]).text = [ld apptDate];
    
    return cell;
}



@end
