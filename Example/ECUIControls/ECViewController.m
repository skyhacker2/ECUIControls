//
//  ECViewController.m
//  ECUIControls
//
//  Created by Eleven Chen on 08/11/2015.
//  Copyright (c) 2015 Eleven Chen. All rights reserved.
//

#import "ECViewController.h"
#import <ECUIControls/ECUIControls.h>
#import "ECExtension.h"

@interface ECViewController ()

@end

@implementation ECViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDeslider];
}

- (void) setupProgressbar
{
    ECVoiceProgressbar *progressbar = [ECVoiceProgressbar progressBarWithBackgroundName:@"progressBg" normalBlockName:@"normalBlock" highlightBlockName:@"highlightBlock"];
    [self.view addSubview:progressbar];
    progressbar.max = 10;
    progressbar.value = 10;
    progressbar.translatesAutoresizingMaskIntoConstraints = NO;
    [progressbar centerInSuperView];

}

- (void) setupDeslider
{
    ECDeslider* deslider = [[ECDeslider alloc] init];
    [deslider setMaxImage:[UIImage imageNamed:@"SliderBg"] forState:UIControlStateNormal];
    [deslider setThumb1Image:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    [deslider setThumb2Image:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    [deslider setThumb1Title:@"start" forState:UIControlStateNormal];
    [deslider setThumb2Title:@"stop" forState:UIControlStateNormal];
    deslider.labelTop = 0;
    deslider.maxValue = 1440;
    deslider.value1 = 10;
    deslider.value2 = 1440;
    [deslider setThumb1TitleFont:[UIFont boldSystemFontOfSize:20] forState:UIControlStateNormal];
    [self.view addSubview:deslider];
    deslider.translatesAutoresizingMaskIntoConstraints = NO;
    [deslider centerInSuperView];
    [deslider layoutMarginLeftSuperView:10];
    [deslider layoutMarginRightSuperView:10];
    
    [deslider addTarget:self action:@selector(onSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) onSliderValueChanged:(ECDeslider*) sender
{
    NSLog(@"value1 %f", sender.value1);
    NSLog(@"value2 %f", sender.value2);
    int hour = (int)(sender.value1 / 60.0f);
    int minute = (int)sender.value1 % 60;
    NSLog(@"%d, %d", hour, minute);
}
@end
