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
        NSLog(@"at least got here");
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createLabel];
        [self createButtons];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"at least got here");
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

- (void)buttonSelector:(UIButton*)sender{
    [self.delegate buttonPressed:sender writeTo:_label];
}

- (void)submitSelector:(UIButton*)sender{
    [self.delegate submitPressed:sender writeTo:_label];
}

- (void)clearSelector:(UIButton*)sender{
    [self.delegate clearPressed:sender writeTo:_label];
}

- (void)createButtons{
    NSString* nameOfButtons = @"789+456-123*(0)/";
    for (int i = 1; i < 5; i++){
        for (int j = 0; j < 4; j++) {
            NSString* nameNotReal = [nameOfButtons substringFromIndex:((i-1)*4+j)];
            NSString* name = [nameNotReal substringToIndex:1];
            UIButton* button = [self createButtonWithName:name withX:(self.bounds.origin.x + j*self.bounds.size.width/4) withY:(self.bounds.origin.y + i*self.bounds.size.height/6) withWidth:(self.bounds.size.width/4) withHeight:(self.bounds.size.height/6) withSelector:@selector(buttonSelector:)];
            [self.viewsButtons addObject:button];
            [self addSubview:button];
        }
    }
    // SUBMIT button
    UIButton* button = [self createButtonWithName:@"Submit" withX:self.bounds.origin.x withY:(self.bounds.origin.y + 5*self.bounds.size.height/6) withWidth: (self.bounds.size.width*3/8) withHeight:(self.bounds.size.height/6) withSelector:@selector(submitSelector:)];
    [self.viewsButtons addObject:button];
    [self addSubview:button];
    
    // Clear button
    UIButton* button1 = [self createButtonWithName:@"Clear" withX:(self.bounds.origin.x + 3*self.bounds.size.width/8) withY:(self.bounds.origin.y + 5*self.bounds.size.height/6) withWidth: (self.bounds.size.width*3/8)withHeight:(self.bounds.size.height/6) withSelector:@selector(clearSelector:)];
    [self.viewsButtons addObject:button1];
    [self addSubview:button1];
    
    // dot button
    UIButton* button2 = [self createButtonWithName:@"." withX:(self.bounds.origin.x + 3*self.bounds.size.width/4) withY:(self.bounds.origin.y + 5*self.bounds.size.height/6) withWidth: (self.bounds.size.width/4)withHeight:(self.bounds.size.height/6) withSelector:@selector(buttonSelector:)];
    [self.viewsButtons addObject:button2];
    [self addSubview:button2];
}

- (void)createLabel{
    CGRect labelRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height/6);
    _label = [[UILabel alloc] initWithFrame:labelRect];
    _label.text = @"0";
    [self addSubview:_label];
}

- (void)layoutSubviews{
    #define delta 1
    NSLog(@"GOT TO LAYOUTSUBVIEWS");
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
