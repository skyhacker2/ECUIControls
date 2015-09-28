//
//  ECRangeSlider.h
//  Pods
//
//  Created by Eleven Chen on 15/9/28.
//
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface ECRangeSlider : UIControl
/// 最小值
@property (assign, nonatomic) IBInspectable float minValue;
/// 最大值
@property (assign, nonatomic) IBInspectable float maxValue;
/// 最小值和最大值之间的距离
@property (assign, nonatomic) IBInspectable float minRange;
/// 较低的值
@property (assign, nonatomic) IBInspectable float lowerValue;
/// 较高的值
@property (assign, nonatomic) IBInspectable float upperValue;
/// Track图片距离两边的距离
@property (assign, nonatomic) IBInspectable float trackPadding;

@property (assign, nonatomic) IBInspectable UIImage* lowerImage;

@property (assign, nonatomic) IBInspectable UIImage* upperImage;

@property (assign, nonatomic) IBInspectable UIImage* trackImage;

@property (readonly, nonatomic) CGPoint lowerCenter;
@property (readonly, nonatomic) CGPoint upperCenter;
@end
