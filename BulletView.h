//
//  BulletView.h
//  DanMu
//
//  Created by at on 2016/11/25.
//  Copyright © 2016年 at. All rights reserved.
//

#import <UIKit/UIKit.h>

//弹幕的状态
typedef NS_ENUM(NSInteger ,moveState){
    start,
    enter,
    end
};

@interface BulletView : UIView

@property (nonatomic,assign) int trajectory; //弹道

@property (nonatomic,copy) void(^moveStatuBlock)(moveState state);//弹幕状态回调

//初始化弹幕
-(instancetype)initWithComment:(NSString *)comment;

//开始动画
-(void)startAnimation;
//结束动画
-(void)stopAnimation;



@end
