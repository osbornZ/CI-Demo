//
//  CIEditorToolBar.h
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIModule.h"

#define  kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define  kScreenHeight ([UIScreen mainScreen].bounds.size.height)

NS_ASSUME_NONNULL_BEGIN

@protocol CIEditorToolBarDelegate;
@interface CIEditorToolBar : UIView

@property (nonatomic, weak ) id <CIEditorToolBarDelegate> delegate;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

- (void)configToolBarModules:(NSArray *)models;

@end



@protocol CIEditorToolBarDelegate <NSObject>

- (void)editorToolBar:(CIEditorToolBar *)bar didSelectIndex:(NSInteger)index;

@end


@interface CIEditorToolBarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel     *iconLabel;

- (void)configContentWith:(CIModule *)model;


@end

NS_ASSUME_NONNULL_END
