//
//  PFGridViewDemoViewController.h
//  PFGridViewDemo
//
//  Created by YJ Park on 3/8/11.
//  Copyright 2011 PettyFun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "PFGridView.h"

@interface LookupGridViewController : BaseUIViewController <PFGridViewDataSource, PFGridViewDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *zip;

@property (nonatomic, strong) IBOutlet PFGridView *gridView;
@property (strong, nonatomic) IBOutlet UITextField *branchText;

@end
