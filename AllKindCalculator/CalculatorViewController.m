//
//  CalculatorViewController.m
//  AllKindCalculator
//
//  Created by Pavlo Kytsmey on 1/28/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import <QuartzCore/QuartzCore.h>

@interface CalculatorViewController ()
@property (nonatomic, strong) NSMutableArray* arrayOfViewButtons;
@property (nonatomic) UILabel* label;
@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float width;
@property (nonatomic) float heigth;
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSString *previousOperation;
@property (nonatomic) int count;
@property (nonatomic) bool minusInFront;
@property (nonatomic, strong) NSString* labelMessage;
@property (nonatomic) NSNotificationCenter*  orientationChanged;

- (void)createLabel;
- (void)createButtons;
- (void)removeEverythingFromView;
- (void)deviceOrientationDidChange:(NSNotification*)sender;

@end


@implementation CalculatorViewController
@synthesize label = _label;
@synthesize arrayOfViewButtons = _arrayOfViewButtons;
@synthesize x = _x;
@synthesize y = _y;
@synthesize width = _width;
@synthesize heigth = _heigth;
@synthesize userIsInTheMiddleOfEnteringNumber;
@synthesize brain = _brain;
@synthesize previousOperation;
@synthesize count;
@synthesize minusInFront;
@synthesize labelMessage = _labelMessage;
@synthesize orientationChanged = _orientationChanged;

- (CalculatorBrain *)brain{
    if(!_brain) _brain = [CalculatorBrain new];
    return _brain;
}


- (NSMutableArray*)arrayOfViewButtons{
    if (!_arrayOfViewButtons){
        _arrayOfViewButtons = [NSMutableArray new];
    }
    return _arrayOfViewButtons;
}

- (void)createLabel{
    CGRect labelRect = CGRectMake(_x, _y, _width, _heigth/6);
    _label = [[UILabel alloc] initWithFrame:labelRect];
    _label.text = _labelMessage;
    [self.view addSubview:_label];
}

- (void)removeEverythingFromView{
    if (_label){
        [_label removeFromSuperview];
    }
    int countButttoms = [self.arrayOfViewButtons count];
    for (int i = 0; i < countButttoms; i++) {
        UIButton* button = [self.arrayOfViewButtons objectAtIndex:i];
        [button removeFromSuperview];
    }
    [self.arrayOfViewButtons removeAllObjects];
}

- (void)deviceOrientationDidChange:(NSNotification*)sender{
    _labelMessage = _label.text;
    if (!_labelMessage) {
        _labelMessage = @"0";
    }else{
        _labelMessage = _label.text;
    }
    float midVar = _width;
    _width = _heigth + 10;
    _heigth = midVar -10;
    midVar = _x;
    _x = _y - 10;
    _y = midVar + 10;
    [self removeEverythingFromView];
    [self createLabel];
    [self createButtons];
}

- (void)createButtons{
    #define delta 1
    NSString* nameOfButtons = @"789+456-123*(0)/";
    for (int i = 1; i < 5; i++){
        for (int j = 0; j < 4; j++) {
            CGRect buttonRect = CGRectMake(_x  + j*_width/4 + delta ,_y + i*_heigth/6 + delta , _width/4 - 2*delta, _heigth/6-2*delta);
            NSString* nameNotReal = [nameOfButtons substringFromIndex:((i-1)*4+j)];
            NSString* name = [nameNotReal substringToIndex:1];
            UIButton* button = [[UIButton alloc] initWithFrame:buttonRect];
            button.layer.cornerRadius = 10;
            button.clipsToBounds = YES;
            [button setTitle:name forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor yellowColor]];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            [self.arrayOfViewButtons addObject:button];
            [self.view addSubview:button];
        }
    }
    // SUBMIT button
    CGRect buttonRect = CGRectMake(_x  + delta ,_y + 5*_heigth/6 + delta , 3*_width/8 - 2*delta, _heigth/6-2*delta);
    UIButton* button = [[UIButton alloc] initWithFrame:buttonRect];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [button setTitle:@"Submit" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = YES;
    [self.arrayOfViewButtons addObject:button];
    [self.view addSubview:button];
    
    // Clear button
    CGRect buttonRect1 = CGRectMake(_x + 3*_width/8 + delta ,_y + 5*_heigth/6 + delta , 3*_width/8 - 2*delta, _heigth/6-2*delta);
    UIButton* button1 = [[UIButton alloc] initWithFrame:buttonRect1];
    button1.layer.cornerRadius = 10;
    button1.clipsToBounds = YES;
    [button1 setTitle:@"Clear" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor yellowColor]];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button1.userInteractionEnabled = YES;
    [self.arrayOfViewButtons addObject:button1];
    [self.view addSubview:button1];
    
    // dot button
    CGRect buttonRect2 = CGRectMake(_x + 3*_width/4 + delta ,_y + 5*_heigth/6 + delta , _width/4 - 2*delta, _heigth/6-2*delta);
    UIButton* button2 = [[UIButton alloc] initWithFrame:buttonRect2];
    button2.layer.cornerRadius = 10;
    button2.clipsToBounds = YES;
    [button2 setTitle:@"." forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundColor:[UIColor yellowColor]];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button2.userInteractionEnabled = YES;
    [self.arrayOfViewButtons addObject:button2];
    [self.view addSubview:button2];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *senderName = [sender currentTitle];
    char c = [senderName characterAtIndex:0];
    BOOL thisMinus = NO;
    if (!userIsInTheMiddleOfEnteringNumber){
        if (c == '-'){
            minusInFront = YES;
            thisMinus = YES;
            [self.brain pushChar:'('];
            [self.brain pushChar:'0'];
        }
        _label.text = senderName;
        userIsInTheMiddleOfEnteringNumber = YES;
    }else{
        _label.text = [_label.text stringByAppendingString:senderName];
    }
    if (minusInFront&&(!thisMinus)){
        if ((c == '-')||(c == '+')||(c == '/')||(c == '*')||(c == '(')||(c == ')')){
            minusInFront = NO;
            [self.brain pushChar:')'];
        }
    }
    [self.brain pushChar:c];
}

- (IBAction)submitPressed:(UIButton *)sender{
    if (minusInFront){
        minusInFront = NO;
        [self.brain pushChar:')'];
    }
    NSString * message = [self.brain performOperation];
    if (![self.brain didWeWriteSthToCCode]){
        userIsInTheMiddleOfEnteringNumber = NO;
    }
    _label.text = message;
}

- (IBAction)clearPressed:(UIButton*)sender {
    [self.brain clearExpr];
    _label.text = @"0";
    userIsInTheMiddleOfEnteringNumber = NO;
}

- (void)viewDidLoad
{
    if (!_labelMessage) {
        _labelMessage = @"0";
    }
    [super viewDidLoad];
    _width = self.view.bounds.size.height;
    _heigth = self.view.bounds.size.width - 10;
    _x = self.view.bounds.origin.y;
    _y = self.view.bounds.origin.x + 10;
    [self removeEverythingFromView];
    [self createLabel];
    [self createButtons];
    if (!_orientationChanged) {
        _orientationChanged = [NSNotificationCenter defaultCenter];
        [_orientationChanged addObserver:self
                             selector:@selector(deviceOrientationDidChange:)
                             name:UIDeviceOrientationDidChangeNotification
                             object:nil];
    }
    self.view.userInteractionEnabled = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    NSLog(@"got here");
    return YES; // support all orientations
}


@end
