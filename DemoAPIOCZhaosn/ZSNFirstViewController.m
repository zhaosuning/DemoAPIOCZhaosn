//
//  ZSNFirstViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/9/14.
//

#import "ZSNFirstViewController.h"
#import "ZSNVideoBroadcastViewController.h"
#import "ZSNJoinMultiChannelViewController.h"
#import "ZSNMultiChannelViewController.h"

#import "ZSNDaXiaoLiuViewController.h"

#import "ZSNAIAECAINSViewController.h"
#import "ZSNChooseAudioProfileVC.h"
#import "ZSNAudioVerticalAnimationViewController.h"

#import "ZSNAudioVideoViewController.h"

#import "ZSNAPILiZiViewController.h"
#import "ZSNMPMusicPlayerVC.h"
#import "ZSNGaoQingViewController.h"

#import "ZSNTestViewController.h"

@interface ZSNFirstViewController ()

@end

@implementation ZSNFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    UILabel * lblTopTitle = [[UILabel alloc] init];
    lblTopTitle.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 50, 100, 100, 40);
    lblTopTitle.text = @"首页";
    lblTopTitle.textColor = [UIColor blueColor];
    lblTopTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTopTitle];
    
    //UIButton 初始化建议用buttonWithType
    UIButton *btnNextPage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNextPage.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 100, 160, 200, 40);
    [btnNextPage setTitle:@"下一页" forState:UIControlStateNormal];
    [btnNextPage.layer setCornerRadius:20];
    [btnNextPage.layer setMasksToBounds:YES];
    [btnNextPage setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnNextPage.backgroundColor = [UIColor greenColor];
    btnNextPage.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnNextPage addTarget:self action:@selector(btnNextPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNextPage];
    
    
//    UIButton *btnDaXiaoLiuPage = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnDaXiaoLiuPage.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 100, 220, 200, 40);
//    [btnDaXiaoLiuPage setTitle:@"大小流" forState:UIControlStateNormal];
//    [btnDaXiaoLiuPage.layer setCornerRadius:20];
//    [btnDaXiaoLiuPage.layer setMasksToBounds:YES];
//    [btnDaXiaoLiuPage setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    btnDaXiaoLiuPage.backgroundColor = [UIColor greenColor];
//    btnDaXiaoLiuPage.titleLabel.font = [UIFont systemFontOfSize:17.0];
//    [btnDaXiaoLiuPage addTarget:self action:@selector(btnDaXiaoLiuPageAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnDaXiaoLiuPage];
}

-(void) btnNextPageAction : (UIButton *) button {
    NSLog(@"打印了 点击进入下一页btnNextPageAction");
    
    //ZSNVideoBroadcastViewController *vc = [[ZSNVideoBroadcastViewController alloc] init];
    
    //ZSNJoinMultiChannelViewController *vc = [[ZSNJoinMultiChannelViewController alloc] init];
    
    //ZSNMultiChannelViewController *vc = [[ZSNMultiChannelViewController alloc] init];
    
    //ZSNDaXiaoLiuViewController *vc = [[ZSNDaXiaoLiuViewController alloc] init];
    
    //ZSNAIAECAINSViewController *vc = [[ZSNAIAECAINSViewController alloc] init];
    
    //ZSNChooseAudioProfileVC *vc = [[ZSNChooseAudioProfileVC alloc] init];
    
    //ZSNAudioVerticalAnimationViewController *vc = [[ZSNAudioVerticalAnimationViewController alloc] init];
    //ZSNAudioVideoViewController *vc = [[ZSNAudioVideoViewController alloc] init];
    
    //ZSNAPILiZiViewController *vc = [[ZSNAPILiZiViewController alloc] init];
    ZSNMPMusicPlayerVC *vc = [[ZSNMPMusicPlayerVC alloc] init];
    
    //ZSNGaoQingViewController *vc = [[ZSNGaoQingViewController alloc] init];
//    ZSNTestViewController *vc = [[ZSNTestViewController a]];
    
    //ZSNTestViewController *vc =
    
    
    //ZSNTestViewController *vc = [[ZSNTestViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//-(void)btnDaXiaoLiuPageAction: (UIButton *)button {
//    ZSNDaXiaoLiuViewController * vc = [[ZSNDaXiaoLiuViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


@end
