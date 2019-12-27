//
//  CIDetectionManage.h
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIDetectionManage : NSObject

+ (UIImage *)ciFaceDetectionWith:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
