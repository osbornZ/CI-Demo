//
//  CIFilteredImageView.m
//  CI-Demo
//
//  Created by osborn on 2019/12/31.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CIFilteredImageView.h"
#import <OpenGLES/EAGL.h>

@implementation CIFilteredImageView





//GLKView  realTime
- (void)actionGpuProcess {
    
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    CIContext *ciContext = [CIContext contextWithEAGLContext:context];
    
//    [ciContext drawImage:<#(nonnull CIImage *)#> inRect:<#(CGRect)#> fromRect:<#(CGRect)#>];
    
}


@end
