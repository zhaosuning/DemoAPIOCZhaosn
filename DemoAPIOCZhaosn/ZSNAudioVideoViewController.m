//
//  ZSNAudioVideoViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/11/30.
//

#import "ZSNAudioVideoViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNAudioVideoViewController ()<AgoraRtcEngineDelegate>
@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;

@property (nonatomic, strong) UIButton *btnRoleChoose;

@property (nonatomic, strong) UIButton *btnJoinChannel;

@property (nonatomic, strong) UIButton *btnSendAudio;

@property (nonatomic, strong) UIButton *btnSendVideo;

@property (nonatomic, strong) UIButton *btnCloseAudio;

@property (nonatomic, strong) UIButton *btnCloseVideo;

@property (nonatomic, assign) BOOL isJoinChannel;
@property (nonatomic, assign) BOOL isRoleBroadcaster;
@property (nonatomic, assign) BOOL isSendAudio;
@property (nonatomic, assign) BOOL isSendVideo;



@end

@implementation ZSNAudioVideoViewController

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
    lblTopTitle.text = @"音视频直播";
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
    
    self.btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnJoinChannel.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 100, 170, 40);
    [self.btnJoinChannel setTitle:@"加入频道" forState:UIControlStateNormal];
    [self.btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnJoinChannel.backgroundColor = [UIColor greenColor];
    self.btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnJoinChannel];
    
    self.btnRoleChoose = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnRoleChoose.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 160, 170, 40);
    [self.btnRoleChoose setTitle:@"点击变为主播" forState:UIControlStateNormal];
    [self.btnRoleChoose setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnRoleChoose.backgroundColor = [UIColor greenColor];
    self.btnRoleChoose.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnRoleChoose addTarget:self action:@selector(btnRoleChooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnRoleChoose];
    
    
    self.btnSendAudio = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSendAudio.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 220, 170, 40);
    [self.btnSendAudio setTitle:@"打开音频默认发送" forState:UIControlStateNormal];
    [self.btnSendAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnSendAudio.backgroundColor = [UIColor greenColor];
    self.btnSendAudio.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnSendAudio addTarget:self action:@selector(btnSendAudioAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnSendAudio];
    
    
    self.btnSendVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSendVideo.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 280, 170, 40);
    [self.btnSendVideo setTitle:@"打开视频默认发送" forState:UIControlStateNormal];
    [self.btnSendVideo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnSendVideo.backgroundColor = [UIColor greenColor];
    self.btnSendVideo.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnSendVideo addTarget:self action:@selector(btnSendVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnSendVideo];
    
    self.isJoinChannel = NO;
    self.isRoleBroadcaster = NO;
    self.isSendAudio = NO;
    self.isSendVideo = NO;
    
    
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
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    
    //[self.agoraKit disableAudio];
    //[self.agoraKit disableVideo];
    [self.agoraKit muteLocalAudioStream:YES];
    [self.agoraKit enableLocalAudio:NO];
    
    [self.agoraKit muteLocalVideoStream:YES];
    [self.agoraKit enableLocalVideo:NO];
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:848 height:480 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoConfig];
    
    //AgoraRtcChannelMediaOptions
    AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
    
    NSInteger result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:options joinSuccess:nil];
    
    NSLog(@"打印了 joinChannelByToken result值 %ld",(long)result);
}

-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    
    __weak typeof(self) weakSelf = self;
    
    [self.agoraKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];
}

