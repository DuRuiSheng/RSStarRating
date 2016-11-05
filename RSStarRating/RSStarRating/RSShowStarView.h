//
//  RSShowStarView.h
//  RSStarRating
//
//  Created by thinkjoy on 16/8/24.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//  https://github.com/DuRuiSheng/RSStarRating

#import <UIKit/UIKit.h>

@class RSShowStarView;

/**
 *  滑动或点击scoreView的回调Block
 *
 *  @param score 分数
 */
typedef void(^starScoreViewBlock)(CGFloat score);

/* 星星的绘制方式,默认为整个的 则根据score对应的百分比填充 */
typedef NS_ENUM(NSInteger, RSShowStarDrawStyle) {
    RSShowStarDrawStyleComplete           = 0,    // 只有完整的星星,全部填充
    RSShowStarDrawStyleCompleteAndHalf    ,    // 完整的和一半的,显示一半填充或者全部填充
    RSShowStarDrawStyleFree               ,    // 自由的
};

/*RSShowStarView的样式 ,默认是读 */
typedef NS_ENUM(NSInteger, RSShowStarStyle) {
    RSShowStarStyleRead     = 0,    // 只读的样式,点击和滑动无效
    RSShowStarStyleWrite    ,    // 写,允许用户手动进行滑动改变score的值
};

@protocol  RSShowStarViewDelegate;


@interface RSShowStarView : UIView


/**
 创建一个星评View
 
 @param frame             frame
 @param showStarStyle     只读或者只写
 @param showStarDrawStyle 星星的绘制方式
 @param starCount         星星总数
 @param heightStarCount   初始高亮星星的个数
 @param heightColor       高亮星星颜色
 @param defaultColor      低亮星星颜色
 
 @return View
 */
- (instancetype)initWithFrame:(CGRect)frame
                showStarStyle:(RSShowStarStyle)showStarStyle
            showStarDrawStyle:(RSShowStarDrawStyle)showStarDrawStyle
                    starCount:(NSInteger)starCount
              heightStarCount:(CGFloat)heightStarCount
                  heightColor:(UIColor *)heightColor
                 defaultColor:(UIColor *)defaultColor;


/**
 *  改变score的值的回调block,RSShowStarStyle=RSShowStarStyleWrite有效
 */
@property (nonatomic, copy) starScoreViewBlock scoreBlock;
@property   (nonatomic,assign)  id  <RSShowStarViewDelegate>delegate;

@end


@protocol RSShowStarViewDelegate <NSObject>

- (void)showStarView:(RSShowStarView *)showStarView getScore:(CGFloat )score;

@end

