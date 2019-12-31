//
//  CISlider.m
//  CI-Demo
//
//  Created by osborn on 2019/12/31.
//  Copyright © 2019 zfan. All rights reserved.
//

#import "CISlider.h"

#define kMinColor ([UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.0])
#define kMaxColor ([UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0])

@interface CISlider()
{
    CGRect _thumbRect;
}
@property(nonatomic, strong) UILabel *sliderValueLabel;
@property(nonatomic, strong) UIVisualEffectView *labelBlurView;

@end


@implementation CISlider

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat lineH = 2.0;
    //底线
    [kMaxColor setFill];
    CGFloat lineX = 15;
    UIRectFill(CGRectMake(lineX, self.frame.size.height/2-lineH/2, self.frame.size.width-lineX*2, lineH));
    
    //原点
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat dotW = 3.0;
    CGFloat dotH = 3.0;
    CGFloat dotX = lineX-dotW/2;
    CGFloat dotY = self.frame.size.height/2-dotH/2;
    if ([self isZeroInCenter]) { //只有（-1, 1）的时候显示原点，（0, 1）时不再显示
        dotX = self.frame.size.width/2.0-dotW/2;
        
        CGContextAddEllipseInRect(context, CGRectMake(dotX, dotY, dotW, dotH));
        [kMinColor set];
        //绘制
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    [kMinColor setFill];
    CGPoint zeroPoint = CGPointMake([self isZeroInCenter] ? self.frame.size.width/2 : lineX, self.frame.size.height/2-lineH/2);
    CGPoint thumbCenter = CGPointMake(_thumbRect.origin.x+_thumbRect.size.width/2, _thumbRect.origin.y+_thumbRect.size.height/2);
    CGRect lineRect = CGRectZero;
    if (self.value > 0) {
        lineRect = CGRectMake(zeroPoint.x, zeroPoint.y, thumbCenter.x-zeroPoint.x, lineH);
    } else {
        lineRect = CGRectMake(thumbCenter.x, zeroPoint.y, zeroPoint.x-thumbCenter.x, lineH);
    }
    UIRectFill(lineRect);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self)
    {
        UIImage *thumbImage = [UIImage imageNamed:@"slider_thumb"];
        [self setThumbImage:thumbImage forState:UIControlStateHighlighted];
        [self setThumbImage:thumbImage forState:UIControlStateNormal];
        self.maximumTrackTintColor = [UIColor clearColor];
        self.minimumTrackTintColor = [UIColor clearColor];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        self.labelBlurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.labelBlurView.backgroundColor = [UIColor grayColor];
        self.labelBlurView.layer.masksToBounds = YES;
        [self addSubview:self.labelBlurView];
        self.labelBlurView.alpha = 0;
    
        self.sliderValueLabel = [[UILabel alloc] init];
        self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
        self.sliderValueLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.sliderValueLabel.textColor = [UIColor blackColor];
        [self addSubview:self.sliderValueLabel];
        self.sliderValueLabel.alpha = 0;
    }
    return self;
}

- (BOOL)isZeroInCenter
{
    return (self.minimumValue + self.maximumValue == 0);
}

#pragma mark -
- (void)setHiddenNumber:(BOOL)hiddenNumber
{
    _hiddenNumber = hiddenNumber;
    self.sliderValueLabel.hidden = hiddenNumber;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    _thumbRect = thumbRect;
    thumbRect = CGRectInset([super thumbRectForBounds:bounds trackRect:thumbRect value:value], 0, 0);
    
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.0f", self.value];
    if (self.value>=-0.5 && self.value<=0.5) {//解决滑竿有时候会显示 -0 的问题
        self.sliderValueLabel.text = @"0";
        self.value = 0; //加上这行滑竿在（-0.5, 0.5) 区间会自动跳到0
    }
    [self.sliderValueLabel sizeToFit];

    float labelX = thumbRect.origin.x+(thumbRect.size.width-_sliderValueLabel.frame.size.width)/2;
    float labelY = thumbRect.origin.y - _sliderValueLabel.frame.size.height - 18;
    self.sliderValueLabel.frame = CGRectMake(labelX, labelY, _sliderValueLabel.frame.size.width, _sliderValueLabel.frame.size.height);
    self.labelBlurView.frame = CGRectMake(0, 0, 44, 30);
    self.labelBlurView.center = CGPointMake(self.sliderValueLabel.center.x, self.sliderValueLabel.center.y);
    self.labelBlurView.layer.cornerRadius = _labelBlurView.frame.size.height/2;
    
    [self setNeedsDisplay];
    
    return thumbRect;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!_hiddenNumber) {
        self.sliderValueLabel.alpha = 0;
        self.labelBlurView.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.sliderValueLabel.alpha = 1;
            self.labelBlurView.alpha = 1;
        }];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!_hiddenNumber) {
        self.sliderValueLabel.alpha = 1;
        self.labelBlurView.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            self.sliderValueLabel.alpha = 0;
            self.labelBlurView.alpha = 0;
        }];
    }
}


@end
