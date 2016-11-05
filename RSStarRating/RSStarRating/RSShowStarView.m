//
//  RSShowStarView.m
//  RSStarRating
//
//  Created by thinkjoy on 16/8/24.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//

#import "RSShowStarView.h"
#import "RSStarView.h"

//#import "RSTwoColorStarView.h"

/**
 * RSShowStarStyleWrite & RSShowStarDrawStyleCompleteAndHalf 模式下显示的上下界限,
 * eg. write_half_leftLine = 0,write_half_rightLine=0.5
 *      <=0 取0; >0&<=0.5 取0.5; >0.5 取1.f
 */
static const CGFloat write_half_leftLine  = 0.f;
static const CGFloat write_half_rightLine = 0.5;

/**
 * RSShowStarStyleWrite & RSShowStarDrawStyleComplete 模式下显示的界限
 * eg.  write_complete_minLine=0.5
 *      <=0.5 取0 ; >0.5 取1;
 */
static const CGFloat write_complete_minLine =   0.01f;


/**
 * RSShowStarStyleRead & RSShowStarDrawStyleCompleteAndHalf 模式下显示的上下界限,
 * eg. write_half_leftLine = 0,write_half_rightLine=0.5
 *      <=0 取0; >0&<=0.5 取0.5; >0.5 取1.f
 */
static const CGFloat read_half_leftLine  = 0.f;
static const CGFloat read_half_rightLine = 0.5;

/**
 * RSShowStarStyleRead & RSShowStarDrawStyleComplete 模式下显示的界限
 * eg.  write_complete_minLine=0.5
 *      <=0.5 取0 ; >=0.5 取1;
 */
static const CGFloat read_complete_minLine =   0.5;


@interface RSShowStarView ()


/**
 *  RSShowStarView的样式 ,默认是读
 */
@property   (nonatomic,assign)  RSShowStarStyle  showStarStyle;

/**
 *  星星的绘制方式,默认为整个的
 */
@property   (nonatomic,assign)  RSShowStarDrawStyle  showStarDrawStyle;

@property   (nonatomic,assign)  NSInteger  starCount;
@property   (nonatomic,assign)  CGFloat  heightStarCount;

@property   (nonatomic,strong)  UIColor * heightColor;
@property   (nonatomic,strong)  UIColor * defaultColor;


/**
 星星的大小
 */
@property   (nonatomic,assign)  CGFloat  star_H_W;

/**
 星星间的间隔
 */
@property   (nonatomic,assign)  CGFloat  star_Space;


@property   (nonatomic,strong)  NSMutableArray * defaultStarMuAry;
@property   (nonatomic,strong)  NSMutableArray * starMuAry;

@end

@implementation RSShowStarView


- (instancetype)initWithFrame:(CGRect)frame showStarStyle:(RSShowStarStyle)showStarStyle showStarDrawStyle:(RSShowStarDrawStyle)showStarDrawStyle starCount:(NSInteger)starCount heightStarCount:(CGFloat)heightStarCount heightColor:(UIColor *)heightColor defaultColor:(UIColor *)defaultColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showStarStyle  =   showStarStyle;
        self.showStarDrawStyle  =   showStarDrawStyle;
        self.starCount      =   starCount;
        self.heightStarCount    =   heightStarCount;
        self.heightColor    =   heightColor;
        self.defaultColor   =   defaultColor;
        
        self.star_H_W   =   frame.size.height;
        self.star_Space =   (frame.size.width - starCount * frame.size.height)/(starCount - 1.f);
        
        
        if (self.showStarStyle==RSShowStarStyleWrite) {
            //首先绘制一层低亮的星星
            [self addDefaultStarView];
            [self addHeightStarViewWithHeightCount:_heightStarCount];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [self addGestureRecognizer:tap];
            
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
            [self addGestureRecognizer:pan];
        }else{
            //首先绘制一层低亮的星星
            [self addDefaultStarView];
            
            //添加高亮层
            [self addStarView];
        }
    }
    return self;
}
#pragma mark    ------------------只读模式-------开始-------------
#pragma mark    只读模式,只需要显示星星的个数
#pragma mark    添加一层默认的starView
- (void)addDefaultStarView
{
    [self initializerDefaultStar];
    [self.defaultStarMuAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:(RSStarView *)obj];
    }];
    //    NSLog(@"%@",self.defaultStarMuAry);
}
#pragma mark    添加新的层
- (void)addStarView
{
    [self initializerHeightStar];
    
    [self.starMuAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:(RSStarView *)obj];
    }];
}
#pragma mark    初始化默认层
- (void)initializerDefaultStar
{
    self.defaultStarMuAry   =   [NSMutableArray arrayWithCapacity:self.starCount];
    //首先绘制一层低亮的星星
    for (int i=0; i<_starCount; i++)
    {
        CGRect starRect = CGRectMake(i*(_star_Space+_star_H_W), 0, _star_H_W, _star_H_W);
        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_defaultColor  percent:1.f];
        [_defaultStarMuAry addObject:starView];
    }
}

