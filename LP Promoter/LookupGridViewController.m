//
//  PFGridViewDemoViewController.m
//  PFGridViewDemo
//
//  Created by YJ Park on 3/8/11.
//  Copyright 2011 PettyFun.com. All rights reserved.
//

#import "LookupGridViewController.h"
#import "ServiceConsumer.h"
#import "Lookup.h"
#import "DataList.h"
#import "Utility.h"

#define ROWHEADERWIDTH  110;


@implementation LookupGridViewController{
    NSMutableArray *lookupTable;
    
    NSMutableArray *branchList;
    UIPickerView *picker;
    UIActionSheet *actionSheet;
    NSString* pickerValue;

}

@synthesize gridView;
@synthesize branchText;

- (id) init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[[ServiceConsumer alloc] init] getListByType:@"B" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
        branchList = json;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
    
    self.gridView.cellHeight = 30.0f;
    self.gridView.headerHeight = 30.0f;
    
    if (![branchText.text isEqualToString:@""]) {
        [self getLookup];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.gridView reloadData];
}

-(void)getLookup {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[ServiceConsumer alloc] init] getForwardLookup:[super getUserInfo] branch:branchText.text product:@"" zip:@"" :^(id json) {
        lookupTable=json;
        
        [self.gridView reloadData];
        [HUD hide:YES];
    }];

}


#pragma mark - PFGridViewDataSource

- (NSUInteger)numberOfSectionsInGridView:(PFGridView *)gridView {
    return 2;
}

- (CGFloat)widthForSection:(NSUInteger)section {
    if (section == 0) {
        return ROWHEADERWIDTH;
    } else {
        return self.gridView.frame.size.width - ROWHEADERWIDTH;
    }
}

- (NSUInteger)numberOfRowsInGridView:(PFGridView *)gridView {
    return [lookupTable count];
}

- (NSUInteger)gridView:(PFGridView *)gridView numberOfColsInSection:(NSUInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [[lookupTable objectAtIndex:0] columnCount];
    }
}

- (CGFloat)gridView:(PFGridView *)gridView widthForColAtIndexPath:(PFGridIndexPath *)indexPath {
    if(indexPath.col==0 && indexPath.section==0){
        return ROWHEADERWIDTH;
    }
    else
    {
        CGFloat width = self.gridView.frame.size.width - ROWHEADERWIDTH;
        NSInteger cnt = [[lookupTable objectAtIndex:0] columnCount];
        return width/cnt;
    }
}

- (UIColor *) backgroundColorForIndexPath:(PFGridIndexPath *)indexPath {
    UIColor *result = nil;
    if (indexPath.section == 0) {
        if (indexPath.row % 2) {
            result = [UIColor colorWithRed:0.7 green:1.0 blue:0.7 alpha:1.0];        
        } else {
            result = [UIColor colorWithRed:0.8 green:1.0 blue:0.8 alpha:1.0];
        }
        return result;
    }
    else
        return [UIColor clearColor];
}

- (PFGridViewCell *)gridView:(PFGridView *)gv cellForColAtIndexPath:(PFGridIndexPath *)indexPath {
    PFGridViewLabelCell *gridCell = (PFGridViewLabelCell *)[self.gridView dequeueReusableCellWithIdentifier:@"LABEL"];
    if (gridCell == nil) {
        gridCell = [[PFGridViewLabelCell alloc] initWithReuseIdentifier:@"LABEL"];

        gridCell.selectedBackgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.8 alpha:1];
    }
    
    NSString *value=@"";
    if(indexPath.section==0){
        value=((Lookup *)[lookupTable objectAtIndex:indexPath.row]).displayDate;
        gridCell.textLabel.textAlignment = UITextAlignmentLeft;
        gridCell.normalBackgroundColor = [self backgroundColorForIndexPath:indexPath];
    }
    else{
        value=[((Lookup *)[lookupTable objectAtIndex:indexPath.row]).tmsValue objectAtIndex:indexPath.col];
        gridCell.textLabel.textAlignment = UITextAlignmentCenter;
        gridCell.normalBackgroundColor = [value intValue]>0?[UIColor greenColor]:[UIColor redColor];
    }
    
    gridCell.textLabel.font = [UIFont systemFontOfSize:12];
    //gridCell.textLabel.lineBreakMode=NSLineBreakByClipping;
    gridCell.textLabel.text = [NSString stringWithFormat:@"%@", [value description]] ;

    
    return gridCell;
}

- (UIColor *)headerBackgroundColorForIndexPath:(PFGridIndexPath *)indexPath {
    return [UIColor blueColor];
}

- (PFGridViewCell *)gridView:(PFGridView *)gv headerForColAtIndexPath:(PFGridIndexPath *)indexPath {
    PFGridViewLabelCell *gridCell = (PFGridViewLabelCell *)[self.gridView dequeueReusableCellWithIdentifier:@"HEADER"];
    if (gridCell == nil) {
        gridCell = [[PFGridViewLabelCell alloc] initWithReuseIdentifier:@"HEADER"];
        gridCell.textLabel.textAlignment = UITextAlignmentCenter;
        gridCell.textLabel.textColor = [UIColor whiteColor];
    }
    
    NSString *value;
    if(indexPath.section==0){
        value = @"Date";
    }
    else{
        value=[((Lookup *)[lookupTable objectAtIndex:0]).tmsDesc objectAtIndex:indexPath.col];
    }
    gridCell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    gridCell.textLabel.text = value;
    gridCell.textLabel.lineBreakMode=NSLineBreakByClipping;
    gridCell.normalBackgroundColor = [self headerBackgroundColorForIndexPath:indexPath];
    return gridCell;
}

- (void)gridView:(PFGridView *)gridView didClickHeaderAtIndexPath:(PFGridIndexPath *)indexPath {
    NSLog(@"didClickHeaderAtIndexPath %@", indexPath);
}

#pragma mark - text field

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self addPickerButtons];
    [textField setInputView:nil];
    
    [picker reloadAllComponents];
    for (int i=0;i<[branchList count];i++) {
        if([((DataList*)[branchList objectAtIndex:i]).value isEqualToString:textField.text])
            [picker selectRow:i inComponent:0 animated:YES];
    }
}

- (void)addPickerButtons {
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleAutomatic];
    
    CGRect ToolBarFrame= CGRectMake(0, 0, 320, 44);
    CGRect pickerFrame =  CGRectMake(0, 44, 320, 100);
    picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator=YES;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:ToolBarFrame];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    [barItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancelPressed)]];
    [barItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [barItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDonePressed)]];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [actionSheet addSubview:pickerToolbar];
    [actionSheet addSubview:picker];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}

-(void) pickerDonePressed {
    [branchText resignFirstResponder];
    
    branchText.text = @"KNX";   //pickerValue;
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [self getLookup];
}

-(void) pickerCancelPressed {
    [branchText resignFirstResponder];
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    pickerValue = branchText.text;
    return [branchList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return ((DataList *)[branchList objectAtIndex:row]).value;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    pickerValue = ((DataList *)[branchList objectAtIndex:row]).value;
}

@end
