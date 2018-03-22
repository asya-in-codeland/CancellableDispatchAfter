//
//  cancellable_dispatch_after.h
//  CancellableDispatchAfter
//
//  Created by Anastasia Kononova on 22/03/2018.
//  Copyright © 2018 Anastasia Kononova. All rights reserved.
//

#ifndef cancellable_dispatch_after_h
#define cancellable_dispatch_after_h

#import "CancellableBlock.h"

void cancellable_dispatch_after(dispatch_time_t when, dispatch_queue_t queue, CancellableBlock *block) {
    dispatch_after(when, queue, ^{
        if (!block.isCancelled) {
            block.dispatchBlock();
        }
    });
}

#endif /* cancellable_dispatch_after_h */