#pragma mark    初始化高亮层
- (void)initializerHeightStar
{
    NSInteger dow_left  =   (NSInteger)(_heightStarCount*10)/10;
    CGFloat   dow_right =   _heightStarCount-dow_left;
    //    NSLog(@"%f-%ld--%f",_heightStarCount,(long)dow_left,dow_right);
    
    
    self.starMuAry  =   [[NSMutableArray alloc]init];
    for (int i=0; i<_starCount; i++)
    {
        CGRect starRect = CGRectMake(i*(_star_Space+_star_H_W), 0, _star_H_W, _star_H_W);
        if (i < dow_left) {
            RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:1.f];
            [self.starMuAry addObject:starView];
        }else{
            CGFloat decimal = dow_right;
            if (decimal>0) {
                switch (self.showStarDrawStyle) {
                    case RSShowStarDrawStyleFree:
                    {
                        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:decimal];
                        [self.starMuAry addObject:starView];
                    }
                        break;
                    case RSShowStarDrawStyleCompleteAndHalf:
                    {
                        if (decimal<=read_half_leftLine) {
                            decimal =   0;
                        }else if(decimal>read_half_leftLine && decimal<=read_half_rightLine)
                        {
                            decimal = 0.5;
                        }else{
                            decimal = 1.f;
                        }
                        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:decimal];
                        [self.starMuAry addObject:starView];
                    }
                        break;
                    case RSShowStarDrawStyleComplete:
                    {
                        if (decimal<=read_complete_minLine) {
                            decimal = 0;
                        }else{
                            decimal = 1.f;
                        }
                        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:decimal];
                        [self.starMuAry addObject:starView];
                    }
                        break;
                    default:
                        break;
                }
            }
            
            break;
        }
    }
    
    //    NSLog(@"self.defaultStarMuAry==%@,self.starMuAry==%@",self.defaultStarMuAry,self.starMuAry);
}
#pragma mark    ------------------只读模式-------结束-------------
#pragma mark    ------------------------------------------------

