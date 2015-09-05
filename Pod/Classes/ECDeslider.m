//
//  ECDeslider.m
//  Pods
//
//  Created by Eleven Chen on 15/9/1.
//
//

#import "ECDeslider.h"
#import "ECExtension.h"

@interface ECDeslider()
@property (strong, nonatomic) UIImage* thumb1Normal;
@property (strong, nonatomic) UIImage* thumb1Selected;
@property (strong, nonatomic) UIImage* thumb2Normal;
@property (strong, nonatomic) UIImage* thumb2Selected;
@property (strong, nonatomic) UIImage* maxImageNormal;
@property (strong, nonatomic) UIImage* maxImageSelected;
@property (copy, nonatomic) NSString* thumb1TitleNormal;
@property (copy, nonatomic) NSString* thumb2TitleNormal;
@property (copy, nonatomic) UIFont* thumb1TitleFontNormal;
@property (copy, nonatomic) UIFont* thumb2TitleFontNormal;

@property (strong, nonatomic) UIImageView* thumb1View;
@property (strong, nonatomic) UIImageView* thumb2View;
@property (strong, nonatomic) UIImageView* maxImageView;
@property (strong, nonatomic) UILabel* thumb1Label;
@property (strong, nonatomic) UILabel* thumb2Label;

@property (strong, nonatomic) NSLayoutConstraint *thumb1Left;
@property (strong, nonatomic) NSLayoutConstraint *thumb2Right;
@property (strong, nonatomic) NSLayoutConstraint *label1Top;
@property (strong, nonatomic) NSLayoutConstraint *label2Top;

@property (assign, nonatomic) BOOL thumb1Touched;
@property (assign, nonatomic) BOOL thumb2Touched;
@property (assign, nonatomic) CGPoint touchPoint;
@end

@implementation ECDeslider

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.minValue = 0.0;
        self.maxValue = 1.0;
        self.value1 = 0;
        self.value2 = 1;
        self.padding = 10;
    }
    return self;
}

- (NSLayoutConstraint*) thumb1Left
{
    if (!_thumb1Left) {
        _thumb1Left = [NSLayoutConstraint constraintWithItem:self.thumb1View
                                                   attribute:NSLayoutAttributeLeading
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeLeft
                                                  multiplier:1
                                                    constant:0];
    }
    return _thumb1Left;
}

- (NSLayoutConstraint*) thumb2Right
{
    if (!_thumb2Right) {
        _thumb2Right = [NSLayoutConstraint constraintWithItem:self.thumb2View
                                                    attribute:NSLayoutAttributeTrailing
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                    attribute:NSLayoutAttributeRight
                                                   multiplier:1
                                                     constant:0];
    }
    return _thumb2Right;
}

- (UIImageView*) maxImageView
{
    if (!_maxImageView) {
        _maxImageView = [[UIImageView alloc] init];
        [self addSubview:_maxImageView];
        _maxImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_maxImageView layoutMatchSuperView];
    }
    return _maxImageView;
}

- (UIImageView*) thumb1View
{
    if (!_thumb1View) {
        _thumb1View = [[UIImageView alloc] init];
        [self addSubview:_thumb1View];
        _thumb1View.translatesAutoresizingMaskIntoConstraints = NO;
        [_thumb1View centerYTo:self.maxImageView];
        [self addConstraint:self.thumb1Left];
    }
    return _thumb1View;
}

- (UIImageView*) thumb2View
{
    if (!_thumb2View) {
        _thumb2View = [[UIImageView alloc] init];
        [self addSubview:self.thumb2View];
        _thumb2View.translatesAutoresizingMaskIntoConstraints = NO;
        [_thumb2View centerYTo:self.maxImageView];
        [self addConstraint:self.thumb2Right];
    }
    return _thumb2View;
}

- (UILabel*) thumb1Label
{
    if (!_thumb1Label && self.thumb1View) {
        _thumb1Label = [[UILabel alloc] init];
        _thumb1Label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_thumb1Label];
        _thumb1Label.translatesAutoresizingMaskIntoConstraints = NO;
        [_thumb1Label centerXTo:self.thumb1View];
        self.label1Top = [NSLayoutConstraint constraintWithItem:_thumb1Label
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.thumb1View
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:0];
        [self addConstraint:self.label1Top];
    }
    return _thumb1Label;
}

