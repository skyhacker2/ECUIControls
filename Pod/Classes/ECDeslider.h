//
//  ECDeslider.h
//  Pods
//
//  Created by Eleven Chen on 15/9/1.
//
//

#import <UIKit/UIKit.h>

/// 两个滑块的Slider
// 只实现了normal状态
@interface ECDeslider : UIControl

@property (assign, nonatomic) CGFloat minValue;
@property (assign, nonatomic) CGFloat maxValue;
@property (assign, nonatomic) CGFloat value1;
@property (assign, nonatomic) CGFloat value2;
@property (assign, nonatomic) CGFloat labelTop;
@property (assign, nonatomic) CGFloat padding;

- (void) setThumb1Image:(UIImage*) image forState:(UIControlState)state;

- (void) setThumb2Image:(UIImage*) image forState:(UIControlState)state;

- (void) setMaxImage:(UIImage*) image forState:(UIControlState)state;

- (void) setThumb1Title:(NSString*) string forState:(UIControlState)state;

- (void) setThumb2Title:(NSString *)string forState:(UIControlState)state;

- (void) setThumb1TitleFont:(UIFont*) font forState:(UIControlState)state;

- (void) setThumb2TitleFont:(UIFont*) font forState:(UIControlState)state;
@end
