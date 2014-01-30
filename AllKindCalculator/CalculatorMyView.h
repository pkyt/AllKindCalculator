//
//  CalculatorMyView.h
//  AllKindCalculator
//
//  Created by Pavlo Kytsmey on 1/30/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculatorMyViewFunctions
- (IBAction)buttonPressed:(UIButton*)sender;
- (IBAction)submitPressed:(UIButton*)sender;
- (IBAction)clearPressed:(UIButton*)sender;
@end

@interface CalculatorMyView : UIView

@property (nonatomic) NSMutableArray* viewsButtons;
@property (nonatomic) UILabel* label;
@property (nonatomic, weak) IBOutlet id <CalculatorMyViewFunctions> myFunctions;

@end
