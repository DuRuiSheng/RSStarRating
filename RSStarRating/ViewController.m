//
//  ViewController.m
//  RSStarRating
//
//  Created by thinkjoy on 16/8/23.
//  Copyright © 2016年 thinkjoy. All rights reserved.
//

#import "ViewController.h"
#import "RSShowStarView.h"

#import "RSShowOnlyReadStarView.h"


@interface ViewController ()<RSShowStarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //只读的五角星,只能显示完整的星星
    RSShowOnlyReadStarView * showOnlyReadStarView = [[RSShowOnlyReadStarView alloc]initWithFrame:CGRectMake(30, 200, 300, 30) starCount:5 heightStarCount:3 heightColor:[UIColor redColor] defaultColor:[UIColor lightGrayColor]];
    showOnlyReadStarView.backgroundColor    =   [UIColor yellowColor];
    [self.view addSubview:showOnlyReadStarView];
    
    
    //只读
    RSShowStarView * showStarView = [[RSShowStarView alloc] initWithFrame:CGRectMake(30, 300, 300, 30) showStarStyle:RSShowStarStyleRead showStarDrawStyle:RSShowStarDrawStyleFree starCount:5 heightStarCount:3.4f heightColor:[UIColor greenColor] defaultColor:[UIColor lightGrayColor]];
    [self.view addSubview:showStarView];
    
    
    //只写
    RSShowStarView * showWriteStarView = [[RSShowStarView alloc] initWithFrame:CGRectMake(30, 350, 300, 30) showStarStyle:RSShowStarStyleWrite showStarDrawStyle:RSShowStarDrawStyleFree starCount:5 heightStarCount:0.f heightColor:[UIColor greenColor] defaultColor:[UIColor lightGrayColor]];
    showWriteStarView.delegate  =   self;
    
    [self.view addSubview:showWriteStarView];
    [showWriteStarView setScoreBlock:^(CGFloat score){
        NSLog(@"score===%f",score);
    }];
    
    
}

- (void)showStarView:(RSShowStarView *)showStarView getScore:(CGFloat)score
{
    NSLog(@"delegate_score==%f",score);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
