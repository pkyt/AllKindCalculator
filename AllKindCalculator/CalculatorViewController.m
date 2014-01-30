//
//  CalculatorViewController.m
//  AllKindCalculator
//
//  Created by Pavlo Kytsmey on 1/28/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "CalculatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface CalculatorViewController ()<CalculatorViewDelegate>
@property (nonatomic, weak) IBOutlet CalculatorView *myView;
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSString *previousOperation;
@property (nonatomic) int count;
@property (nonatomic) bool minusInFront;


@end


@implementation CalculatorViewController

@synthesize userIsInTheMiddleOfEnteringNumber;
@synthesize brain = _brain;
@synthesize previousOperation;
@synthesize count;
@synthesize minusInFront;

- (CalculatorBrain *)brain{
    if(!_brain) _brain = [CalculatorBrain new];
    return _brain;
}

- (IBAction)buttonPressed:(UIButton *)sender writeTo:(UILabel*)label{

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
        label.text = senderName;
        userIsInTheMiddleOfEnteringNumber = YES;
    }else{
        label.text = [label.text stringByAppendingString:senderName];
    }
    if (minusInFront&&(!thisMinus)){
        if ((c == '-')||(c == '+')||(c == '/')||(c == '*')||(c == '(')||(c == ')')){
            minusInFront = NO;
            [self.brain pushChar:')'];
        }
    }
    [self.brain pushChar:c];
}

- (IBAction)submitPressed:(UIButton *)sender writeTo:(UILabel*)label{
    if (minusInFront){
        minusInFront = NO;
        [self.brain pushChar:')'];
    }
    NSString * message = [self.brain performOperation];
    if (![self.brain didWeWriteSthToCCode]){
        userIsInTheMiddleOfEnteringNumber = NO;
    }
    label.text = message;
}

- (IBAction)clearPressed:(UIButton*)sender writeTo:(UILabel*)label{
    [self.brain clearExpr];
    label.text = @"0";
    userIsInTheMiddleOfEnteringNumber = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all orientations
}


@end
