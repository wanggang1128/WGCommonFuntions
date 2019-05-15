//
//  WGCustomCollectionViewCell.m
//  WGCustomFlowLayout
//
//  Created by wanggang on 2019/5/14.
//  Copyright © 2019 bozhong. All rights reserved.
//

#import "WGCustomCollectionViewCell.h"
#import "UIView+WGFrame.h"

@interface WGCustomCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *ageLab;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UIButton *likeBtn;

@end

@implementation WGCustomCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self buildView];
        [self gridFrame];
    }
    return self;
}

- (void)buildView{
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.ageLab];
    [self.contentView addSubview:self.countLab];
    [self.contentView addSubview:self.likeBtn];

}

- (void)gridFrame{
    
    _imgView.frame = CGRectMake(0, 0, self.width, self.width);
    _nameLab.frame = CGRectMake(_imgView.left, _imgView.bottom, _imgView.width, 20);
    _ageLab.frame = CGRectMake(_imgView.left, _nameLab.bottom, _imgView.width, 20);
    _countLab.frame = CGRectMake(_imgView.left, _ageLab.bottom, _imgView.width/2, 20);
    _likeBtn.frame = CGRectMake(_countLab.right, _ageLab.bottom, _imgView.width/2, 20);
}

- (void)listFrame{
    
    _imgView.frame = CGRectMake(0, 0, self.height, self.height);
    _nameLab.frame = CGRectMake(_imgView.right+10, _imgView.top, self.width-self.height, 20);
    _ageLab.frame = CGRectMake(_imgView.right+10, _nameLab.bottom, self.width-self.height, 20);
    _countLab.frame = CGRectMake(_imgView.right+10, _ageLab.bottom, self.width-self.height, 20);
    _likeBtn.frame = CGRectMake(_imgView.right+10, _countLab.bottom, self.width-self.height, 20);
}

- (void)setModel:(NSInteger)model{
    
    _model = model;
   
    _imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg", (_model % 6+1)]];
    _nameLab.text = [NSString stringWithFormat:@"%ld.jpeg", (_model % 6+1)];
    _ageLab.text = [NSString stringWithFormat:@"%ld", (_model % 6+1)];
    _countLab.text = [NSString stringWithFormat:@"已获得%ld个点赞", (_model % 6+1)];
}

- (void)setList:(BOOL)list{
    
    _list = list;
    if (_list) {
        [UIView animateWithDuration:0.25 animations:^{
            [self listFrame];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self gridFrame];
        }];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

- (void)likeBtnClicked{
    
    _countLab.text = @"赞已集满";
    _likeBtn.userInteractionEnabled = NO;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.font = [UIFont systemFontOfSize:14];
    }
    return _nameLab;
}

-(UILabel *)ageLab{
    if (!_ageLab) {
        _ageLab = [[UILabel alloc] init];
        _ageLab.textColor = [UIColor lightGrayColor];
        _ageLab.font = [UIFont systemFontOfSize:12];
    }
    return _ageLab;
}

-(UILabel *)countLab{
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.textColor = [UIColor lightGrayColor];
        _countLab.font = [UIFont systemFontOfSize:12];
    }
    return _countLab;
}

- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
        _likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_likeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

@end
