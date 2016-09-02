//
//  HeartEmitter.m
//  粒子发散器
//
//  Created by FFFF on 16/9/2.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "HeartEmitter.h"

@interface HeartEmitter ()
@property (nonatomic,assign) NSInteger number ;
@property (nonatomic,strong) UIView *contentView;

@end
@implementation HeartEmitter


+ (instancetype)defaultEmitter{
    static HeartEmitter *heartEmitter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (heartEmitter == nil) {
            heartEmitter = [[HeartEmitter alloc] init];
        }
    });
    
    return heartEmitter;
}

- (instancetype)init{

    if (self = [super init]) {
        
        self.number = 1000;
    }
    return self;
}
- (void)likeAnimation{
    
    self.number+= 1;
    // 创建控件
    UIImage *image = [UIImage imageNamed:[self randomImageName]];
    UIImageView *likeView = [[UIImageView alloc] initWithImage:image];
    likeView.center = CGPointMake(self.contentView.bounds.size.width/2, self.contentView.bounds.size.height + 100);
    likeView.tag =self.number;
    [self.contentView addSubview:likeView];
    
    // 缩放动画 比例转换
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.0;//动画持续时间
    scaleAnimation.removedOnCompletion = NO;
    
    // 缩放比例
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    // 位置动画
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 起点的位置
    int X = self.contentView.bounds.size.width/2;
    int Y = self.contentView.bounds.size.height -100;
    
    CGPathMoveToPoint(path, nil,  X, Y);
    
    int offsetX = (arc4random()%(100+1))-50; //动画X轴偏移位置
    int offsetY = (arc4random()%(130+1))+50;
    
    // 终点
    int endX = offsetX + X;
    int endY = 100;
    CGPathAddQuadCurveToPoint(path, nil, X-offsetX, Y-offsetY, endX,endY);
    
    positionAnimation.path = path;
    CGPathRelease(path);
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards; //设置保存动画的最新状态
    positionAnimation.duration = 2;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; // 动画节奏
    
    // 透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 1.5;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fromValue = [NSNumber numberWithBool:1.0];
    opacityAnimation.toValue = [NSNumber numberWithBool:0.0];
    opacityAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    opacityAnimation.beginTime = 0.5;
    
    // 动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 2;
    group.repeatCount = 1;
    group.animations = @[scaleAnimation,positionAnimation,opacityAnimation];
    group.delegate = self;
    [group setValue:@(self.number) forKey:@"animationName"];
    [likeView.layer addAnimation:group forKey:@"likes"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    for (UIImageView *imageV in self.contentView.subviews) {
        NSInteger index = imageV.tag;
        
        if ([[anim valueForKey:@"animationName"] integerValue] == index) {
            [imageV removeFromSuperview];
        }
    }
}


- (NSString *)randomImageName{
    
    int num = arc4random()%(13+1);
    NSString *randomName = @"";
    randomName = [NSString stringWithFormat:@"heart.bundle/%d",num];

    return randomName;
}


- (void)startFireWithView:(UIView *)view{

    self.contentView = view;
    
    [self likeAnimation];
}




@end
