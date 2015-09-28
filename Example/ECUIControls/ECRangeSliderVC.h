//
//  ECRangeSliderVC.h
//  ECUIControls
//
//  Created by Eleven Chen on 15/9/28.
//  Copyright © 2015年 Eleven Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ECUIControls/ECUIControls.h>

@interface ECRangeSliderVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet ECRangeSlider *rangeSlider;

@end
