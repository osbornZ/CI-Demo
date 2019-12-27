//
//  CIEditorToolBar.m
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CIEditorToolBar.h"

static NSString *kCellReuseIdentifier = @"kCellReuseIdentifier";

@interface CIEditorToolBar ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy) NSArray<CIModule *> *models;

@end


@implementation CIEditorToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        {
            UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
            [collectionViewLayout setItemSize:CGSizeMake(80, 60)];
            [collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            collectionViewLayout.minimumInteritemSpacing = 0;
            collectionViewLayout.minimumLineSpacing      = 5;

            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
            _collectionView.backgroundColor = [UIColor whiteColor];
            [_collectionView registerClass:[CIEditorToolBarCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
            _collectionView.delegate   = self;
            _collectionView.dataSource = self;
            _collectionView.showsHorizontalScrollIndicator = NO;
            [self addSubview:self.collectionView];
            
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, 60);
    
}

- (void)configToolBarModules:(NSArray *)models {
    _models = models;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CIEditorToolBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    id module = self.models[indexPath.row];
    [cell configContentWith:module];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate  editorToolBar:self didSelectIndex:indexPath.row];
     
}


@end


@implementation CIEditorToolBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _iconLabel  = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 50)];
        _iconLabel.textColor     = [UIColor colorWithRed:46/255.0 green:47/255.0 blue:51/255.0 alpha:1.0];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        _iconLabel.font          = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:_iconLabel];
    }
    return self;
}


- (void)configContentWith:(CIModule *)model {
    
    if (model.isSelected) {
        _iconLabel.backgroundColor = [UIColor grayColor];
    }
    _iconLabel.text = model.modelName;
    
}

@end
