//
//  WSRootViewController.m
//  PracticeCollectionView
//
//  Created by wangshanshan on 2018/4/26.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSRootViewController.h"

#define cellIndentifier @"UITableViewCell"

@interface WSRootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation WSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"CollectionView";
    
    _dataArray = @[
                   @{@"className":@"WSWaterFallViewController",@"title":@"瀑布流"},
                   @{@"className":@"WSHorizantalSlipViewController",@"title":@"水平滑动"},
                   ];
    
    [self setupTableView];
    
}

-(void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndentifier];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *title = dic[@"title"];
    NSString *className = dic[@"className"];
    Class cls = NSClassFromString(className);
    
    UIViewController *vc = [[cls alloc]init];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
