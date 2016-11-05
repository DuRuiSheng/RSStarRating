//
//  RSStarView.m
//  RSStarRating
//
//  Created by thinkjoy on 16/8/23.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//

#import "RSStarView.h"

@interface RSStarView ()
@property   (nonatomic,strong)  UIColor *  fillColor;
//@property   (nonatomic,strong)  UIColor *  defaultColor;
@property (nonatomic, assign) CGFloat percent;

@end

@implementation RSStarView

- (instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillColor  percent:(CGFloat)percent
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    =   [UIColor clearColor];
        _fillColor      =   fillColor;
        //        _defaultColor   =   defaultColor;
        _percent        =   percent;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    
    double scale = M_PI/180;    //把角度(°C)转化为数值,360°C=2PI
    //     scale  =   M_PI_4 *0.5 * (2.0 / 5.0);
    
    CGFloat maxRadius = MIN(width, height)/2;
    
    CGFloat minRadius   =   maxRadius * sin(18 * scale) /cos(36*scale);    //根据半径计算出小圆半径
    
    CGFloat max_X[5] = {0} , max_Y[5] = {0} , min_X[5] = {0} , min_Y[5] = {0};
    
    for (int i=0; i<5; i++) {
        //以第一象限的点开始,逆时针计算
        max_X[i]    =   centerX + maxRadius * cos((90+i*72) * scale); //外圈的坐标
        max_Y[i]    =   centerY - maxRadius * sin((90+i*72) * scale);
        
        min_X[i]    =   centerX + minRadius * cos((54+i*72) * scale);   //内圈的坐标
        min_Y[i]    =   centerY - minRadius * sin((54+i*72) * scale);
        
    }
    
    //上下文(画布)
    CGContextRef    context =   UIGraphicsGetCurrentContext();
    //绘制路径
    CGMutablePathRef startPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(startPath, NULL, max_X[0], max_Y[0]); //起点
    for (int i = 1; i < 5; i ++) {  //绘制线路
        CGPathAddLineToPoint(startPath, NULL, min_X[i], min_Y[i]);
        CGPathAddLineToPoint(startPath, NULL, max_X[i], max_Y[i]);
    }
    CGPathAddLineToPoint(startPath, NULL, min_X[0], min_Y[0]);    //终点
    CGPathCloseSubpath(startPath);  //封闭线路
    
    CGContextAddPath(context, startPath);   //把绘制的线绘制到上下文上
    
    //填充颜色
    CGContextSetFillColorWithColor(context,  self.fillColor.CGColor);
    //线条宽度
    CGContextSetLineWidth(context,0.1);
    //线条颜色
    //    CGContextSetStrokeColorWithColor(context, self.fillColor.CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    //设置后再次绘制
    CGContextStrokePath(context);
    
    //绘制填充色
    CGRect range = CGRectMake(0, 0, rect.size.width * _percent , rect.size.height);
    
    CGContextAddPath(context, startPath);
    CGContextClip(context);
    CGContextFillRect(context, range);
    
    CFRelease(startPath);
}

@end
