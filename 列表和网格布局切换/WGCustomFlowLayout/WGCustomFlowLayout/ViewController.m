//
//  ViewController.m
//  WGCustomFlowLayout
//
//  Created by wanggang on 2019/5/14.
//  Copyright © 2019 bozhong. All rights reserved.
//

#import "ViewController.h"
#import "UIView+WGFrame.h"
#import "WGCustomCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;
@property (nonatomic, assign) BOOL list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"列表和网格切换";
    
    [self.view addSubview:self.collectionView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(regresh)];
    
}

- (void)regresh{
    
    self.list = !self.list;
    if (self.list) {
        [self.collectionView setCollectionViewLayout:self.listLayout animated:YES];
    }else{
        [self.collectionView setCollectionViewLayout:self.gridLayout animated:YES];
    }
    NSArray *dataArr = [self.collectionView visibleCells];
    for (WGCustomCollectionViewCell *cell in dataArr) {
        NSIndexPath *index = [self.collectionView indexPathForCell:cell];
        cell.list = self.list;
        cell.model = index.row;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WGCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WGCustomCollectionViewCell class]) forIndexPath:indexPath];
    //这里没有真实数据
    cell.list = self.list;
    cell.model = indexPath.row;
    return cell;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:self.gridLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        [_collectionView registerClass:[WGCustomCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([WGCustomCollectionViewCell class])];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)gridLayout{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        _gridLayout.itemSize = CGSizeMake((self.view.width-30)/2, (self.view.width-30)/2+70);
        _gridLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _gridLayout;
}

- (UICollectionViewFlowLayout *)listLayout{
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.itemSize = CGSizeMake(self.view.width-20, 80);
        _listLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _listLayout;
}


@end
