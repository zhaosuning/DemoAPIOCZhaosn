//
//  ZSNSSHeChangerViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/3/21.
//

#import "ZSNSSHeChangerViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>


@interface ZSNSSHeChangerViewController ()<AgoraRtcEngineDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit *agoraKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;

@property (nonatomic, strong) UIButton *btnClickyixia;

@end

@implementation ZSNSSHeChangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height + 200);
    [self.view addSubview:scrollView];
    
    UIView *viewbg = [[UIView alloc] init];
    viewbg.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height + 200);
    viewbg.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:viewbg];
    
    UILabel * lblTopTitle = [[UILabel alloc] init];
    lblTopTitle.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 50, 45, 100, 40);
    lblTopTitle.text = @"接口调用";
    lblTopTitle.textColor = [UIColor blueColor];
    lblTopTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTopTitle];
    
    //UIButton 初始化建议用buttonWithType
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(20 , 45, 70, 40);
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.backgroundColor = [UIColor greenColor];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnBack.layer setCornerRadius:20];
    [btnBack.layer setMasksToBounds:YES];
    [btnBack addTarget:self action:@selector(btnBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    
    self.localView = [[UIView alloc] init];
    self.localView.backgroundColor = [UIColor lightGrayColor];
    self.localView.frame = CGRectMake(0, 90, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
    [viewbg addSubview:self.localView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.backgroundColor = [UIColor grayColor];
    self.remoteView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.width + 100, 200, 200);
    [viewbg addSubview:self.remoteView];
    
    UIButton *btnClickyixia = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClickyixia.frame = CGRectMake(20, 100, 200, 40);
    [btnClickyixia setTitle:@"点击" forState:UIControlStateNormal];
    [btnClickyixia setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnClickyixia.backgroundColor = [UIColor greenColor];
    btnClickyixia.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnClickyixia addTarget:self action:@selector(btnClickyixiaAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnClickyixia];
    
    UIButton *btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJoinChannel.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 100, 170, 40);
    [btnJoinChannel setTitle:@"加入频道" forState:UIControlStateNormal];
    [btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor greenColor];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnJoinChannel];
    
}


-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
}

-(void)btnClickyixiaAction:(UIButton *) button {
    NSLog(@"打印了 点击btnClickyixiaAction");
    
}

-(void)btnJoinChannelAction:(UIButton *) button {
    NSLog(@"打印了 点击btnJoinChannelAction");
    
    [self initAgoraRtcInfo];
}

-(void)initAgoraRtcInfo {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:AppId delegate:self];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    AgoraVideoEncoderConfiguration *videoEncoderConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:720 height:1280 frameRate:AgoraVideoFrameRateFps24 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoEncoderConfig];
    
//    NSInteger iresult = [self.agoraKit joinChannelByToken:Token channelId:channelname info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
//        NSLog(@"打印了 joinChannelByToken joinSuccess");
//    }];
    
    NSInteger iresult2 = [self.agoraKit joinChannelByToken:Token channelId:channelname info:nil uid:0 joinSuccess:nil];
    NSLog(@"打印了 joinChannelByToken result值 %ld",(long)iresult2);
    
}

-(void)showLocalView {
    AgoraRtcVideoCanvas *videocanvas = [[AgoraRtcVideoCanvas alloc] init];
    videocanvas.view = self.localView;
    videocanvas.uid = 0;
    videocanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupLocalVideo:videocanvas];
    NSLog(@"打印了 setupLocalVideo初始化本地视图");
}

-(void)showRemoteVideo:(NSInteger ) uid {
    AgoraRtcVideoCanvas * videocanvas = [[AgoraRtcVideoCanvas alloc] init];
    videocanvas.view = self.remoteView;
    videocanvas.uid = uid;
    videocanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupRemoteVideo:videocanvas];
    NSLog(@"打印了 setupRemoteVideo初始化远端用户视图");
}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinChannel 成功加入频道回调 uid %lu",(unsigned long)uid);
    [self showLocalView];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinedOfUid远端用户（通信场景）/主播（直播场景）加入当前频道回调 uid %lu",(unsigned long)uid);
    [self showRemoteVideo:uid];
}

@end