-(void)btnRoleChooseAction:(UIButton *) button {
    NSLog(@"打印了 点击了 btnRoleChooseAction");
    if (!self.isRoleBroadcaster) {
        [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    }
    else {
        [self.agoraKit setClientRole:AgoraClientRoleAudience];
    }
    
}

-(void)btnJoinChannelAction:(UIButton *) button {
    NSLog(@"打印了 点击了 btnJoinChannelAction");
    
    [self initAgoraRtcInfo];
    
}

-(void)btnSendAudioAction:(UIButton *) button {
    if (!self.isSendAudio) {
        self.isSendAudio = YES;
        
        [self.btnSendAudio setTitle:@"关闭音频" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        NSInteger i = [self.agoraKit enableLocalAudio:YES];
        if (i == 0 ) {
            
        }
        else {
            [self.agoraKit muteLocalAudioStream:YES];
            [self.agoraKit enableLocalAudio:NO];
        }
        NSLog(@"打印了 开关音频 enableLocalAudio YES i = %ld",(long)i);
    }
    else {
        NSInteger imute = [self.agoraKit muteLocalAudioStream:YES];
        NSInteger idislocalaudio = [self.agoraKit enableLocalAudio:NO];
        //NSInteger i = [self.agoraKit disableAudio];
        if (idislocalaudio == 0) {
            
        }
        else {
            self.isSendAudio = YES;
            [self.btnSendAudio setTitle:@"关闭音频" forState:UIControlStateNormal];
            [self.btnSendAudio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        NSLog(@"打印了 开关音频 enableLocalAudio NO, imute = %ld , idislocalaudio = %ld",(long)imute,(long)idislocalaudio);
    }
    
}

-(void)btnSendVideoAction:(UIButton *) button {
    if (!self.isSendVideo) {
        self.isSendVideo = YES;
        [self.btnSendVideo setTitle:@"关闭视频" forState:UIControlStateNormal];
        [self.btnSendVideo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        NSInteger i = [self.agoraKit enableLocalVideo:YES];
        if (i == 0) {
            
        }
        else {
            [self.agoraKit muteLocalVideoStream:YES];
            [self.agoraKit enableLocalVideo:NO];
        }
        
        NSLog(@"打印了 打开视频 enableLocalVideo i = %ld",(long)i);
    }
    else {
        NSInteger imuteview = [self.agoraKit muteLocalVideoStream:YES];
        NSInteger ienableNoVideo = [self.agoraKit enableLocalVideo:NO];
        if (ienableNoVideo == 0) {
            
        }
        else {
            self.isSendVideo = YES;
            [self.btnSendVideo setTitle:@"关闭视频" forState:UIControlStateNormal];
            [self.btnSendVideo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        NSLog(@"打印了 关闭视频 enableLocalVideo ienableNoVideo = %ld,imuteview = %ld",(long)ienableNoVideo,(long)imuteview);
    }
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
    //[self showLocalVideo];
    
    self.isJoinChannel = YES;
    self.btnJoinChannel.enabled = NO;
    [self showLocalVideo];
    
    [self.btnJoinChannel setTitle:@"已加入频道" forState:UIControlStateNormal];
    [self.btnJoinChannel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinedOfUid uid %lu",(unsigned long)uid);
    [self showRemoteVideo:uid];
}

-(void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole {
    NSLog(@"打印了 didClientRoleChanged oldRole %lu ,newRole %lu",(unsigned long)oldRole,(unsigned long)newRole);
    
    if (newRole == AgoraClientRoleBroadcaster) {
        self.isRoleBroadcaster = YES;
        [self.btnRoleChoose setTitle:@"点击变为观众" forState:UIControlStateNormal];
        [self.btnRoleChoose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if (newRole == AgoraClientRoleAudience) {
        self.isRoleBroadcaster = NO;
        [self.btnRoleChoose setTitle:@"点击变为主播" forState:UIControlStateNormal];
        [self.btnRoleChoose setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

-(void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChangeFailed:(AgoraClientRoleChangeFailedReason)reason currentRole:(AgoraClientRole)currentRole {
    NSLog(@"打印了 didClientRoleChangeFailed reason %lu ,currentRole %lu",(unsigned long)reason,(unsigned long)currentRole);
}

//- (void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole newRoleOptions:(AgoraClientRoleOptions *)newRoleOptions {
//    NSLog(@"打印了 didClientRoleChanged oldRole %lu ,newRole %lu",(unsigned long)oldRole,(unsigned long)newRole);
//
//    if (newRole == AgoraClientRoleBroadcaster) {
//        self.isRoleBroadcaster = YES;
//        [self.btnRoleChoose setTitle:@"点击变为观众" forState:UIControlStateNormal];
//        [self.btnRoleChoose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    }
//    else if (newRole == AgoraClientRoleAudience) {
//        self.isRoleBroadcaster = NO;
//        [self.btnRoleChoose setTitle:@"点击变为主播" forState:UIControlStateNormal];
//        [self.btnRoleChoose setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    }
//}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine localAudioStateChanged:(AgoraAudioLocalState)state error:(AgoraAudioLocalError)error {
    NSLog(@"打印了 localAudioStateChanged state %lu ,error %lu",(unsigned long)state,error);
    
    if (state == AgoraAudioLocalStateStopped) {
        self.isSendAudio = NO;
        [self.btnSendAudio setTitle:@"打开音频默认发送" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    else if(state == AgoraAudioLocalStateEncoding || state == AgoraAudioLocalStateRecording) {
        self.isSendAudio = YES;
        [self.btnSendAudio setTitle:@"关闭音频" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if(state == AgoraAudioLocalStateFailed) {
        [self.agoraKit muteLocalAudioStream:YES];
    }
    
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
    NSLog(@"打印了 didAudioPublishStateChange channelId %@ , oldState %ld , newState %ld",channelId,(long)oldState,(long)newState);
    if (newState == AgoraStreamPublishStatePublished) {
        self.isSendAudio = YES;
        [self.btnSendAudio setTitle:@"关闭音频" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
}

-(void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioMuted:(BOOL)muted byUid:(NSUInteger)uid {
    NSLog(@"打印了 didAudioMuted mute %d , uid %lu",muted,(unsigned long)uid);
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoPublishStateChange:(NSString *)channelId sourceType:(AgoraVideoSourceType)sourceType oldState:(AgoraStreamPublishState)oldState newState:(AgoraStreamPublishState)newState elapseSinceLastState:(int)elapseSinceLastState {
    
    if (newState == AgoraStreamPublishStatePublished) {
        self.isSendVideo = YES;
        [self.btnSendVideo setTitle:@"关闭视频" forState:UIControlStateNormal];
        [self.btnSendVideo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    NSLog(@"打印了 didVideoPublishStateChange oldState %ld, newState %ld",(long)oldState,(long)newState);
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine localVideoStateChangedOfState:(AgoraVideoLocalState)state error:(AgoraLocalVideoStreamError)error sourceType:(AgoraVideoSourceType)sourceType {
    NSLog(@"打印了 localVideoStateChangedOfState state %ld",(long)state);
}


//- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLocalVideoEnabled:(BOOL)enabled byUid:(NSUInteger)uid {
//
//}
//-(void) localvideo

-(void)rtcEngine:(AgoraRtcEngineKit *)engine localVideoStats:(AgoraRtcLocalVideoStats *)stats sourceType:(AgoraVideoSourceType)sourceType {
    NSLog(@"打印了 localVideoStats");
}

//-(void) rtcEngine:(AgoraRtcEngineKit *)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed sourceType:(AgoraVideoSourceType)sourceType {
//
//}

@end
