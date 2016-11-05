//
//  RSOnlyReadStarView.h
//  RSStarRating
//
//  Created by thinkjoy on 16/10/26.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//  https://github.com/DuRuiSheng/RSStarRating
//  只读,单个星星的绘制

#import <UIKit/UIKit.h>

@interface RSOnlyReadStarView : UIView

- (instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillColor percent:(CGFloat)percent;

//- (instancetype)loadStarRatingW:(CGFloat)w andStarRatingH:(CGFloat)h fillColor:(UIColor *)fillColor;

@end
