//
//  CalculatorViewController.h
//  AllKindCalculator
//
//  Created by Pavlo Kytsmey on 1/28/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
- (IBAction)buttonPressed:(UIButton*)sender;
- (IBAction)submitPressed:(UIButton*)sender;
- (IBAction)clearPressed:(UIButton*)sender;

@end
