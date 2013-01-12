//
//  PFGridViewDemoViewController.h
//  PFGridViewDemo
//
//  Created by YJ Park on 3/8/11.
//  Copyright 2011 PettyFun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFGridView.h"

@interface LookupGridViewController : UIViewController <PFGridViewDataSource, PFGridViewDelegate>

@property (nonatomic, strong) IBOutlet PFGridView *gridView;


@end
