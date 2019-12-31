//
//  CIFilterManage.h
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIFilterManage : NSObject

+ (void)sysContainFilters;

+ (UIImage *)monochromeProcessWith:(UIImage *)image;

+ (UIImage *)monochromeProcessWith:(UIImage *)image withIntensity:(CGFloat)intensity;

+ (UIImage *)outputImage:(UIImage *)image withFilterName:(NSString *)filterName;

@end

NS_ASSUME_NONNULL_END