#pragma mark    手势响应
// 两个手势同时启用的方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    CGPoint currentPoint = [tap locationInView:self];
    
    CGFloat  newHeightCount = [self getHeightCountWithPoint:currentPoint];
    //    NSLog(@"tap-----newHeightCount=%f",newHeightCount);
    [self addHeightStarViewWithHeightCount:newHeightCount];
    [self addScoreBlockWithHeight:newHeightCount];
}
- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    //    NSLog(@"%@--%@",pan,NSStringFromCGPoint(currentPoint));
    CGFloat  newHeightCount = [self getHeightCountWithPoint:currentPoint];
    //    NSLog(@"pan-----newHeightCount=%f",newHeightCount);
    //    _heightStarCount    =   newHeightCount;
    [self addHeightStarViewWithHeightCount:newHeightCount];
    [self addScoreBlockWithHeight:newHeightCount];
}
- (void)addScoreBlockWithHeight:(CGFloat )score
{
    NSInteger dow_left  =   (NSInteger)(score*10)/10;
    CGFloat   dow_right =   score-dow_left;
    switch (_showStarDrawStyle) {
        case RSShowStarDrawStyleFree:
        {
            
        }
            break;
        case RSShowStarDrawStyleComplete:
        {
            if (dow_right<=write_complete_minLine) {
                dow_right = 0;
            }else{
                dow_right = 1.f;
            }
            score = dow_left+dow_right;
        }
            break;
        case RSShowStarDrawStyleCompleteAndHalf:
        {
            if (dow_right<=write_half_leftLine) {
                dow_right =   0;
            }else if(dow_right>write_half_leftLine && dow_right<=write_half_rightLine)
            {
                dow_right = 0.5;
            }else{
                dow_right = 1.f;
            }
            score = dow_left+dow_right;
        }
            break;
        default:
            break;
    }
    if (_scoreBlock) {
        
        _scoreBlock(score);
    }
    
    if ([self.delegate respondsToSelector:@selector(showStarView:getScore:)]) {
        [self.delegate showStarView:self getScore:score];
    }
}
- (NSMutableArray *)starMuAry
{
    if (_starMuAry==nil) {
        _starMuAry  =   [NSMutableArray arrayWithCapacity:self.starCount];
    }
    return _starMuAry;
}
- (void)addHeightStarViewWithHeightCount:(CGFloat)heughtCount
{
    self.heightStarCount    =   heughtCount;
    NSInteger dow_left  =   (NSInteger)(heughtCount*10)/10;
    CGFloat   dow_right =   heughtCount-dow_left;
    [self.starMuAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [(RSStarView *)obj removeFromSuperview];
    }];
    [self.starMuAry removeAllObjects];
    
    for (int i=0; i<_starCount; i++)
    {
        CGRect starRect = CGRectMake(i*(_star_Space+_star_H_W), 0, _star_H_W, _star_H_W);
        if (i < dow_left) {
            RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:1.f];
            [self.starMuAry addObject:starView];
        }else if(i==dow_left){
            CGFloat decimal = dow_right;
            if (decimal>0) {
                switch (self.showStarDrawStyle) {
                    case RSShowStarDrawStyleFree:
                    {
                        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:decimal];
                        [self.starMuAry addObject:starView];
                    }
                        break;
                    case RSShowStarDrawStyleCompleteAndHalf:
                    {
                        if (decimal<=write_half_leftLine) {
                            decimal =   0;
                        }else if(decimal>write_half_leftLine && decimal<=write_half_rightLine)
                        {
                            decimal = 0.5;
                        }else{
                            decimal = 1.f;
                        }
                        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:decimal];
                        [self.starMuAry addObject:starView];
                    }
                        break;
                    case RSShowStarDrawStyleComplete:
                    {
                        if (decimal<=write_complete_minLine) {
                            decimal = 0;
                        }else{
                            decimal = 1.f;
                        }
                        RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:decimal];
                        [self.starMuAry addObject:starView];
                    }
                        break;
                    default:
                        break;
                }
            }
        }else{
            RSStarView *starView    =   [[RSStarView alloc] initWithFrame:starRect fillColor:_heightColor  percent:0.f];
            [self.starMuAry addObject:starView];
        }
    }
    
    [self.starMuAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:(RSStarView *)obj];
    }];
    
}

#pragma mark 根据点击的位置计算点击的星星数量
- (CGFloat)getHeightCountWithPoint:(CGPoint)point
{
    CGFloat point_X = point.x;
    NSInteger dow_l = 0;
    CGFloat dow_r = 0;
    for (int i = 0; i<_starCount; i++) {
        
        if (point_X>(_star_H_W+_star_Space)*i + _star_H_W) {
            if (i==4) {
                return _starCount;
            }
        }else{
            if (point_X > (_star_H_W+_star_Space)*i) {
                dow_l = i;
                dow_r = (point_X-(_star_H_W+_star_Space)*i)/_star_H_W;
                return (dow_l+dow_r);
            }else{
                return i;
            }
            
        }
    }
    return 0;
}

@end

