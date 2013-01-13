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
#define ROWHEADERWIDTH  110;

@implementation LookupGridViewController{
    NSMutableArray *lookupTable;
}

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.gridView.frame=self.view.frame;
    self.gridView.cellHeight = 30.0f;
    self.gridView.headerHeight = 30.0f;
    
    [self getLookup];
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
    
    [[[ServiceConsumer alloc] init] getForwardLookup:[super getUserInfo] branch:@"KNX" product:@"" zip:@"" :^(id json) {
        lookupTable=json;
        
        [self.gridView reloadData];
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
    } else {
        if (indexPath.row % 2) {
            if (indexPath.col % 2) {
                result = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            } else {
                result = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
                
            }
        } else {
            if (indexPath.col % 2) {
                result = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
            } else {
                result = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            }
        }
    }
    return result;
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
    }
    else{
        value=[((Lookup *)[lookupTable objectAtIndex:indexPath.row]).tmsValue objectAtIndex:indexPath.col];
        gridCell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    gridCell.textLabel.font = [UIFont systemFontOfSize:12];
    gridCell.textLabel.text = [NSString stringWithFormat:@"%@", [value description]] ;
    gridCell.normalBackgroundColor = [self backgroundColorForIndexPath:indexPath];
    
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
    
    NSString *headerText = @"";
    switch(indexPath.col){
        case 0:{
            if(indexPath.section==0)
                headerText = @"Date";
            else
                headerText = @"Mor";
            break;
        }
        case 1:{
            headerText=@"Aft";
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
        case 4:{
            break;
        }
        case 5:{
            break;
        }
        
    }
    gridCell.textLabel.text = headerText;
    gridCell.normalBackgroundColor = [self headerBackgroundColorForIndexPath:indexPath];
    return gridCell;
}

- (void)gridView:(PFGridView *)gridView didClickHeaderAtIndexPath:(PFGridIndexPath *)indexPath {
    NSLog(@"didClickHeaderAtIndexPath %@", indexPath);
}

@end
