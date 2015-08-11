//
//  ECVoiceProgressbar.h
//  Pods
//
//  Created by Eleven Chen on 15/8/10.
//
//

#import <UIKit/UIKit.h>

@interface ECVoiceProgressbar : UIControl

@property (nonatomic, strong) UIImage* background;
@property (nonatomic, strong) UIImage* normalBlock;
@property (nonatomic, strong) UIImage* highlightBlock;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger value;

+ (ECVoiceProgressbar*) progressBarWithBackground: (UIImage*) bg normalBlock:(UIImage*) normalBlock highlightBlock: (UIImage*) highlightBlock;

+ (ECVoiceProgressbar*) progressBarWithBackgroundName:(NSString *)bg normalBlockName:(NSString *)normalBlock highlightBlockName:(NSString *)highlightBlock;

@end
