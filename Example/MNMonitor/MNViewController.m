//
//  MNViewController.m
//  MNMonitor
//
//  Created by 刘楠 on 07/17/2018.
//  Copyright (c) 2018 刘楠. All rights reserved.
//

#import "MNViewController.h"
#import "MNMonitorTrackerConfig.h"
#import "MNCPURecorder.h"

@interface MNViewController ()
@property (nonatomic, strong) MNMonitorTrackerConfig *config;
@property (nonatomic, strong) MNCPURecorder *recorder;
@end

@implementation MNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.config = [MNMonitorTrackerConfig configWithCPUConfig:[MNCPUTrackerConfig instanceWithTimeInterval:3.0f completionBlock:^(double currentUsage, BOOL isSucceed) {
        
    }] memConfig:[MNMemoryTrackerConfig instanceWithTimeInterval:2.0 completionBlock:^(double currentUsage, BOOL isSucceed) {
        
    }] runloopConfig:[MNMainRunloopTrackerConfig instanceWithTimeInterval:5.0 completionBlock:^(double currentUsage, BOOL isSucceed) {
        
    }]];
    _recorder = [MNCPURecorder new];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        double useage = [self.recorder currentCPUUsage];
        NSLog(@"cpu usage: %f",useage);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
