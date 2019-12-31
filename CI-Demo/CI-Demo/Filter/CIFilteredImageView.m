//
//  CIFilteredImageView.m
//  CI-Demo
//
//  Created by osborn on 2019/12/31.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CIFilteredImageView.h"
#import <OpenGLES/EAGL.h>

@interface CIFilteredImageView()

@property (nonatomic,strong) CIContext *mycontext;
@property (nonatomic,strong) CIImage   *myImage;
@property (nonatomic,strong) CIFilter  *myFilter;

@end

@implementation CIFilteredImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        CIContext *ciContext = [CIContext contextWithEAGLContext:eaglContext];
        self.mycontext = ciContext;

        UIImage *image = [UIImage imageNamed:@"demoModel.jpg"];
        self.myImage = [[CIImage alloc]initWithImage:image];

        self.clipsToBounds = YES;
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {
    
    [self.mycontext drawImage:_myImage inRect:self.bounds fromRect:[_myImage extent]];

}


//GLKView  realTime
- (void)actionGpuProcess {

    //CPU
//    self.mycontext = [CIContext contextWithOptions: [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCIContextUseSoftwareRenderer]];
    
    //Default GPU (展示来回切换 gpu process -> cpu ->gpu )
//    self.mycontext = [CIContext contextWithOptions: nil];

    
    //依次自动增强处理
    NSArray *adjustments = [_myImage autoAdjustmentFilters];
    for (CIFilter *filter in adjustments) {
      [filter setValue:_myImage forKey:kCIInputImageKey];
      _myImage = filter.outputImage;
    }
    
    [self setNeedsDisplay];
    
}

- (UIImage *)autoAdjustImage {
    
    UIImage *resultImage = [UIImage imageWithCIImage:_myImage];
    return resultImage;
}


@end
