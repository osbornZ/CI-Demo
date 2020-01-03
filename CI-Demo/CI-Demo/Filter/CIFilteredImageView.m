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

        self.context = eaglContext; //
        
        UIImage *image = [UIImage imageNamed:@"demoModel.jpg"];
        self.myImage   = [[CIImage alloc]initWithImage:image];

        self.clipsToBounds = YES;
        
    }
    return self;
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//}

- (void)drawRect:(CGRect)rect {
    
    //clearBackground
    glClearColor(0.949, 0.949, 0.969, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    CGRect inputBounds = [_myImage extent];
    CGRect drawBounds  = CGRectMake(0, 0, self.drawableWidth, self.drawableHeight);
    
    if (self.contentMode == UIViewContentModeScaleAspectFit ) {
       drawBounds = [self realDrawRectWith:inputBounds toRect:drawBounds];
    }else if (self.contentMode == UIViewContentModeScaleAspectFill) {
        
    }else {
        
    }
    
    [self.mycontext drawImage:_myImage inRect:drawBounds fromRect:[_myImage extent]];
//    [self.context presentRenderbuffer:GL_RENDERBUFFER]; ？
    
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


- (CGRect)realDrawRectWith:(CGRect)fromRect toRect:(CGRect)toRect {
    CGFloat fromAspectRatio = fromRect.size.width / fromRect.size.height;
    CGFloat toAspectRatio   = toRect.size.width / toRect.size.height;

    CGRect fitRect = toRect; //

    if (fromAspectRatio > toAspectRatio) {
        fitRect.size.height = toRect.size.width / fromAspectRatio;
        fitRect.origin.y   += (toRect.size.height - fitRect.size.height) * 0.5;
    } else {
        fitRect.size.width = toRect.size.height  * fromAspectRatio;
        fitRect.origin.x += (toRect.size.width - fitRect.size.width) * 0.5;
    }

    return CGRectIntegral(fitRect);
}



@end
