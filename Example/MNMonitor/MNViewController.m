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
#import "MNMonitorTracker.h"

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
        NSLog(@"current cpu usage:%f",currentUsage);
    }] memConfig:[MNMemoryTrackerConfig instanceWithTimeInterval:2.0 completionBlock:^(double currentUsage, BOOL isSucceed) {
        
    }] runloopConfig:[MNMainRunloopTrackerConfig instanceWithTimeInterval:5.0 completionBlock:^(double currentUsage, BOOL isSucceed) {
        
    }]];
    
    [[MNMonitorTracker sharedTracker] startWithConfig:self.config];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
