//
//  ViewController.m
//  network-status
//
//  Created by 蒋永忠 on 16/6/14.
//  Copyright © 2016年 chinamyo. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong) Reachability *hostReachability;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange) name:kReachabilityChangedNotification object:nil];
}

- (void) networkStatusChange
{

    NetworkStatus netStatus = [self.hostReachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
            self.statusLabel.text = @"无网络连接";
            break;
        case ReachableViaWWAN:
            self.statusLabel.text = @"流量";
            break;
        case ReachableViaWiFi:
            self.statusLabel.text = @"WIFI";
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
