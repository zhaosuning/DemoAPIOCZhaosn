//
//  ZSNVideoBroadcastViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/9/14.
//

#import "ZSNVideoBroadcastViewController.h"
//#import <AgoraRtcKit/AgoraRtcKit.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNVideoBroadcastViewController ()<AgoraRtcEngineDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;

@end

@implementation ZSNVideoBroadcastViewController

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
    [btnBack.layer setCornerRadius:20];
    [btnBack.layer setMasksToBounds:YES];
    [btnBack addTarget:self action:@selector(btnBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    
    self.localView = [[UIView alloc] init];
    self.localView.backgroundColor = [UIColor lightGrayColor];
    self.localView.frame = CGRectMake(10, 100, 300, 300);
    [viewbg addSubview:self.localView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.backgroundColor = [UIColor redColor];
    self.remoteView.frame = CGRectMake(10, 410, 300, 300);
    [viewbg addSubview:self.remoteView];
    
    UIButton *btnMuteLocalAudio = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMuteLocalAudio.frame = CGRectMake(20, 100, 200, 40);
    [btnMuteLocalAudio setTitle:@"MuteLocalAudio YES" forState:UIControlStateNormal];
    [btnMuteLocalAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnMuteLocalAudio.backgroundColor = [UIColor greenColor];
    btnMuteLocalAudio.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnMuteLocalAudio addTarget:self action:@selector(btnMuteLocalAudioAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnMuteLocalAudio];
    
    UIButton *btnMuteLocalAudioNO = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMuteLocalAudioNO.frame = CGRectMake(20, 160, 200, 40);
    [btnMuteLocalAudioNO setTitle:@"MuteLocalAudio NO" forState:UIControlStateNormal];
    [btnMuteLocalAudioNO setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnMuteLocalAudioNO.backgroundColor = [UIColor greenColor];
    btnMuteLocalAudioNO.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnMuteLocalAudioNO addTarget:self action:@selector(btnMuteLocalAudioNOAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnMuteLocalAudioNO];
    
    UIButton *btnRoleBroadcaster = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRoleBroadcaster.frame = CGRectMake(20, 220, 200, 40);
    [btnRoleBroadcaster setTitle:@"Role Broadcaster" forState:UIControlStateNormal];
    [btnRoleBroadcaster setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnRoleBroadcaster.backgroundColor = [UIColor greenColor];
    btnRoleBroadcaster.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnRoleBroadcaster addTarget:self action:@selector(btnRoleBroadcasterAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnRoleBroadcaster];
    
    UIButton *btnRoleAudience = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRoleAudience.frame = CGRectMake(20, 280, 200, 40);
    [btnRoleAudience setTitle:@"Role Audience" forState:UIControlStateNormal];
    [btnRoleAudience setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnRoleAudience.backgroundColor = [UIColor greenColor];
    btnRoleAudience.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnRoleAudience addTarget:self action:@selector(btnRoleAudienceAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnRoleAudience];
    
    [self initAgoraRtcInfo];
}

-(void) viewWillDisappear:(BOOL)animated {
    [AgoraRtcEngineKit destroy];
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

-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    [self.agoraKit setClientRole:AgoraClientRoleAudience];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileDefault];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:1280 height:720 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoConfig];
    
    //AgoraRtcChannelMediaOptions
    AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
    options.publishCameraTrack = YES;
    options.publishMicrophoneTrack = YES;
    //options.clientRoleType = AgoraClientRoleBroadcaster;
   int result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:options joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        NSLog(@"打印了 joinChannelByToken 成功");
       [self showLocalVideo];
    }];
    
    
    //int result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:options];
    
    NSLog(@"打印了 joinChannelByToken result值 %d",result);
}

-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    [self.agoraKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
}

-(void)btnMuteLocalAudioAction:(UIButton *) button {
    NSLog(@"打印了 点击了 btnMuteLocalAudioAction");
    
    [self.agoraKit muteLocalAudioStream:YES];
}

-(void)btnMuteLocalAudioNOAction:(UIButton *)button {
    NSLog(@"打印了 点击了 btnMuteLocalAudioAction");
    
    [self.agoraKit muteLocalAudioStream:NO];
}

-(void)btnRoleBroadcasterAction :(UIButton *) button {
    NSLog(@"打印了 点击了 btnRoleBroadcasterAction");
    
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
}

-(void)btnRoleAudienceAction :(UIButton *) button {
    NSLog(@"打印了 点击了 btnRoleAudienceAction");
    
    [self.agoraKit setClientRole:AgoraClientRoleAudience];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinChannel uid %lu",(unsigned long)uid);
    [self showLocalVideo];
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

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioPublishStateChange:(NSString *)channelId oldState:(AgoraStreamPublishState)oldState newState:(AgoraStreamPublishState)newState elapseSinceLastState:(int)elapseSinceLastState
{
    NSLog(@"打印了 channelId %@ , oldState %ld , newState %ld",channelId,(long)oldState,(long)newState);
}

@end
