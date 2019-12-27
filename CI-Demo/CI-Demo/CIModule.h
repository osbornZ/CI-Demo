//
//  CIModule.h
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CIModule : NSObject

@property (nonatomic,copy) NSString *modelName;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithTitle:(NSString *)title ;

@end

NS_ASSUME_NONNULL_END
