//
//  WSWaterFallViewController.m
//  PracticeCollectionView
//
//  Created by wangshanshan on 2018/4/26.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSWaterFallViewController.h"
#import "WSCollectionViewCell.h"
#import "WSWaterFallLayout.h"
#import "WSGoods.h"
static NSString *identifier = @"WSCollectionViewCell";

@interface WSWaterFallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WSWaterFallLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WSWaterFallLayout *flowLayout;
@property (strong, nonatomic) NSMutableArray *goodsArray;

@end

@implementation WSWaterFallViewController

//懒加载
-(NSMutableArray *)goodsArray{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *goods = [WSGoods goodsWithIndex:0];
    [self.goodsArray addObjectsFromArray:goods];
    [self collectionSetting];
    
}
-(void)collectionSetting{
    self.flowLayout = [[WSWaterFallLayout alloc]init];
    self.flowLayout.columnCount = 2;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UICollectionView dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    WSGoods *goods = self.goodsArray[indexPath.item];
    cell.goods = goods;
    
    return cell;
}

#pragma mark - WaterFallLayoutDelegate
-(CGFloat)waterfallLayout:(WSWaterFallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath{
    
    WSGoods *goods = self.goodsArray[indexPath.item];
    CGFloat imgHeight = itemWidth * goods.h/goods.w;
    CGFloat itemHeight = imgHeight + 30;
    return itemHeight;
}

@end
