//
//  RSShowOnlyReadStarView.m
//  RSStarRating
//
//  Created by thinkjoy on 16/10/26.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//

#import "RSShowOnlyReadStarView.h"
#import "RSOnlyReadStarView.h"


@interface RSShowOnlyReadStarView ()
/**星星之间的间隔*/
//@property   (nonatomic,assign)  CGFloat  space;
///**
// *  星星的宽高
// */
//@property (nonatomic, assign) CGFloat star_WY;
//
//
///**
// *  星星的总个数
// */
//@property   (nonatomic,assign)  NSInteger  starCount;
///**
// *  高亮的个数
// */
//@property   (nonatomic,assign)  NSInteger  heightStarCount;
//
///**
// *  高亮颜色
// */
//@property   (nonatomic,strong)  UIColor *  heightColor;
///**
// *  低亮颜色
// */
//@property   (nonatomic,strong)  UIColor *  defaultColor;

@end

@implementation RSShowOnlyReadStarView

- (instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)starCount heightStarCount:(NSInteger)heightStarCount heightColor:(UIColor *)heightColor defaultColor:(UIColor *)defaultColor
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat star_WY = frame.size.height;
        CGFloat space  =   (frame.size.width - starCount*star_WY)/(starCount - 1.f);
        NSLog(@"%@---%f",NSStringFromCGRect(frame),space);
//        NSMutableArray  * starViewMuAry =   [NSMutableArray arrayWithCapacity:starCount];
        
        //首先绘制一层低亮的星星
//        for (int i=0; i<starCount; i++)
//        {
//            CGRect starRect = CGRectMake(i*(space+star_WY), 0, star_WY, star_WY);
//            RSOnlyReadStarView *starView    =   [[RSOnlyReadStarView alloc] initWithFrame:starRect fillColor:defaultColor percent:1.f];
//            [self addSubview:starView];
//        }
        
        for (int i=0; i<starCount; i++) {
            CGRect starRect = CGRectMake(i*(space+star_WY), 0, star_WY, star_WY);
            if (i<heightStarCount) {
                RSOnlyReadStarView *starView    =   [[RSOnlyReadStarView alloc] initWithFrame:starRect fillColor:heightColor percent:1.f];
                [self addSubview:starView];
            }else{
                RSOnlyReadStarView *starView    =   [[RSOnlyReadStarView alloc] initWithFrame:starRect fillColor:defaultColor percent:1.f] ;
                [self addSubview:starView];
            }
            NSLog(@"%@---%f",NSStringFromCGRect(starRect),space);
        }
        NSLog(@"%@---%@",self,self);
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
