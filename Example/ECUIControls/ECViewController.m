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

    ECVoiceProgressbar *progressbar = [ECVoiceProgressbar progressBarWithBackgroundName:@"progressBg" normalBlockName:@"normalBlock" highlightBlockName:@"highlightBlock"];
    [self.view addSubview:progressbar];
    progressbar.max = 10;
    progressbar.value = 10;
    progressbar.translatesAutoresizingMaskIntoConstraints = NO;
    [progressbar centerInSuperView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
