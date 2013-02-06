//
//  NewLeadViewController.m
//  promoter
//
//  Created by Saurin Travadi on 1/15/13.
//
//

#import "NewLeadViewController.h"
#import "LookupGridViewController.h"
#import "ServiceConsumer.h"
#import "NextUITextField.h"

@implementation NewLeadViewController {
    CGPoint svos;
    
    NSMutableArray *sourceList, *promoterList, *productList;
    UIPickerView *picker;
    UIActionSheet *actionSheet;
    NSString* pickerValue;
    UITextField *textBox;
    NSTimer* showDecimalPointTimer;
    UIButton *doneButton;

    UIDatePicker *datePicker;
    
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
    
    [[[ServiceConsumer alloc] init] getListByType:@"S" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
        sourceList = json;
        [sourceList insertObject:[[DataList alloc] initWithKey:@"" value:@""]  atIndex:0];
    }];
    
    [[[ServiceConsumer alloc] init] getListByType:@"P" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
        promoterList = json;
        [promoterList insertObject:[[DataList alloc] initWithKey:@"" value:@""]  atIndex:0];
    }];
    [[[ServiceConsumer alloc] init] getListByType:@"R" UserInfo:[[[BaseUIViewController alloc] init] getUserInfo] :^(id json) {
        productList = json;
        [productList insertObject:[[DataList alloc] initWithKey:@"" value:@""]  atIndex:0];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [mainContainer addGestureRecognizer:singleTap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"CheckSeuge"]) {
        
        LookupGridViewController *lookup = segue.destinationViewController;

        lookup.productId=self.product.text;
        lookup.zip=self.zip.text;
        
        [super setBackButton];
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [doneButton removeFromSuperview];
    [actionSheet removeFromSuperview];
    
    return  YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    //change frame for scrollview for keyboard shown
    svos = self.mainContainer.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.mainContainer];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 10;
    [self.mainContainer setContentOffset:pt animated:YES];
    
    textBox = textField;
    if(textBox==self.source || textBox==self.promoter || textBox==self.product || textBox==self.appDate || textBox==self.appTime){
       
        [self addPickerButtons];
        [textField setInputView:nil];
        
        if(textBox==self.appDate){
            
        }
        else{
            [picker reloadAllComponents];
            
            NSMutableArray *tmpList = (textBox==self.source?sourceList:textBox==self.promoter?promoterList:productList);
            NSInteger cnt = [tmpList count];
            
            for (int i=0;i<cnt;i++) {
                if([((DataList*)[tmpList objectAtIndex:i]).value isEqualToString:textField.text])
                    [picker selectRow:i inComponent:0 animated:YES];
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;

    //change frame for scrollview for keyboard shown
    [self.mainContainer setContentOffset:svos animated:YES];

    if ([textField isKindOfClass:[NextUITextField class]]) {
        if (((NextUITextField *) textField).nextField != nil)
            [((NextUITextField *) textField).nextField becomeFirstResponder];
        else {
            [self didSubmitClick:nil];
        }
    }
    
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
    pt.y -= 10;
    [self.mainContainer setContentOffset:pt animated:YES];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    //change frame for scrollview for keyboard shown
    [self.mainContainer setContentOffset:svos animated:YES];
    [textView resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)addDoneButton {
    
    if(textBox==self.workPhone || textBox==self.homePhone || textBox==self.cellPhone) {
        
        //Add a button to the top, above all windows
        NSArray *allWindows = [[UIApplication sharedApplication] windows];
        int topWindow = [allWindows count] - 1;
        UIWindow *keyboardWindow = [allWindows objectAtIndex:topWindow];
        
        // create custom button
        doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(0, 427, 105, 53);
        doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [doneButton setTitleColor:[UIColor colorWithRed:77.0f/255.0f green:84.0f/255.0f blue:98.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        
        [doneButton addTarget:self action:@selector(keyboardDonePressed) forControlEvents:UIControlEventTouchUpInside];
        [keyboardWindow addSubview:doneButton];
    }
}

-(void) keyboardDonePressed {
    
    [textBox resignFirstResponder];
    [doneButton removeFromSuperview];

    textBox=nil;
}

- (void)addPickerButtons {
    
    CGRect ToolBarFrame= CGRectMake(0, 0, 320, 44);
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleAutomatic];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:ToolBarFrame];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    [barItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancelPressed)]];
    [barItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [barItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDonePressed)]];
    
    [pickerToolbar setItems:barItems animated:YES];

    if(textBox==self.appDate || textBox==self.appTime){

        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 100)];
        
        datePicker.datePickerMode = textBox==self.appDate? UIDatePickerModeDate: UIDatePickerModeTime;

        [actionSheet addSubview:datePicker];
    }
    else{
        
        CGRect pickerFrame =  CGRectMake(0, 44, 320, 100);
        picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator=YES;

        [actionSheet addSubview:picker];
    }

    [actionSheet addSubview:pickerToolbar];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0,320, 464)];
}

