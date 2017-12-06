//
//  ViewController.m
//  OutPlayer
//
//  Created by xl on 2017/12/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *hello = NSLocalizedString(@"hello", nil);
    NSString *number = @"10";
    NSString *str = [NSString stringWithFormat:NSLocalizedString(@"Yesterday you sold %@ apps", nil), number];
    NSLog(@"%@====%@",hello,str);
}


@end
