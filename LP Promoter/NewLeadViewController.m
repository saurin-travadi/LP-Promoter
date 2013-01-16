//
//  NewLeadViewController.m
//  promoter
//
//  Created by Saurin Travadi on 1/15/13.
//
//

#import "NewLeadViewController.h"


@implementation NewLeadViewController {
    CGPoint svos;

}

@synthesize mainContainer;
@synthesize comments;

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
    
    mainContainer.frame = self.view.bounds;
    mainContainer.contentSize = CGSizeMake(self.view.bounds.size.width, 787);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {

    //change frame for scrollview for keyboard shown
    svos = self.mainContainer.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.mainContainer];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [self.mainContainer setContentOffset:pt animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    //change frame for scrollview for keyboard shown
    [self.mainContainer setContentOffset:svos animated:YES];
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    //change frame for scrollview for keyboard shown
    svos = self.mainContainer.contentOffset;
    CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:self.mainContainer];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [self.mainContainer setContentOffset:pt animated:YES];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    //change frame for scrollview for keyboard shown
    [self.mainContainer setContentOffset:svos animated:YES];
    [textView resignFirstResponder];
    return YES;
}

@end
