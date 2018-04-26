//
//  WSViewController.m
//  PracticeCollectionView
//
//  Created by wangshanshan on 2018/4/26.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSViewController.h"

@interface WSViewController ()

@end

@implementation WSViewController

-(instancetype)init{
    if (self = [super init]) {
        NSLog(@"创建类-%@",NSStringFromClass([self class]));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"收到内存警告");
}

-(void)dealloc{
    NSLog(@"释放类-%@",NSStringFromClass([self class]));
}


@end
