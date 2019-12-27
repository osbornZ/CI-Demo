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

@interface ViewController ()<CIEditorToolBarDelegate,UIGestureRecognizerDelegate>
{
    UIImageView *_imageV;
    NSArray *_toolModels;
}

@property (nonatomic,strong) UIImageView *effectImgView;
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
    
    self.effectImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.effectImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.effectImgView.userInteractionEnabled = YES;
    [self.effectImgView setImage:_imageV.image];
    [self.view addSubview:self.effectImgView];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionLongPress:)];
    longPress.delegate = self;
    [self.effectImgView addGestureRecognizer:longPress];
    
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
    self.effectImgView.frame = CGRectMake(0, (kScreenHeight-kScreenWidth)/2, kScreenWidth, kScreenWidth);
    _imageV.frame        = CGRectMake(0, (kScreenHeight-kScreenWidth)/2, kScreenWidth, kScreenWidth);
    self.toolBar.frame   = CGRectMake(0, kScreenHeight-bottom-60, kScreenWidth, 60);
}


#pragma mark --

- (void)editorToolBar:(CIEditorToolBar *)bar didSelectIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            {
                self.deteImage = [CIDetectionManage ciFaceDetectionWith:_imageV.image];
                [self.effectImgView setImage:_deteImage];
            }
            break;
        default:
            break;
    }
}


#pragma mark -

- (void)actionLongPress:(UILongPressGestureRecognizer *)gesture {
 
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.effectImgView.hidden = YES;
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        self.effectImgView.hidden = NO;
    }

}



@end
