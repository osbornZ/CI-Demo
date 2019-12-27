//
//  CIModule.m
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CIModule.h"

@implementation CIModule

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
       if (self) {
           _modelName  = title;
           _isSelected = NO;
       }
       return self;
}



@end
