//
//  ECVoiceProgressbar.m
//  Pods
//
//  Created by Eleven Chen on 15/8/10.
//
//

#import "ECVoiceProgressbar.h"

@interface ECVoiceProgressbar()

@property (strong, nonatomic) UIImageView* backgroudView;
@property (strong, nonatomic) NSMutableArray* normalViews;
@property (strong, nonatomic) NSMutableArray* highlightViews;

@end

@implementation ECVoiceProgressbar

- (NSMutableArray*) normalViews
{
    if (!_normalViews) {
        _normalViews = [[NSMutableArray alloc] init];
    }
    return _normalViews;
}


- (NSMutableArray*) highlightViews
{
    if (!_highlightViews) {
        _highlightViews = [[NSMutableArray alloc] init];
    }
    return _highlightViews;
}

- (void) setValue:(NSInteger)value
{
    if (value > self.max) {
        return;
    }
    _value = value;
    [self setNeedsLayout];
}

- (void) setMax:(NSInteger)max
{
    _max = max;
    [self setNeedsLayout];
}

+ (ECVoiceProgressbar*) progressBarWithBackground:(UIImage *)bg normalBlock:(UIImage *)normalBlock highlightBlock:(UIImage *)highlightBlock
{
    return [[ECVoiceProgressbar alloc] initWithBackground:bg normalBlock:normalBlock highlightBlock:highlightBlock];
}

+ (ECVoiceProgressbar*) progressBarWithBackgroundName:(NSString *)bg normalBlockName:(NSString *)normalBlock highlightBlockName:(NSString *)highlightBlock
{
    UIImage* bgImage = [UIImage imageNamed:bg];
    UIImage* normalImage = [UIImage imageNamed:normalBlock];
    UIImage* highlightImage = [UIImage imageNamed:highlightBlock];
    return [ECVoiceProgressbar progressBarWithBackground:bgImage normalBlock:normalImage highlightBlock:highlightImage];
}

- (instancetype) initWithBackground:(UIImage *)bg normalBlock:(UIImage *)normalBlock highlightBlock:(UIImage *)highlightBlock
{
    self = [super init];
    
    self.background = bg;
    self.normalBlock = normalBlock;
    self.highlightBlock = highlightBlock;
    
    self.backgroudView = [[UIImageView alloc] initWithImage:self.background];
    CGRect rect = self.backgroudView.frame;
    rect.size = self.background.size;
    self.backgroudView.frame = rect;
    [self addSubview:self.backgroudView];
    
    self.max = 1;
    
    [self setNeedsLayout];
    
    return self;
}

- (CGSize) intrinsicContentSize
{
    return self.backgroudView.bounds.size;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGFloat wOffset = (self.backgroudView.bounds.size.width - self.normalBlock.size.width * self.max) / (self.max+1);
    CGFloat hOffset = (self.backgroudView.bounds.size.height - self.normalBlock.size.height) / 2;
    CGFloat x = wOffset;
    CGFloat y = hOffset;
    [self.backgroudView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.normalViews removeAllObjects];
    [self.highlightViews removeAllObjects];
    for (int i = 0; i < self.max; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:self.normalBlock];
        CGRect frame = imageView.frame;
        frame.origin = CGPointMake(x, y);
        imageView.frame = frame;
        [self.normalViews addObject:imageView];
        [self.backgroudView addSubview:imageView];
        x += wOffset + self.normalBlock.size.width;
    }
    
    x = wOffset;
    y = hOffset;
    for (int i = 0; i < self.value; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:self.highlightBlock];
        CGRect frame = imageView.frame;
        frame.origin = CGPointMake(x, y);
        imageView.frame = frame;
        [self.highlightViews addObject:imageView];
        [self.backgroudView addSubview:imageView];
        x += wOffset + self.highlightBlock.size.width;
    }

}

@end
