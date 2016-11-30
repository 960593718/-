//
//  BulletManager.m
//  DanMu
//
//  Created by at on 2016/11/25.
//  Copyright © 2016年 at. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@implementation BulletManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isStop=YES;
    }
    return self;
}

-(void)start{
    
    if (!self.isStop) {
        
        return;
    }
    self.isStop=NO;
    [self.bulletsComments removeAllObjects];
    [self.bulletsComments addObjectsFromArray:self.datasource];
    [self initBulletComment];
    
    
}


-(void)stop{
    if (self.isStop) {
        return;
    }
    self.isStop=YES;
    
    [self.bulletsViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      
        BulletView *view = obj;
        [view stopAnimation];
        view =nil;
        
        
        
    }];
    [self.bulletsViews removeAllObjects];
    
}

//初始化弹幕 随机弹幕的轨迹
-(void)initBulletComment{
    
    NSArray *arry=@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"];
    NSMutableArray *trajectorys =[NSMutableArray arrayWithArray:arry];
    for (int i=0; i<10; i++) {
        
        if (self.bulletsComments.count>0) {
            
            NSLog(@"%lu",(unsigned long)trajectorys.count);
            //取出轨迹
            NSInteger index=arc4random()%trajectorys.count;
            
            int trac=[[trajectorys objectAtIndex:index] intValue];
            //移除轨迹
            [trajectorys removeObjectAtIndex:index];
            
            NSString *comment =[self.bulletsComments firstObject];
            //移除数据源中弹幕
            [self.bulletsComments removeObjectAtIndex:0];
            
            //创建弹幕
            [self createBulletView:comment trajectory:trac];

            
        }
        
    }
    
    
    
}
-(void)createBulletView:(NSString *)comment trajectory:(int)tra{
   
    if (self.isStop) {
        return;
    }
    
    
    BulletView *view=[[BulletView alloc]initWithComment:comment];
    view.trajectory=tra;
    [self.bulletsViews addObject:view];
    __weak typeof(view) weakView =view;
    __weak typeof(self) myself = self;
    
    view.moveStatuBlock=^(moveState state){
        
        if (self.isStop) {
            return;
        }
        
        switch (state) {
            case start:
            {
                //弹幕开始进入屏幕，将view加入bulletviews
                [myself.bulletsViews addObject:weakView];
                
                
                break;
            }
            case enter:
            {
                //弹幕完全进入屏幕 判断是否还有其他的内容，如果有在轨迹中创建
                
                NSString *comment =[myself nextComment];
                NSLog(@"comment===%@",comment);
                if (comment) {
                    
                    [myself createBulletView:comment trajectory:tra];
                }
                
                
                
                break;
            }
            case end:
            {
                //弹幕飞出屏幕后 从views中删除 释放资源
                if ([self.bulletsViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [myself.bulletsViews removeObject:weakView];
                    
                }
                if (myself.bulletsViews.count==0) {
                    //屏幕上没有弹幕时，开始循环滚动
                    self.isStop=YES;
                    
                    [myself start];
                    
                }
                
                
                break;
            }
            default:
                break;
        }
        
        
        
        
//    //移除屏幕后销毁弹幕和释放资源
//        
//        [weakView stopAnimation];
//    
//        [myself.bulletsViews removeObject:weakView];
    
    };
    
    //回调viewcontroller函数 ，添加到视图上
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
    
    
}

-(NSString *)nextComment{
    
    if (self.bulletsComments.count==0) {
        
        return nil;
    }
    
    NSString *comment=[self.bulletsComments firstObject];
    
    if (comment) {
        [self.bulletsComments removeObjectAtIndex:0];
    }
    return comment;
    
}



-(NSMutableArray *)datasource{
    
    if (!_datasource) {
        _datasource =[NSMutableArray arrayWithArray:@[@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111",@"弹幕6一11111111",@"弹幕5一1118w8787878711111",@"弹sadaslas幕7一11111111",@"弹幕dsd4一11111111",@"弹幕3一111dfs,djhjsnaj11111",@"弹幕2一111sadas11111",@"弹幕9一111dfsdfsd11111",@"弹幕8dd一11111111"]];
    }
    return _datasource;
    
}

-(NSMutableArray *)bulletsComments{
    
    if (!_bulletsComments) {
        _bulletsComments =[NSMutableArray array];
    }
    return _bulletsComments;
    
}
-(NSMutableArray *)bulletsViews{
    
    if (!_bulletsViews) {
        _bulletsViews =[NSMutableArray array];
    }
    return _bulletsViews;
    
}

@end
