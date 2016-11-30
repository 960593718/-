//
//  BulletView.m
//  DanMu
//
//  Created by at on 2016/11/25.
//  Copyright © 2016年 at. All rights reserved.
//

#import "BulletView.h"


@interface BulletView ()


@property (nonatomic,strong )UILabel *lbComment;

@end


@implementation BulletView

//弹幕初始化
-(instancetype)initWithComment:(NSString *)comment{
    if (self = [super init]) {
        //计算弹幕的实际宽度
        NSDictionary *att=@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width =[comment sizeWithAttributes:att].width;
        self.backgroundColor =[UIColor lightGrayColor];
        self.bounds =CGRectMake(0, 0, width +20, 30);
        self.lbComment.text =comment;
        
        self.lbComment.frame =CGRectMake(10, 0, width , 30);
        
    }
    
    return self;
    
}

//开始动画
-(void)startAnimation{
    
    CGFloat screenwidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat duration = 4.0;
    
    CGFloat wholeWidth =screenwidth+ CGRectGetWidth(self.bounds);
    __block CGRect frame = self.frame;
    
    //弹幕开始回调
    
    if (self.moveStatuBlock) {
        
        self.moveStatuBlock(start);
    }
    
    
    //计算速度
    CGFloat speed = wholeWidth /duration;
    CGFloat entime =CGRectGetWidth(self.bounds)/speed;
    //弹幕进入屏幕回调
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:entime];
    
    //取消延迟执行
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //动画效果
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x-=wholeWidth;
        self.frame=frame;
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //弹幕走出屏幕回调
        if (self.moveStatuBlock) {
            self.moveStatuBlock(end);
        }
        
        
        
        
    }];
    
    
    
}
//进入屏幕回调
-(void)enterScreen{
    
    if (self.moveStatuBlock) {
        
        self.moveStatuBlock(enter);
    }
    
    
}


//结束动画
-(void)stopAnimation{
    //移除所有动画效果和控件
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
    //取消延迟执行事件
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

-(UILabel*)lbComment{
    
    if (!_lbComment) {
        
        _lbComment =[[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font=[UIFont systemFontOfSize:14];
        _lbComment.textColor =[UIColor whiteColor];
        _lbComment.textAlignment= NSTextAlignmentCenter;
        [self addSubview:_lbComment];
        
        
    }
    
    return _lbComment;
    
}

@end
