//
//  HeartEmitter.h
//  粒子发散器
//
//  Created by FFFF on 16/9/2.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeartEmitter : NSObject
+ (instancetype)defaultEmitter;

- (void)startFireWithView:(UIView *)view;
@end
