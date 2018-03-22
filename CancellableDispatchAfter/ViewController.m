//
//  ViewController.m
//  CancellableDispatchAfter
//
//  Created by Anastasia Kononova on 22/03/2018.
//  Copyright © 2018 Anastasia Kononova. All rights reserved.
//

#import "ViewController.h"
#import "CancellableBlock.h"
#import "cancellable_dispatch_after.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CancellableBlock *block = [[CancellableBlock alloc] initWithDispatchBlock:^{
        NSLog(@"Call dispatch block");
    } releasedBlock:^{
        NSLog(@"Release resources");
    }];

    cancellable_dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
    sleep(1);
    [block cancel];
}

@end
