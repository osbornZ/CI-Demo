//
//  ViewController.m
//  CI-Demo
//
//  Created by zfan on 2017/4/29.
//  Copyright © 2017年 zfan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    UIImageView *imageV;
}
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self performSelectorInBackground:@selector(faceDetector) withObject:nil];
    
    [self faceDetector];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)faceDetector {
    
    imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demoModel.jpg"]];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageV];
    
    [imageV setTransform:CGAffineTransformMakeScale(1, -1)];
    [self.view setTransform:CGAffineTransformMakeScale(1, -1)];

    // Execute the method used to markFaces in background
    [self markFaces:imageV];
}

- (void)markFaces:(UIImageView *)imageview {
    CIImage *image = [CIImage imageWithCGImage:imageview.image.CGImage];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    NSArray *features = [detector featuresInImage:image];
    
    for(CIFaceFeature* faceFeature in features) {
        CGFloat faceWidth = faceFeature.bounds.size.width;
        
        UIView *faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.view addSubview:faceView];
        
        if(faceFeature.hasLeftEyePosition) {
            
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            [self.view addSubview:leftEyeView];
        }
        
        if(faceFeature.hasRightEyePosition) {
            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
             [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
             [leftEye setCenter:faceFeature.rightEyePosition];
            leftEye.layer.cornerRadius = faceWidth*0.15;
            [self.view addSubview:leftEye];
        }
        
        if(faceFeature.hasMouthPosition) {
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
            [mouth setCenter:faceFeature.mouthPosition];
            mouth.layer.cornerRadius = faceWidth*0.2;
            [self.view addSubview:mouth];
        }
    }
    
}


@end
