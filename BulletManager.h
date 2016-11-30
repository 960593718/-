//
//  BulletManager.h
//  DanMu
//
//  Created by at on 2016/11/25.
//  Copyright © 2016年 at. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;

@interface BulletManager : NSObject

@property (nonatomic,copy)void(^generateViewBlock)(BulletView *view);


//弹幕的数据来源
@property(nonatomic,strong)NSMutableArray *datasource;


//弹幕的使用的数组
@property(nonatomic,strong)NSMutableArray *bulletsComments;

//弹幕view的数组
@property(nonatomic,strong)NSMutableArray *bulletsViews;

@property BOOL isStop;



//开始执行
-(void)start;
//停止执行
-(void)stop;


@end
