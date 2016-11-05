//
//  RSShowOnlyReadStarView.h
//  RSStarRating
//
//  Created by thinkjoy on 16/10/26.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//  https://github.com/DuRuiSheng/RSStarRating
//  显示多个只读星星的View

#import <UIKit/UIKit.h>

@interface RSShowOnlyReadStarView : UIView

- (instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)starCount heightStarCount:(NSInteger)heightStarCount heightColor:(UIColor *)heightColor defaultColor:(UIColor *)defaultColor;


@end
