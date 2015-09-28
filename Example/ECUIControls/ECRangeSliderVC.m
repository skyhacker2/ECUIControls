//
//  ECRangeSliderVC.m
//  ECUIControls
//
//  Created by Eleven Chen on 15/9/28.
//  Copyright © 2015年 Eleven Chen. All rights reserved.
//

#import "ECRangeSliderVC.h"


@implementation ECRangeSliderVC
- (IBAction)onValueChanged:(ECRangeSlider *)sender
{
    NSLog(@"lower value: %f, upper value: %f", sender.lowerValue, sender.upperValue);
    [self updateLabelPosition];
}

- (void) updateLabelPosition
{
    CGPoint lowerPoint = self.rangeSlider.lowerCenter;
    lowerPoint.x += self.rangeSlider.frame.origin.x;
    lowerPoint.y = self.rangeSlider.frame.origin.y - 10;
    self.startLabel.center = lowerPoint;
    
    CGPoint upperPoint = self.rangeSlider.upperCenter;
    upperPoint.x += self.rangeSlider.frame.origin.x;
    upperPoint.y = self.rangeSlider.frame.origin.y - 10;
    self.endLabel.center = upperPoint;
}

@end
