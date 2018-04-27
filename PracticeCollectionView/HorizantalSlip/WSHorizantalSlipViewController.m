//
//  WSHorizantalSlipViewController.m
//  PracticeCollectionView
//
//  Created by wangshanshan on 2018/4/26.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSHorizantalSlipViewController.h"
#import "WSHorizantalSlipLayout.h"
#import "WSHorizantalSlipCollectionViewCell.h"

#define KWSHORIZANTALSLIPCELLIDENTIFIER @"WSHorizantalSlipCollectionViewCell"

@interface WSHorizantalSlipViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation WSHorizantalSlipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor redColor];
    attributes[NSUnderlineStyleAttributeName] = @YES;
    
    NSAttributedString *str1 = [[NSAttributedString alloc]initWithString:@"我是AttributText\n哈哈hahahhahaha" attributes:attributes];
    _dataArray = @[str1,@"1",@"2",@"3",@"4",@"1",@"2"];
    
    [self setupCollectionViewUI];
}

-(void)setupCollectionViewUI{
    WSHorizantalSlipLayout *layout = [[WSHorizantalSlipLayout alloc]init];
    //设置item大小
//    layout.collectItemSize = CGSizeMake(230, 400);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:KWSHORIZANTALSLIPCELLIDENTIFIER bundle:nil] forCellWithReuseIdentifier:KWSHORIZANTALSLIPCELLIDENTIFIER];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);

    }];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WSHorizantalSlipCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KWSHORIZANTALSLIPCELLIDENTIFIER forIndexPath:indexPath];
    id str = self.dataArray[indexPath.item];
    NSLog(@"%@",str);
    if ([str isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString *text = (NSAttributedString *)str;
            cell.titleLabek.attributedText = text;
    }else{
        cell.titleLabek.text = str;
    }
    return cell;
}


@end
