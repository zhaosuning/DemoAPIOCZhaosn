//
//  ZSNMultiChannelViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/10/12.
//

#import "ZSNMultiChannelViewController.h"

@interface ZSNMultiChannelViewController ()

@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;
@property (nonatomic, strong) AgoraRtcChannelMediaOptions *mediaoptions;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;
@property (nonatomic, strong) UIView * remoteExView;

@end

@implementation ZSNMultiChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height + 200);
    [self.view addSubview:scrollView];
    
    UIView *viewbg = [[UIView alloc] init];
    viewbg.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height + 200);
    viewbg.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:viewbg];
    
    UILabel * lblTopTitle = [[UILabel alloc] init];
    lblTopTitle.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 50, 45, 100, 40);
    lblTopTitle.text = @"直播页";
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
    [btnBack addTarget:self action:@selector(btnBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UIButton *btnJoinErChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJoinErChannel.frame = CGRectMake(150, 45, 150, 40);
    [btnJoinErChannel setTitle:@"加入第二个频道" forState:UIControlStateNormal];
    [btnJoinErChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnJoinErChannel.backgroundColor = [UIColor greenColor];
    btnJoinErChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnJoinErChannel addTarget:self action:@selector(btnJoinErChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJoinErChannel];
    
    self.localView = [[UIView alloc] init];
    self.localView.backgroundColor = [UIColor greenColor];
    self.localView.frame = CGRectMake(10, 100, 300, 300);
    [viewbg addSubview:self.localView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.backgroundColor = [UIColor redColor];
    self.remoteView.frame = CGRectMake(10, 410, 150, 150);
    [viewbg addSubview:self.remoteView];
    
    self.remoteExView = [[UIView alloc] init];
    self.remoteExView.backgroundColor = [UIColor lightGrayColor];
    self.remoteExView.frame = CGRectMake(170, 410, 150, 150);
    [viewbg addSubview:self.remoteExView];
    
    UIButton *btnShowRemExVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShowRemExVideo.frame = CGRectMake(150, 100, 150, 40);
    [btnShowRemExVideo setTitle:@"渲染远端Ex视频" forState:UIControlStateNormal];
    [btnShowRemExVideo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnShowRemExVideo.backgroundColor = [UIColor greenColor];
    btnShowRemExVideo.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnShowRemExVideo addTarget:self action:@selector(btnShowRemExVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShowRemExVideo];
    
    [self initAgoraRtcInfo];
    
    
}

-(void)showLocalVideo {
    AgoraRtcVideoCanvas * videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.view = self.localView;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;//AgoraVideoRenderModeHidden
    [self.agoraKit setupLocalVideo:videoCanvas];
    [self.agoraKit startPreview];
}

-(void)showRemoteVideo:(NSInteger) uid {
    AgoraRtcVideoCanvas *remoteVideo = [[AgoraRtcVideoCanvas alloc] init];
    remoteVideo.uid = uid;
    remoteVideo.view = self.remoteView;
    remoteVideo.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupRemoteVideo:remoteVideo];
}

-(void)showRemoteExVideo:(NSInteger) uid {
    AgoraRtcVideoCanvas *remoteVideo = [[AgoraRtcVideoCanvas alloc] init];
    remoteVideo.uid = uid;
    remoteVideo.view = self.remoteExView;
    remoteVideo.renderMode = AgoraVideoRenderModeHidden;
    //[self.agoraKit setupRemoteVideo:remoteVideo];
    
    AgoraRtcConnection *connnect = [[AgoraRtcConnection alloc] init];
    connnect.channelId = channelnameb;
    connnect.localUid = 2000;
    
    [self.agoraKit setupRemoteVideoEx:remoteVideo connection:connnect];
    
    
}

-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:1280 height:720 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoConfig];
    
    [self showLocalVideo];
    
    //AgoraRtcChannelMediaOptions
    //AgoraRtcChannelMediaOptions *mediaoptions = [[AgoraRtcChannelMediaOptions alloc] init];
    self.mediaoptions = [[AgoraRtcChannelMediaOptions alloc] init];
    self.mediaoptions.publishCameraTrack = YES;
    self.mediaoptions.publishMicrophoneTrack = YES;
    self.mediaoptions.autoSubscribeAudio = YES;
    self.mediaoptions.autoSubscribeVideo = YES;
    self.mediaoptions.clientRoleType = AgoraClientRoleBroadcaster;
    int result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:self.mediaoptions joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        NSLog(@"打印了 joinChannelByToken 成功");
    }];
    
    NSLog(@"打印了 joinChannelByToken result值 %d",result);
}

-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) btnJoinErChannelAction:(UIButton *) button {
    NSLog(@"打印了 btnJoinErChannelAction");
    AgoraRtcChannelMediaOptions *mediaoptions2 = [[AgoraRtcChannelMediaOptions alloc] init];
    mediaoptions2.publishCameraTrack = NO;
    mediaoptions2.publishMicrophoneTrack = NO;
    mediaoptions2.autoSubscribeAudio = YES;
    mediaoptions2.autoSubscribeVideo = YES;
    mediaoptions2.clientRoleType = AgoraClientRoleBroadcaster;
    
    AgoraRtcConnection *connnect = [[AgoraRtcConnection alloc] init];
    connnect.channelId = channelnameb;
    connnect.localUid = 2000;
    int result = [self.agoraKit joinChannelExByToken:Tokenb connection:connnect delegate:self mediaOptions:mediaoptions2 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        NSLog(@"打印了 joinChannelExByToken 成功");
        
    }];
    
    NSLog(@"打印了 joinChannelExByToken result值 %d",result);
}

-(void)btnShowRemExVideoAction:(UIButton *)button {
    [self showRemoteExVideo:200];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinChannel uid %lu",(unsigned long)uid);
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinedOfUid uid %lu",(unsigned long)uid);
    [self showRemoteVideo:uid];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportRtcStats:(AgoraChannelStats *)stats {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine localAudioStats:(AgoraRtcLocalAudioStats *)stats {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine remoteVideoStats:(AgoraRtcRemoteVideoStats *)stats {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine remoteAudioStats:(AgoraRtcRemoteAudioStats *)stats {
    
}



@end