-(void) pickerDonePressed {
    
    [textBox resignFirstResponder];
    
    if(textBox==self.appDate){
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterShortStyle;
        textBox.text = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker.date]];
    }
    else if(textBox==self.appTime){

        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        int hour   =    [[calendar components:NSHourCalendarUnit    fromDate:[datePicker date]] hour];
        int minute =    [[calendar components:NSMinuteCalendarUnit  fromDate:[datePicker date]] minute];
        
        textBox.text = [NSString stringWithFormat:@"%d:%d", hour, minute];
    }
    else{
        textBox.text = pickerValue;
    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void) pickerCancelPressed {

    [textBox resignFirstResponder];
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)note {
    
//    if(textBox==self.homePhone || textBox==self.workPhone || textBox==self.cellPhone) {
//        
//        showDecimalPointTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(addDoneButton) userInfo:nil repeats:NO];
//        [[NSRunLoop currentRunLoop] addTimer:showDecimalPointTimer forMode:NSDefaultRunLoopMode];
//    }
}

- (void)keyboardDidHide:(NSNotification *)note {
    [doneButton removeFromSuperview];
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture {
    
    //determine if single tap has occured in response to button touch
    CGPoint touchPoint=[gesture locationInView:mainContainer];
    CGRect frame = self.update.frame;
    
    if(touchPoint.x>=frame.origin.x && touchPoint.x<=frame.origin.x+frame.size.width
       && touchPoint.y>=frame.origin.y && touchPoint.y<=frame.origin.y+frame.size.height)
    {
        //[self.btnUpdate setHighlighted:YES];
        //[self update:nil];
    }
    else{
        
        for (UIView *vw in self.view.subviews) {
            if([vw isKindOfClass:[UITextField class]] || [vw isKindOfClass:[UITextView class]]){
                [vw resignFirstResponder];
            }
        }
    }
}

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSMutableArray *tmpList = (textBox==self.source?sourceList:textBox==self.promoter?promoterList:productList);
    NSInteger cnt = [tmpList count];
    
    pickerValue = textBox.text;
    return cnt;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSMutableArray *tmpList = (textBox==self.source?sourceList:textBox==self.promoter?promoterList:productList);
    return ((DataList *)[tmpList objectAtIndex:row]).value;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    NSMutableArray *tmpList = (textBox==self.source?sourceList:textBox==self.promoter?promoterList:productList);
    pickerValue = ((DataList *)[tmpList objectAtIndex:row]).value;
}

-(IBAction)didCheckAvailibilityClick:(id)sender {
    [self performSegueWithIdentifier:@"CheckSeuge" sender:nil];
}

-(IBAction)didSubmitClick:(id)sender {
    
    [[[ServiceConsumer alloc] init] updateLead:[super getUserInfo] firstName:self.firstName.text lastName:self.lastName.text homePhone:self.homePhone.text workPhone:self.workPhone.text cellPhone:self.cellPhone.text address:self.address.text city:self.city.text state:self.state.text zip:[self.zip.text intValue] email:@"" source:[self.source.text intValue] promoter:[self.promoter.text intValue] product:self.product.text altData1:self.altData1.text altData2:self.altData2.text appDate:self.appDate.text appTime:self.appTime.text waiver:self.waiver.on notes:self.comments.text :^(bool *success) {
        
        if(*success){
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                              message:@"Record Saved"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
        else {
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                              message:@"Unabled to save current record"
                                                             delegate:nil                                   //dont set delegate, dont want to handle it
                                                    cancelButtonTitle:@"Try Again"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
    {
       self.firstName.text=@"";
       self.lastName.text=@"";
       self.homePhone.text=@"";
       self.workPhone.text=@"";
       self.cellPhone.text=@"";
       self.address.text=@"";
       self.city.text=@"";
       self.state.text=@"";
       self.zip.text=@"";
       self.altData1.text=@"";
       self.altData2.text=@"";
       self.appDate.text=@"";
       self.appTime.text=@"";
       self.comments.text=@"";
    }
}

@end
