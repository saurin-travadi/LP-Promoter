//
//  NewLeadViewController.h
//  promoter
//
//  Created by Saurin Travadi on 1/15/13.
//
//

#import "BaseUIViewController.h"

@interface NewLeadViewController : BaseUIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *mainContainer;
@property (strong, nonatomic) IBOutlet UITextView *comments;

@end
