//
//  CancellableBlock.m
//  CancellableDispatchAfter
//
//  Created by Anastasia Kononova on 22/03/2018.
//  Copyright © 2018 Anastasia Kononova. All rights reserved.
//

#import "CancellableBlock.h"

@implementation CancellableBlock {
    dispatch_queue_t _serialQueue;
    dispatch_block_t _dispatchBlock;
    dispatch_block_t _releaseBlock;
    BOOL _isCancelled;
}

- (instancetype)initWithDispatchBlock:(dispatch_block_t)dispatchBlock releasedBlock:(dispatch_block_t)releaseBlock
{
    self = [super init];
    if (self != nil) {
        _dispatchBlock = dispatchBlock;
        _releaseBlock = releaseBlock;
        _serialQueue = dispatch_queue_create("com.cancellable.dispatch.after.serial.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cancel
{
    __weak typeof(self) wself = self;
    dispatch_async(_serialQueue, ^{
        __strong typeof(wself) sself = wself;
        if (sself == nil) { return; }

        sself->_isCancelled = YES;
        if (sself->_releaseBlock != nil) {
            sself->_releaseBlock();
        }
    });
}

- (BOOL)isCancelled
{
    __block BOOL localCancelled;
    dispatch_sync(_serialQueue, ^{
        localCancelled = _isCancelled;
    });
    return localCancelled;
}

@end
