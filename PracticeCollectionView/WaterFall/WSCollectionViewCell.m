//
//  WSCollectionViewCell.m
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/8.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSCollectionViewCell.h"


@interface WSCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end


@implementation WSCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoods:(WSGoods *)goods{
    _goods = goods;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:goods.img]];
    self.priceLabel.text = goods.price;
    
}

@end
