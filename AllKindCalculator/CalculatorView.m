//
//  CalculatorView.m
//  AllKindCalculator
//
//  Created by Pavlo Kytsmey on 1/30/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "CalculatorView.h"

@implementation CalculatorView

@synthesize viewsButtons = _viewsButtons;
@synthesize label = _label;
@synthesize delegate = _delegate;

- (NSMutableArray*)viewsButtons{
    if (!_viewsButtons) {
        _viewsButtons = [NSMutableArray new];
    }
    return _viewsButtons;
}

- (UILabel*)getLabel{
    return _label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createLabel];
        [self createButtons];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createLabel];
        [self createButtons];
    }
    return self;
}

- (UIButton*)createButtonWithName:(NSString*)name withX:(float)x withY:(float)y withWidth:(float)width withHeight:(float)height withSelector:(SEL)selector{
#define delta 1
    CGRect buttonRect = CGRectMake(x + delta ,y + delta ,width - 2*delta, height-2*delta);
    UIButton* button = [[UIButton alloc] initWithFrame:buttonRect];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = YES;
    return button;
}

- (void)callButtonPressed:(UIButton*)sender{
    [self.delegate buttonPressed:sender writeTo:_label];
}

- (void)callSubmitPressed:(UIButton*)sender{
    [self.delegate submitPressed:sender writeTo:_label];
}

- (void)callClearPressed:(UIButton*)sender{
    [self.delegate clearPressed:sender writeTo:_label];
}

- (void)createButtons{
    NSString* nameOfButtons = @"789+456-123*(0)/";
    // size of button are the same for everybody except clear and submit
    float widthButton = self.bounds.size.width/4;
    float heightButton = self.bounds.size.height/6;
    for (int i = 1; i < 5; i++){
        for (int j = 0; j < 4; j++) {
            NSString* nameNotReal = [nameOfButtons substringFromIndex:((i-1)*4+j)];
            NSString* name = [nameNotReal substringToIndex:1];
            float xButton = self.bounds.origin.x + j*self.bounds.size.width/4;
            float yButton = self.bounds.origin.y + i*self.bounds.size.height/6;
            UIButton* button = [self createButtonWithName:name withX:xButton
                                                    withY:yButton
                                                withWidth:widthButton
                                               withHeight:heightButton
                                             withSelector:@selector(callButtonPressed:)];
            [self.viewsButtons addObject:button];
            [self addSubview:button];
        }
    }
    // SUBMIT button
    float xButtonSubmit = self.bounds.origin.x;
    float yButtonSubmit = self.bounds.origin.y + 5*self.bounds.size.height/6;
    float widthButtonSC = self.bounds.size.width*3/8;
    float heightButtonSC = self.bounds.size.height/6;
    UIButton* buttonSubmit = [self createButtonWithName:@"Submit"
                                            withX:xButtonSubmit
                                            withY:yButtonSubmit
                                        withWidth:widthButtonSC
                                       withHeight:heightButtonSC
                                     withSelector:@selector(callSubmitPressed:)];
    [self.viewsButtons addObject:buttonSubmit];
    [self addSubview:buttonSubmit];
    
    // Clear button
    float xButtonClear = self.bounds.origin.x + 3*self.bounds.size.width/8;
    float yButtonClear = self.bounds.origin.y + 5*self.bounds.size.height/6;
    // width and height are the same as previous one
    UIButton* buttonClear = [self createButtonWithName:@"Clear"
                                             withX:xButtonClear
                                             withY:yButtonClear
                                         withWidth: widthButtonSC
                                        withHeight:heightButtonSC
                                      withSelector:@selector(callClearPressed:)];
    [self.viewsButtons addObject:buttonClear];
    [self addSubview:buttonClear];
    
    // dot button
    float xButtonDot = self.bounds.origin.x + 3*self.bounds.size.width/4;
    float yButtonDot = self.bounds.origin.y + 5*self.bounds.size.height/6;
    UIButton* buttonDot = [self createButtonWithName:@"."
                                             withX:xButtonDot
                                             withY:yButtonDot
                                         withWidth:widthButton
                                        withHeight:heightButton
                                      withSelector:@selector(callButtonPressed:)];
    [self.viewsButtons addObject:buttonDot];
    [self addSubview:buttonDot];
}

- (void)createLabel{
    CGRect labelRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height/6);
    _label = [[UILabel alloc] initWithFrame:labelRect];
    _label.text = @"0";
    [self addSubview:_label];
}

- (void)layoutSubviews{
    #define delta 1
    NSUInteger countButttoms = [self.viewsButtons count];
    if (_label) {
        _label.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height/6);
    }
    int column = 0;
    int row = 1;
    for (int i = 0; i < countButttoms; i++) {
        UIButton* button = [self.viewsButtons objectAtIndex:i];
        if (column == 4) {
            column = 0;
            row++;
        }
        if (row < 5) {
            button.frame = CGRectMake(self.bounds.origin.x + column*self.bounds.size.width/4 +delta, (self.bounds.origin.y + row*self.bounds.size.height/6 + delta), (self.bounds.size.width/4 -2*delta), (self.bounds.size.height/6 - 2*delta));
        }else{
            if (column == 0) {
                button.frame = CGRectMake(self.bounds.origin.x + delta, (self.bounds.origin.y + 5*self.bounds.size.height/6 +delta), (self.bounds.size.width*3/8 - 2*delta), (self.bounds.size.height/6 - 2*delta));
            }else if (column == 1){
                button.frame = CGRectMake(self.bounds.origin.x + 3*self.bounds.size.width/8+delta, (self.bounds.origin.y + 5*self.bounds.size.height/6 + delta), (self.bounds.size.width*3/8 - 2*delta), (self.bounds.size.height/6 -2*delta));
            }else{
                button.frame = CGRectMake(self.bounds.origin.x + 3*self.bounds.size.width/4 + delta, (self.bounds.origin.y + 5*self.bounds.size.height/6 + delta), (self.bounds.size.width/4 -2*delta), (self.bounds.size.height/6 - 2*delta));
            }
        }
        column++;
    }
}

@end