- (UILabel*) thumb2Label
{
    if (!_thumb2Label && self.thumb2View) {
        _thumb2Label = [[UILabel alloc] init];
        _thumb2Label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_thumb2Label];
        _thumb2Label.translatesAutoresizingMaskIntoConstraints = NO;
        [_thumb2Label centerXTo:self.thumb2View];
        self.label2Top = [NSLayoutConstraint constraintWithItem:_thumb2Label
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.thumb2View
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:0];
        [self addConstraint:self.label2Top];
    }
    return _thumb2Label;
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    if (!self.maxImageNormal) {
        return;
    }
    if (self.maxImageNormal) {
        self.maxImageView.image = self.maxImageNormal;
        
    }
    if (self.thumb1Normal) {
        self.thumb1View.image = self.thumb1Normal;
        if (self.thumb1TitleNormal) {
            self.thumb1Label.text = self.thumb1TitleNormal;
            self.label1Top.constant = -self.labelTop;
            if (self.thumb1TitleFontNormal) {
                self.thumb1Label.font = self.thumb1TitleFontNormal;
            }
        }
        //NSLog(@"value %f", self.value1);
        CGFloat x = (self.value1 / (self.maxValue - self.minValue)) * [self len] + self.padding;
        //NSLog(@"%f", x);
        self.thumb1Left.constant = x - [self.thumb1View systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width/2;
    }
    if (self.thumb2Normal) {
        self.thumb2View.image = self.thumb2Normal;
        if (self.thumb2TitleNormal) {
            self.thumb2Label.text = self.thumb2TitleNormal;
            self.label2Top.constant = -self.labelTop;
            if (self.thumb2TitleFontNormal) {
                self.thumb2Label.font = self.thumb2TitleFontNormal;
            }
        }
        CGFloat x = (self.value2 / (self.maxValue - self.minValue)) * (self.frame.size.width - 2*self.padding) + self.padding;
        x = self.frame.size.width - x;
        
        self.thumb2Right.constant = - (x - [self.thumb2View systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width/2);
    }
    

}


- (CGSize) intrinsicContentSize
{
    if (self.maxImageNormal) {
        return CGSizeMake(20, self.maxImageNormal.size.height);
    }
    return CGSizeMake(20, 20);
}

#pragma mark - control logic

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    if (self.thumb1View) {
        if (CGRectContainsPoint(self.thumb1View.frame, point)) {
            self.thumb1Touched = YES;
            return YES;
        }
    }
    if (self.thumb2View) {
        if (CGRectContainsPoint(self.thumb2View.frame, point)) {
            self.thumb2Touched = YES;
            return YES;
        }
    }
    self.touchPoint = point;
    return NO;
}

- (CGFloat) len
{
    return self.frame.size.width - self.padding*2;
}

- (CGFloat) minBetweenValue
{
    CGFloat dis = self.thumb1View.frame.size.width/2 + self.thumb2View.frame.size.width/2;
    return dis / [self len] * (self.maxValue - self.minValue);
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];

    //NSLog(@"point %f", point.x);
    if (self.thumb1Touched) {
        //if (point.x < self.thumb2View.frame.origin.x) {
            //NSLog(@"%f", point.x + self.thumb1View.frame.size.width/2);
//            NSLog(@"view2 %f", self.thumb2View.frame.origin.x);
            CGFloat value1 = point.x - self.padding;
            if (value1 < 0) {
                value1 = 0;
            }
            value1 = (value1-self.padding) / [self len] * (self.maxValue - self.minValue);
            if (value1 < 0) {
                value1 = 0;
            }
            self.value1 = value1;
            if (self.value1 > self.value2 - [self minBetweenValue]) {
                self.value1 = self.value2 - [self minBetweenValue];
            }
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            [self setNeedsUpdateConstraints];
        //}
    }
    if (self.thumb2Touched) {
        //if (point.x - self.thumb2View.frame.size.width/2 > self.thumb1View.frame.origin.x + self.thumb1View.frame.size.width) {
            CGFloat value2 = point.x;
            if (value2 > self.frame.size.width - self.padding) {
                value2 = self.frame.size.width - self.padding;
//                NSLog(@"value2 %f", value2);
            }
            
//            NSLog(@"width %f", self.frame.size.width);
            self.value2 = (value2-self.padding) / [self len] * (self.maxValue - self.minValue);
        if (self.value2 < self.value1 + [self minBetweenValue]) {
            self.value2 = self.value1 + [self minBetweenValue];
        }
            //NSLog(@"value2 %f", self.value2);
            //self.value2 = (value2 / self.frame.size.width) * (self.maxValue - self.minValue);
            [self setNeedsUpdateConstraints];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        //}
    }
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.thumb1Touched = NO;
    self.thumb2Touched = NO;
}

#pragma mark - public methods
- (void) setThumb1Image:(UIImage*) image forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.thumb1Normal = image;
    } else if (state == UIControlStateSelected) {
        self.thumb1Selected = image;
    }
    [self setNeedsLayout];
}

- (void) setThumb2Image:(UIImage*) image forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.thumb2Normal = image;
    } else if (state == UIControlStateSelected) {
        self.thumb2Selected = image;
    }
    [self setNeedsLayout];
}

- (void) setMaxImage:(UIImage*) image forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.maxImageNormal = image;
    } else if (state == UIControlStateSelected) {
        self.maxImageSelected = image;
    }
    [self setNeedsLayout];
}

- (void) setThumb1Title:(NSString*) string forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.thumb1TitleNormal = string;
    }
    [self setNeedsLayout];
}

- (void) setThumb2Title:(NSString *)string forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.thumb2TitleNormal = string;
    }
    [self setNeedsLayout];
}

- (void) setThumb1TitleFont:(UIFont*) font forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.thumb1TitleFontNormal = font;
    }
    [self setNeedsLayout];
}

- (void) setThumb2TitleFont:(UIFont*) font forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        self.thumb2TitleFontNormal = font;
    }
    [self setNeedsLayout];
}

- (void) setValue1:(CGFloat)value1
{
    _value1 = value1;
    [self setNeedsLayout];
}

- (void) setValue2:(CGFloat)value2
{
    _value2 = value2;
    [self setNeedsLayout];
}

- (void) setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    [self setNeedsLayout];
}

- (void) setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    [self setNeedsLayout];
}

- (void) setLabelTop:(CGFloat)labelTop
{
    _labelTop = labelTop;
    [self setNeedsLayout];
}

@end
