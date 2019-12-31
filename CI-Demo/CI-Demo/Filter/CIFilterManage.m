//
//  CIFilterManage.m
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CIFilterManage.h"

@implementation CIFilterManage

+ (void)sysContainFilters {
    
    //内部 219个
    NSArray<NSString *> *filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@",filterNames);
    
    //inputkeys
    
}

+ (UIImage *)monochromeProcessWith:(UIImage *)image {
    
    UIImage *resultImage = [CIFilterManage monochromeProcessWith:image withIntensity:1.0];
    return resultImage;
}

+ (UIImage *)monochromeProcessWith:(UIImage *)image withIntensity:(CGFloat)intensity {
    
    //image.ciimage = nil can't base cgimage
    CIImage *inputImg = [CIImage imageWithCGImage:image.CGImage];
    
    CIColor *inputColor = [CIColor colorWithRed:0.76 green:0.65 blue:0.54];
    
    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome" withInputParameters:@{@"inputColor":inputColor,@"inputIntensity":@(intensity)}];
    [monochromeFilter setValue:inputImg forKey:@"inputImage"];
    
    CIFilter *vignetteFilter =  [CIFilter filterWithName:@"CIVignette" withInputParameters:@{@"inputRadius" : @(1.75),@"inputIntensity" : @(intensity)}];
    [vignetteFilter setValue:monochromeFilter.outputImage forKey:@"inputImage"];

    //context
//    CIImage *outputImage = [vignetteFilter outputImage];
//    CIContext *context = [CIContext contextWithOptions: nil];
//    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
//    UIImage *resultImage = [UIImage imageWithCGImage:cgimg];
    
    UIImage *resultImage = [UIImage imageWithCIImage:vignetteFilter.outputImage];
    return resultImage;
}

+ (UIImage *)outputImage:(UIImage *)image withFilterName:(NSString *)filterName {
    
    CIImage  *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:@(10.f) forKey:@"inputRadius"];
    CIImage *outputImage = [filter outputImage];
    
    //
    CIContext *context = [CIContext contextWithOptions: nil];
    CGImageRef cgImg   = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImg];
    CGImageRelease(cgImg);
    
    return resultImage;
}


@end
