//
//  WSHorizantalSlipLayout.m
//  PracticeCollectionView
//
//  Created by wangshanshan on 2018/4/26.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSHorizantalSlipLayout.h"

@interface WSHorizantalSlipLayout()

@property (nonatomic, assign) CGFloat containerWidth;

@end

@implementation WSHorizantalSlipLayout

-(void)prepareLayout{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _containerWidth = CGRectGetWidth(self.collectionView.frame);
    self.itemSize = CGSizeEqualToSize(self.collectItemSize, CGSizeZero)? CGSizeMake(230, 350):self.collectItemSize;
    CGFloat padding = (_containerWidth - self.itemSize.width)/2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, padding, 0, padding);
    [super prepareLayout];
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray<UICollectionViewLayoutAttributes *> * array = [super layoutAttributesForElementsInRect:rect];
    NSArray *newArray = [[NSArray alloc]initWithArray:array copyItems:YES];
    
    CGFloat centerX = _containerWidth * 0.5 + self.collectionView.contentOffset.x;
    NSLog(@"%f",self.collectionView.contentOffset.x);
    
    [newArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *  _Nonnull attr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //4.每个格子到 中心线 之间的距离
        CGFloat distance = attr.center.x - centerX;
        
        if (ABS(distance) / self.containerWidth > .3) {
            attr.alpha = 0.5;
        }
        
        CGFloat scale = 1 - ABS(distance) / self.containerWidth / 2;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        
    }];
    
    return newArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGPoint loc = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    CGFloat centerX = proposedContentOffset.x  + _containerWidth * 0.5;
    //2.获取即将要显示的区域
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, _containerWidth, self.collectionView.bounds.size.height);
    //3.从即将要显示的区域内 获取 格子: 循环遍历 找到 离中心线 最近的那个格子
    NSArray<UICollectionViewLayoutAttributes *> *array = [self layoutAttributesForElementsInRect:rect];    // 循环遍历 找到 离中心线 最近的那个格子
    __block CGFloat min = CGFLOAT_MAX;
    __block CGFloat minDistance = 0;
    [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attr, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = attr.center.x - centerX;
        if (ABS(distance) < min) {
            min = ABS(distance);
            minDistance = distance;
        }
    }];
    //根据最小的偏差 ,修正 展示的点
    loc = CGPointMake(loc.x + minDistance, loc.y);
    return loc;
}

//当bounds发生改变的时候是否应该重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
