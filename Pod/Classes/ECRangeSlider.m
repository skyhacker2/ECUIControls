//
//  ECRangeSlider.m
//  Pods
//
//  Created by Eleven Chen on 15/9/28.
//
//

#import "ECRangeSlider.h"

@interface ECRangeSlider()
@property (strong, nonatomic) UIImageView* trackImageView;
@property (strong, nonatomic) UIImageView* lowerImageView;
@property (strong, nonatomic) UIImageView* upperImageView;
@property (assign, nonatomic) float lowerTouchOffset;
@property (assign, nonatomic) float upperTouchOffset;
@end

@implementation ECRangeSlider

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
    self.trackImageView = [[UIImageView alloc] init];
    [self addSubview:self.trackImageView];
    self.lowerImageView = [[UIImageView alloc] init];
    [self addSubview:self.lowerImageView];
    self.upperImageView = [[UIImageView alloc] init];
    [self addSubview:self.upperImageView];
    
    self.minValue = 0.0f;
    self.maxValue = 1.0f;
    self.lowerValue = 0.0f;
    self.upperValue = 1.0f;
    self.minRange = 0.0f;
}

/// 背景的矩形
- (CGRect) trackRect
{
    CGRect rect;
    rect.size = CGSizeMake(self.bounds.size.width - 2 * self.trackPadding, self.trackImage.size.height);
    rect.origin = CGPointMake(self.trackPadding, self.bounds.size.height/2 - rect.size.height/2);
    return rect;
}

/// 获取Thumb的矩形
- (CGRect) thumbRectForValue: (float) value image:(UIImage*) image
{
    CGRect thumbRect;
    UIEdgeInsets insets = image.capInsets;
    thumbRect.size = CGSizeMake(image.size.width, image.size.height);
    if (insets.top || insets.bottom) {
        thumbRect.size.height = self.bounds.size.height;
    }
    float xValue = (self.bounds.size.width - thumbRect.size.width) * ((value - self.minValue) / (self.maxValue - self.minValue));
    thumbRect.origin = CGPointMake(xValue, self.bounds.size.height/2 - thumbRect.size.height/2);
    
    return CGRectIntegral(thumbRect);
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    // 设置背景的位置
    if (self.trackImage) {
        self.trackImageView.image = self.trackImage;
        self.trackImageView.frame = [self trackRect];
    }
    if (self.lowerImage) {
        self.lowerImageView.image = self.lowerImage;
        self.lowerImageView.frame = [self thumbRectForValue:self.lowerValue image:self.lowerImage];
    }
    if (self.upperImage) {
        self.upperImageView.image = self.upperImage;
        self.upperImageView.frame = [self thumbRectForValue:self.upperValue image:self.upperImage];
    }

}

- (CGSize) intrinsicContentSize
{
    if (self.lowerImage || self.upperImage) {
        return CGSizeMake(UIViewNoIntrinsicMetric, MAX(self.lowerImage.size.height, self.upperImage.size.height));
    } else {
        return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
    }
}
/// 根据x坐标返回lowerThumb的值
- (float) lowerValueForCenterX:(float) x
{
    float padding = self.lowerImageView.frame.size.width/2;
    float value = self.minValue + (x - padding) / (self.frame.size.width - (padding*2)) * (self.maxValue - self.minValue);
    value = MAX(value, self.minValue);
    value = MIN(value, self.upperValue - self.minRange);
    
    return value;
}

- (float) upperValueForCenterX:(float) x
{
    float padding = self.upperImageView.frame.size.width/2;
    float value = self.minValue + (x - padding) / (self.frame.size.width - (padding*2)) * (self.maxValue - self.minValue);
    value = MIN(value, self.maxValue);
    value = MAX(value, self.lowerValue + self.minRange);
    
    return value;
}

#pragma mark - getter / setter
- (void) setTrackImage:(UIImage *)trackImage
{
    _trackImage = trackImage;
    self.trackImageView.image = _trackImage;
    [self setNeedsLayout];
}

- (void) setLowerImage:(UIImage *)lowerImage
{
    _lowerImage =lowerImage;
    self.lowerImageView.image = _lowerImage;
    [self setNeedsLayout];
}

- (void) setUpperImage:(UIImage *)upperImage
{
    _upperImage = upperImage;
    self.upperImageView.image = _upperImage;
    [self setNeedsLayout];
}

- (void) setMinValue:(float)minValue
{
    _minValue = minValue;
    [self setNeedsLayout];
}

- (void) setMaxValue:(float)maxValue
{
    _maxValue = maxValue;
    [self setNeedsLayout];
}

- (void) setLowerValue:(float)lowerValue
{
    _lowerValue = lowerValue;
    [self setNeedsLayout];
}

- (void) setUpperValue:(float)upperValue
{
    _upperValue = upperValue;
    [self setNeedsLayout];
}

- (CGPoint) lowerCenter
{
    return self.lowerImageView.center;
}

- (CGPoint) upperCenter
{
    return self.upperImageView.center;
}


#pragma mark - Touch Handle
- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    
    /// 两个Thumb有可能重叠在一起
    if (CGRectContainsPoint(self.lowerImageView.frame, touchPoint)) {
        self.lowerImageView.highlighted = YES;
        self.lowerTouchOffset = touchPoint.x - self.lowerImageView.center.x;
    }
    
    if (CGRectContainsPoint(self.upperImageView.frame, touchPoint)) {
        self.upperImageView.highlighted = YES;
        self.upperTouchOffset = touchPoint.x - self.upperImageView.center.x;
    }
    
    return YES;
    
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!self.upperImageView.highlighted && !self.lowerImageView.highlighted) {
        return YES;
    }
    
    CGPoint touchPoint = [touch locationInView:self];
    
    /// 较低的thumb处于点击状态
    if (self.lowerImageView.highlighted) {
        float newValue = [self lowerValueForCenterX:(touchPoint.x - self.lowerTouchOffset)];
        // 如果点击了upper而且是往右边移动的话，说明应该是移动upper
        if (!self.upperImageView.highlighted || newValue < self.lowerValue) {
            self.upperImageView.highlighted = NO;
            [self bringSubviewToFront:self.lowerImageView];
            self.lowerValue = newValue;
        } else {
            self.lowerImageView.highlighted = NO;
        }
    }
    
    if (self.upperImageView.highlighted) {
        float newValue = [self upperValueForCenterX:(touchPoint.x - self.upperTouchOffset)];
        if (!self.lowerImageView.highlighted || newValue > self.upperValue) {
            self.lowerImageView.highlighted = NO;
            [self bringSubviewToFront:self.upperImageView];
            self.upperValue = newValue;
        } else {
            self.upperImageView.highlighted = NO;
        }
    }
    [self setNeedsLayout];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;

}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.lowerImageView.highlighted = NO;
    self.upperImageView.highlighted = NO;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
