//
//  CIFilteredImageView.h
//  CI-Demo
//
//  Created by osborn on 2019/12/31.
//  Copyright © 2019 zfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIFilteredImageView : GLKView

- (void)actionGpuProcess;

- (UIImage *)autoAdjustImage;

@end

NS_ASSUME_NONNULL_END
