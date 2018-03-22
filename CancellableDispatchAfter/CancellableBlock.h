//
//  CancellableBlock.h
//  CancellableDispatchAfter
//
//  Created by Anastasia Kononova on 22/03/2018.
//  Copyright © 2018 Anastasia Kononova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancellableBlock : NSObject

@property (nonatomic, assign, readonly) BOOL isCancelled;
@property (nonatomic, strong, readonly, nonnull) dispatch_block_t dispatchBlock;

- (nonnull instancetype)initWithDispatchBlock:(nonnull dispatch_block_t)dispatchBlock releasedBlock:(nullable dispatch_block_t)releaseBlock;
- (void)cancel;

@end
