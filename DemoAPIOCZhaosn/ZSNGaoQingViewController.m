//
//  ZSNGaoQingViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/5/12.
//

#import "ZSNGaoQingViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNGaoQingViewController ()<AgoraVideoFrameDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit *agoraKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;

@property (nonatomic, assign) BOOL isReceiveTerminal;//作为接收端，默认 NO

@end

@implementation ZSNGaoQingViewController

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
    btnBack.frame = CGRectMake(0 , 45, 70, 40);
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
    self.localView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    //[viewbg addSubview:self.localView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.backgroundColor = [UIColor grayColor];
    //self.remoteView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.width + 100, 200, 200);
    self.remoteView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [viewbg addSubview:self.remoteView];
    
    UIButton *btnInitRtcEngine = [UIButton buttonWithType:UIButtonTypeCustom];
    btnInitRtcEngine.frame = CGRectMake(0, 90, 140, 40);
    [btnInitRtcEngine setTitle:@"初始化RtcEngine" forState:UIControlStateNormal];
    [btnInitRtcEngine setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnInitRtcEngine.backgroundColor = [UIColor greenColor];
    btnInitRtcEngine.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnInitRtcEngine addTarget:self action:@selector(btnInitRtcEngineAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnInitRtcEngine];
    
    UIButton *btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJoinChannel.frame = CGRectMake(0, 140, 70, 40);
    [btnJoinChannel setTitle:@"加入频道" forState:UIControlStateNormal];
    [btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor greenColor];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnJoinChannel];
    
    
    UIButton *btnOpenH265 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOpenH265.frame = CGRectMake(0, 190, 70, 40);
    [btnOpenH265 setTitle:@"开H265" forState:UIControlStateNormal];
    [btnOpenH265 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnOpenH265.backgroundColor = [UIColor greenColor];
    btnOpenH265.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnOpenH265 addTarget:self action:@selector(btnOpenH265Action:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnOpenH265];
    
    
    UIButton *btnOpenChaoFen = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOpenChaoFen.frame = CGRectMake(0, 240, 70, 40);
    [btnOpenChaoFen setTitle:@"开超分" forState:UIControlStateNormal];
    [btnOpenChaoFen setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnOpenChaoFen.backgroundColor = [UIColor greenColor];
    btnOpenChaoFen.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnOpenChaoFen addTarget:self action:@selector(btnOpenChaoFenAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnOpenChaoFen];
    
    
    UIButton *btnOpenChaoHuaZhi = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOpenChaoHuaZhi.frame = CGRectMake(0, 290, 90, 40);
    [btnOpenChaoHuaZhi setTitle:@"开超级画质" forState:UIControlStateNormal];
    [btnOpenChaoHuaZhi setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnOpenChaoHuaZhi.backgroundColor = [UIColor greenColor];
    btnOpenChaoHuaZhi.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnOpenChaoHuaZhi addTarget:self action:@selector(btnOpenChaoHuaZhiAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnOpenChaoHuaZhi];
    
    UIButton *btnSendTerminal = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSendTerminal.frame = CGRectMake(0, 290, 90, 40);
    [btnSendTerminal setTitle:@"作为发送端" forState:UIControlStateNormal];
    [btnSendTerminal setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnSendTerminal.backgroundColor = [UIColor greenColor];
    btnSendTerminal.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnSendTerminal addTarget:self action:@selector(btnSendTerminalAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnSendTerminal];
    
    UIButton *btnReceiveTerminal = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReceiveTerminal.frame = CGRectMake(0, 290, 90, 40);
    [btnReceiveTerminal setTitle:@"作为接收端" forState:UIControlStateNormal];
    [btnReceiveTerminal setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnReceiveTerminal.backgroundColor = [UIColor greenColor];
    btnReceiveTerminal.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnReceiveTerminal addTarget:self action:@selector(btnReceiveTerminalAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnReceiveTerminal];
    
}

-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
}

/*
 
 {
   "che.video.videoCodecIndex": 2,
   "che.video.min_enc_level": 1,
   "rtc.video.enable_sr": {
     "enabled": true,
     "mode": 2
   },
   "rtc.video.enable_pvc": true
 }
 
 */

-(void)btnOpenH265Action:(UIButton *)button {
    NSLog(@"打印了 开启H265");
    [self.agoraKit setParameters:@"{\"che.video.videoCodecIndex\": 2}"];
}

-(void)btnOpenChaoFenAction:(UIButton *) button {
    NSLog(@"打印了 开启 超分");
    [self.agoraKit setParameters:@"{\"rtc.video.enable_sr\": {\"enabled\": true,\"mode\": 2}}"];
}

-(void)btnOpenChaoHuaZhiAction:(UIButton *) button {
    NSLog(@"打印了 开启 超级画质");
    [self.agoraKit setParameters:@"{\"rtc.video.enable_sr\": {\"enabled\": true,\"mode\": 2}}"];
    [self.agoraKit setParameters:@"{\"rtc.video.sr_type\": 20}"];
}

-(void) btnSendTerminalAction:(UIButton *)button {
    NSLog(@"打印了 作为发送端");
}

-(void) btnReceiveTerminalAction:(UIButton *)button {
    NSLog(@"打印了 作为接收端");
}

-(void) btnInitRtcEngineAction :(UIButton *) button {
    NSLog(@"打印了 点击btnInitRtcEngineAction");
    
    [self initAgoraRtcInfo];
}

-(void) btnJoinChannelAction: (UIButton *) button {
    NSLog(@"打印了 点击btnJoinChannelAction");
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    AgoraVideoEncoderConfiguration *videoEncoderConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:720 height:1280 frameRate:AgoraVideoFrameRateFps24 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoEncoderConfig];
    
    NSInteger iresult2 = [self.agoraKit joinChannelByToken:Token channelId:channelname info:nil uid:0 joinSuccess:nil];
    NSLog(@"打印了 joinChannelByToken result值 %ld",(long)iresult2);
}

-(void)initAgoraRtcInfo {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:AppId delegate:self];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
//    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
//    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
//
//    [self.agoraKit enableAudio];
//    [self.agoraKit enableVideo];
//
//    AgoraVideoEncoderConfiguration *videoEncoderConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:720 height:1280 frameRate:AgoraVideoFrameRateFps24 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
//    [self.agoraKit setVideoEncoderConfiguration:videoEncoderConfig];
    
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
    //[self showLocalView];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinedOfUid远端用户（通信场景）/主播（直播场景）加入当前频道回调 uid %lu",(unsigned long)uid);
    [self showRemoteVideo:uid];
}

@end
