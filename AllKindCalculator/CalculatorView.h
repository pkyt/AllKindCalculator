//
//  CalculatorView.h
//  AllKindCalculator
//
//  Created by Pavlo Kytsmey on 1/30/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculatorViewDelegate
- (IBAction)buttonPressed:(UIButton*)sender writeTo:(UILabel*)label;
- (IBAction)submitPressed:(UIButton*)sender writeTo:(UILabel*)label;
- (IBAction)clearPressed:(UIButton*)sender writeTo:(UILabel*)label;
@end

@interface CalculatorView : UIView

@property (nonatomic) NSMutableArray* viewsButtons;
@property (nonatomic) UILabel* label;
@property (nonatomic, weak) IBOutlet id <CalculatorViewDelegate> delegate;

- (UILabel*)getLabel;

@end
