//
//  NSObject+PBHelper.h
//  NHUtilSetsPro
//
//  Created by nanhu on 2016/12/13.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PBHelper)

/**
 measure the block's excute time ms

 @param block :the block
 */
- (void)pb_measureBlock:(void (^)(void))block;

NS_ASSUME_NONNULL_END

@end
