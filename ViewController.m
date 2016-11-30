//
//  ViewController.m
//  DanMu
//
//  Created by at on 2016/11/25.
//  Copyright © 2016年 at. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"

@interface ViewController ()

@property (nonatomic,strong)BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化管理类
    self.manager =[[BulletManager alloc]init];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor redColor];
    button.frame=CGRectMake(20, 100, 200, 30);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor=[UIColor redColor];
    button2.frame=CGRectMake(230, 100, 200, 30);
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    
  
    __weak typeof(self) weskself= self;
    self.manager.generateViewBlock=^(BulletView *view){
        
        [weskself addView:view];
        
        
    };
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnClick{
    
    [self.manager start];
    
    
    
}
-(void)btnClick2{
    
    [self.manager stop];
    
    
    
}

-(void)addView:(BulletView*)view{
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    //弹幕的位置 y代表显示的高度
    view.frame =CGRectMake(width, view.trajectory*40, view.frame.size.width, view.frame.size.height);
    if (view.trajectory*40+view.frame.size.height<=self.view.frame.size.height) {
        [self.view addSubview:view];
    }
    
   
    
    [view startAnimation];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
