//
//  NewLeadViewController.h
//  promoter
//
//  Created by Saurin Travadi on 1/15/13.
//
//

#import "BaseUIViewController.h"

@interface NewLeadViewController : BaseUIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *mainContainer;

@property  (strong,nonatomic) IBOutlet UITextField *firstName;
@property  (strong,nonatomic) IBOutlet UITextField *lastName;
@property  (strong,nonatomic) IBOutlet UITextField *homePhone;
@property  (strong,nonatomic) IBOutlet UITextField *workPhone;
@property  (strong,nonatomic) IBOutlet UITextField *cellPhone;
@property  (strong,nonatomic) IBOutlet UITextField *address;
@property  (strong,nonatomic) IBOutlet UITextField *city;
@property  (strong,nonatomic) IBOutlet UITextField *state;
@property  (strong,nonatomic) IBOutlet UITextField *zip;
@property  (strong,nonatomic) IBOutlet UITextField *source;
@property (strong, nonatomic) IBOutlet UILabel *promoterLabel;
@property  (strong,nonatomic) IBOutlet UITextField *promoter;
@property (strong, nonatomic) IBOutlet UILabel *productLabel;
@property  (strong,nonatomic) IBOutlet UITextField *product;
@property (strong, nonatomic) IBOutlet UILabel *altData1Label;
@property (strong, nonatomic) IBOutlet UILabel *altData2Label;
@property  (strong,nonatomic) IBOutlet UITextField *altData1;
@property  (strong,nonatomic) IBOutlet UITextField *altData2;
@property  (strong,nonatomic) IBOutlet UITextField *appDate;
@property  (strong,nonatomic) IBOutlet UITextField *appTime;
@property  (strong,nonatomic) IBOutlet UISwitch *waiver;
@property (strong, nonatomic) IBOutlet UITextView *comments;

@property (strong, nonatomic) IBOutlet UIView *promoterView;
@property (strong, nonatomic) IBOutlet UIView *altView;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;

@property  (strong, nonatomic) IBOutlet UIButton *update;
@property (strong, nonatomic) IBOutlet UIButton *check;

-(IBAction)didCheckAvailibilityClick:(id)sender;
-(IBAction)didSubmitClick:(id)sender;

@end
