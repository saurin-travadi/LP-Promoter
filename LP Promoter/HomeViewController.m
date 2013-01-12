//
//  HomeViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 8/30/12.
//
//

#import "HomeViewController.h"
#import "ServiceConsumer.h"
#import "Utility.h"

@implementation HomeViewController {
    NSMutableArray *messages;
}

//@synthesize tableView;

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
    
    UIBarButtonItem *logout = [super setBarButton:@"Log Out"];
//    [logout setBackgroundImage:[UIImage imageNamed:@"logoutButton.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    self.navigationItem.rightBarButtonItem = logout;
    logout.target=self;
    logout.action=@selector(logout:);
    
    CGRect frame = CGRectMake(0, 28, self.view.bounds.size.width, 20);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = [UIImage imageNamed:@"DottedLine.png"];
    [self.view addSubview:imgView];
    [self.view sendSubviewToBack:imgView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    [self getMessages];
    
    NSString * history = [[Utility alloc] retrieveFromUserSavedData:@"CanViewHistory"];
    NSLog(@"%@",history);
    [self thirdButton].enabled=NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    //[messages removeAllObjects];
    if([messages count]>0)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
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


#pragma tableview events
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[messages count]);
    return [messages count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",[messages count]);
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    for (UIView *v in cell.subviews) {
        [v removeFromSuperview];
    }
    

    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 25)];
    view.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1];
    [cell addSubview:view];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 25)];
    [view addSubview:lbl];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
    lbl.text = @"From";
    
    UILabel *lblFrom= [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 250, 25)];
    [view addSubview:lblFrom];
    [lblFrom setBackgroundColor:[UIColor clearColor]];
    lblFrom.textColor = [UIColor colorWithRed:0.204 green:0.318 blue:0.416 alpha:1];
    lblFrom.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    NSString *date = [[messages objectAtIndex:indexPath.row] objectAtIndex:2];
    date = [NSString stringWithFormat:@"%@ %@",[date substringToIndex:10],[[date substringFromIndex:11] substringToIndex:5]];

    NSString *header = [@"" stringByAppendingFormat:@"%@ | %@",
                            [[messages objectAtIndex:indexPath.row] objectAtIndex:1],
                            date
                        ];
    lblFrom.text = header;

    NSString *cellText = [[messages objectAtIndex:indexPath.row] objectAtIndex:0];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 280, labelSize.height)];
    [cell addSubview:lblText];
    lblText.textColor = [UIColor darkGrayColor];
    lblText.font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
    lblText.lineBreakMode = UILineBreakModeWordWrap;
    lblText.numberOfLines = 0;
    lblText.text = [[messages objectAtIndex:indexPath.row] objectAtIndex:0];

    CGRect frame = cell.frame;
    frame.origin.y = labelSize.height+40;
    frame.size.height = 10;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = [UIImage imageNamed:@"DottedLine.png"];
    [cell addSubview:imgView];
    [self.view sendSubviewToBack:imgView];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[messages objectAtIndex:indexPath.row] objectAtIndex:0];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 50;
}

-(void)getMessages
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.dimBackground = YES;
    
    [[[ServiceConsumer alloc] init] getLoginMessages:[super getUserInfo] :^(id json) {
        
        [HUD hide:YES];
        
        messages = json;
        [self.tableView reloadData];
    }];
}

-(IBAction)logout:(id)sender {
    [super logout];
}

@end
