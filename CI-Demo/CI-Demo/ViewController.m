//
//  ViewController.m
//  CI-Demo
//
//  Created by zfan on 2017/4/29.
//  Copyright © 2017年 zfan. All rights reserved.
//

#import "ViewController.h"
#import "CIEditorToolBar.h"
#import "CIModule.h"

#import "CIDetectionManage.h"

@interface ViewController ()<CIEditorToolBarDelegate>
{
    UIImageView *_imageV;
    NSArray *_toolModels;
}

@property (nonatomic,strong) UIView *bgImgView;
@property (nonatomic,strong) CIEditorToolBar *toolBar;

@property (nonatomic,strong) UIImage *deteImage;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demoModel.jpg"]];
    _imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageV];
    
    self.bgImgView = [[UIView alloc]initWithFrame:CGRectZero];
    self.bgImgView.hidden = YES;
    [self.view addSubview:self.bgImgView];

    self.toolBar = [[CIEditorToolBar alloc]initWithFrame:CGRectZero];
    self.toolBar.delegate = self;
    [self.view addSubview:_toolBar];
    
    _toolModels = @[
            [[CIModule alloc] initWithTitle:@"DeteFace"],
            [[CIModule alloc] initWithTitle:@"CI-1"],
            [[CIModule alloc] initWithTitle:@"CI-2"],
            [[CIModule alloc] initWithTitle:@"CI-3"],
            [[CIModule alloc] initWithTitle:@"CI-4"],
            [[CIModule alloc] initWithTitle:@"CI-5"],
            [[CIModule alloc] initWithTitle:@"CI-6"],
            [[CIModule alloc] initWithTitle:@"CI-7"],
            [[CIModule alloc] initWithTitle:@"CI-8"]
                    ];
    [_toolBar configToolBarModules:_toolModels];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = self.view.safeAreaInsets.bottom;
    }
    self.bgImgView.frame = CGRectMake(0, (kScreenHeight-kScreenWidth)/2, kScreenWidth, kScreenWidth);
    _imageV.frame        = CGRectMake(0, (kScreenHeight-kScreenWidth)/2, kScreenWidth, kScreenWidth);
    self.toolBar.frame   = CGRectMake(0, kScreenHeight-bottom-60, kScreenWidth, 60);
}


#pragma mark --

- (void)editorToolBar:(CIEditorToolBar *)bar didSelectIndex:(NSInteger)index {
    
    self.bgImgView.hidden = YES;

    switch (index) {
        case 0:
            {
                self.deteImage = [CIDetectionManage ciFaceDetectionWith:_imageV.image];
                [_imageV setImage:_deteImage];
//                [self.bgImgView setTransform:CGAffineTransformMakeScale(1, -1)];
//                self.bgImgView.hidden = NO;
            }
            break;
        default:
            break;
    }
}


@end
