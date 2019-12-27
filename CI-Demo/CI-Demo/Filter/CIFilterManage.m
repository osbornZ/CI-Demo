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
     
    //image.ciimage = nil can't base cgimage
    CIImage *inputImg = [CIImage imageWithCGImage:image.CGImage];
    
    CIColor *inputColor = [CIColor colorWithRed:0.76 green:0.65 blue:0.54];
    
    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome" withInputParameters:@{@"inputColor":inputColor,@"inputIntensity":@(1.0)}];
    [monochromeFilter setValue:inputImg forKey:@"inputImage"];
    
    CIFilter *vignetteFilter =  [CIFilter filterWithName:@"CIVignette" withInputParameters:@{@"inputRadius" : @(1.75),@"inputIntensity" : @(1.0)}];
    [vignetteFilter setValue:monochromeFilter.outputImage forKey:@"inputImage"];

    UIImage *resultImage = [UIImage imageWithCIImage:vignetteFilter.outputImage];
    return resultImage;
    
}



@end
