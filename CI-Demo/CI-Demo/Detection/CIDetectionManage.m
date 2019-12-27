//
//  CIDetectionManage.m
//  CI-Demo
//
//  Created by osborn on 2019/12/27.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CIDetectionManage.h"

@implementation CIDetectionManage

+ (UIImage *)ciFaceDetectionWith:(UIImage *)image {
    
    CIImage *tempImage   = [CIImage imageWithCGImage:image.CGImage];
    
    //detector type
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    NSArray *features = [detector featuresInImage:tempImage];
    
    //CG 绘制dete结果
    UIGraphicsBeginImageContext(image.size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);

    for (CIFaceFeature *faceFeature in features ) {
        
        CGFloat faceWidth = faceFeature.bounds.size.width;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint point = faceFeature.bounds.origin;
        CGSize size   = faceFeature.bounds.size;
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x + size.width, point.y)];
        [path addLineToPoint:CGPointMake(point.x + size.width, point.y + size.height)];
        [path addLineToPoint:CGPointMake(point.x, point.y+ size.height)];
        [path addLineToPoint:point];
        [[UIColor redColor] setStroke];
        [path stroke];

        if(faceFeature.hasLeftEyePosition) {
            [self drawCycleAtPoint:faceFeature.leftEyePosition withRadius:faceWidth*0.05];
        }
        
        if(faceFeature.hasRightEyePosition) {
            [self drawCycleAtPoint:faceFeature.rightEyePosition withRadius:faceWidth*0.05];
        }
        
        if(faceFeature.hasMouthPosition) {
            [self drawCycleAtPoint:faceFeature.mouthPosition withRadius:faceWidth*0.1];
        }

    }

     UIImage *contextImage  = UIGraphicsGetImageFromCurrentImageContext();
     CGContextClearRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height));
     CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), contextImage.CGImage);
    
     contextImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
    
    return contextImage;
    
}

+ (void)drawCycleAtPoint:(CGPoint)point withRadius:(CGFloat)radius {

    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),1,1,0,1.0);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    CGContextAddArc(UIGraphicsGetCurrentContext(), point.x, point.y, radius, 0, 2*M_PI, 0);
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);

}


@end
