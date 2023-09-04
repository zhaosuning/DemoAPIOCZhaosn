//
//  ZSNAPILiZiViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/4/7.
//

#import "ZSNAPILiZiViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import <AgoraRtcKit/AgoraRtcMediaPlayerProtocol.h>
#import <AgoraRtcKit/AgoraRtcKit.h>

@interface ZSNAPILiZiViewController ()<AgoraRtcEngineDelegate, AgoraAudioFrameDelegate, AgoraVideoFrameDelegate, AgoraRtcMediaPlayerDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit *agoraKit;

@property (nonatomic, weak) id <AgoraRtcMediaPlayerProtocol> mediaPlayerKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;

@property (nonatomic, strong) UIButton *btnClickyixia;

@end

@implementation ZSNAPILiZiViewController

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
    
    UIButton *btnInitRtcEngine = [UIButton buttonWithType:UIButtonTypeCustom];
    btnInitRtcEngine.frame = CGRectMake(20, 100, 200, 40);
    [btnInitRtcEngine setTitle:@"初始化RtcEngine" forState:UIControlStateNormal];
    [btnInitRtcEngine setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnInitRtcEngine.backgroundColor = [UIColor greenColor];
    btnInitRtcEngine.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnInitRtcEngine addTarget:self action:@selector(btnInitRtcEngineAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnInitRtcEngine];
    
    UIButton *btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJoinChannel.frame = CGRectMake(20, 150, 170, 40);
    [btnJoinChannel setTitle:@"加入频道" forState:UIControlStateNormal];
    [btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor greenColor];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnJoinChannel];
    
    UIButton *btnChannelMediaRelay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChannelMediaRelay.frame = CGRectMake(20, 200, 220, 40);
    [btnChannelMediaRelay setTitle:@"跨频道流转发" forState:UIControlStateNormal];
    [btnChannelMediaRelay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnChannelMediaRelay.backgroundColor = [UIColor greenColor];
    btnChannelMediaRelay.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnChannelMediaRelay addTarget:self action:@selector(btnChannelMediaRelayAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnChannelMediaRelay];
    
    UIButton *btnEarMonitoring = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEarMonitoring.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 100, 220, 40);
    [btnEarMonitoring setTitle:@"开启耳返" forState:UIControlStateNormal];
    [btnEarMonitoring setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnEarMonitoring.backgroundColor = [UIColor greenColor];
    btnEarMonitoring.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnEarMonitoring addTarget:self action:@selector(btnEarMonitoringAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnEarMonitoring];
    
    UIButton *btnStartAudioMix = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStartAudioMix.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 150, 220, 40);
    [btnStartAudioMix setTitle:@"startAudioMixing" forState:UIControlStateNormal];
    [btnStartAudioMix setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnStartAudioMix.backgroundColor = [UIColor greenColor];
    btnStartAudioMix.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnStartAudioMix addTarget:self action:@selector(btnStartAudioMixAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnStartAudioMix];
    
    UIButton *btnMediaPlayer = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMediaPlayer.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 200, 220, 40);
    [btnMediaPlayer setTitle:@"MediaPlayer" forState:UIControlStateNormal];
    [btnMediaPlayer setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnMediaPlayer.backgroundColor = [UIColor greenColor];
    btnMediaPlayer.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnMediaPlayer addTarget:self action:@selector(btnMediaPlayerAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnMediaPlayer];
    
    
}


-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    
    //[self.agoraKit stopPreview];
//    [self.agoraKit joinChannelExByToken:<#(NSString * _Nullable)#> connection:<#(AgoraRtcConnection * _Nonnull)#> delegate:<#(id<AgoraRtcEngineDelegate> _Nullable)#> mediaOptions:<#(AgoraRtcChannelMediaOptions * _Nonnull)#> joinSuccess:<#^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed)joinSuccessBlock#>];
    
    //[self.agoraKit joinChannelExByToken:@"" connection:nil delegate:self mediaOptions:@"" joinSuccess:nil];
    //[self.agoraKit leaveChannelEx:nil leaveChannelBlock:nil];
    
    
    
    //[self.agoraKit destroyMediaPlayer:self.mediaPlayerKit];
    
    //[self.agoraKit createDataStream:1 config:nil];
    
    //[self.agoraKit sendStreamMessage:1 data:nil];
    
    
    //[self.mediaPlayerKit open:@"" startPos:0];
    
}

-(void)btnInitRtcEngineAction:(UIButton *) button {
    NSLog(@"打印了 点击btnInitRtcEngineAction");
    
    [self initAgoraRtcInfo];
    
}

-(void)btnMediaPlayerAction:(UIButton *) button {
    NSLog(@"打印了 点击btnMediaPlayerAction");
    //[self.mediaPlayerKit o];
    //self.mediaPlayerKit
    
    [self.mediaPlayerKit play];
    
}

-(void)btnEarMonitoringAction:(UIButton *) button {
    NSLog(@"打印了 点击btnEarMonitoringAction");
    //AgoraEarMonitoringFilterType
    [self.agoraKit enableInEarMonitoring:YES includeAudioFilters:AgoraEarMonitoringFilterBuiltInAudioFilters];
    [self.agoraKit setInEarMonitoringVolume:100];
    
    //设置耳返的音频数据格式
    //AgoraAudioRawFrameOperationMode
    [self.agoraKit setEarMonitoringAudioFrameParametersWithSampleRate:44100 channel:2 mode:AgoraAudioRawFrameOperationModeReadWrite samplesPerCall:882];
    
}

-(void) btnChannelMediaRelayAction:(UIButton *)button {
    NSLog(@"打印了 点击btnChannelMediaRelayAction");
    //AgoraChannelMediaRelayConfiguration
    
    AgoraChannelMediaRelayConfiguration * mediaRelayConfig = [[AgoraChannelMediaRelayConfiguration alloc] init];
    AgoraChannelMediaRelayInfo * sourceMediaRelayInfo = [[AgoraChannelMediaRelayInfo alloc] initWithToken:Token];
    mediaRelayConfig.sourceInfo = sourceMediaRelayInfo;
    [mediaRelayConfig setSourceInfo:sourceMediaRelayInfo];
    
    AgoraChannelMediaRelayInfo * destinationMediaRelayInfo = [[AgoraChannelMediaRelayInfo alloc] initWithToken:Tokenb];
    destinationMediaRelayInfo.channelName = channelnameb;
    [mediaRelayConfig setDestinationInfo:destinationMediaRelayInfo forChannelName:channelnameb];
    
    [self.agoraKit startChannelMediaRelay:mediaRelayConfig];
}

-(void)btnStartAudioMixAction:(UIButton *)button {
    NSLog(@"打印了 点击btnStartAudioMixAction");
    NSString *strmusicurl = [[NSBundle mainBundle] pathForResource:@"daojiangxing" ofType:@"mp3"];
    [self.agoraKit startAudioMixing:strmusicurl loopback:NO cycle:-1 startPos:0];
    
}

-(void)btnJoinChannelAction:(UIButton *) button {
    NSLog(@"打印了 点击btnJoinChannelAction");
    
    //    NSInteger iresult = [self.agoraKit joinChannelByToken:Token channelId:channelname info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
    //        NSLog(@"打印了 joinChannelByToken joinSuccess");
    //    }];
    
    NSInteger iresult2 = [self.agoraKit joinChannelByToken:Token channelId:channelname info:nil uid:0 joinSuccess:nil];
    NSLog(@"打印了 joinChannelByToken result值 %ld",(long)iresult2);
    
}

-(void)initAgoraRtcInfo {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:AppId delegate:self];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    
    [self.agoraKit setAudioFrameDelegate:self];//注册音频观测器对象
    //AgoraAudioRawFrameOperationMode
    [self.agoraKit setRecordingAudioFrameParametersWithSampleRate:44100 channel:2 mode:AgoraAudioRawFrameOperationModeReadWrite samplesPerCall:882];//设置采集的原始音频数据格式
    [self.agoraKit setPlaybackAudioFrameParametersWithSampleRate:44100 channel:2 mode:AgoraAudioRawFrameOperationModeReadWrite samplesPerCall:882];//设置播放的音频格式
    [self.agoraKit setMixedAudioFrameParametersWithSampleRate:44100 channel:2 samplesPerCall:882];//设置 onMixedAudioFrame 报告的音频数据格式
    [self.agoraKit setPlaybackAudioFrameBeforeMixingParametersWithSampleRate:882 channel:2];//设置 onPlaybackAudioFrameBeforeMixing 报告的音频数据格式
    
    [self.agoraKit setParameters:@"{\"rtc.audio_mixing.pos_changed_cb_interval_ms\": 100}"];
    
    [self.agoraKit setVideoFrameDelegate:self];//注册原始视频观测器对象
    
    [self.agoraKit enableAudio];
    [self.agoraKit enableAudioVolumeIndication:100 smooth:3 reportVad:YES];
    
    [self.agoraKit enableVideo];
    
    AgoraVideoEncoderConfiguration *videoEncoderConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:720 height:1280 frameRate:AgoraVideoFrameRateFps24 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoEncoderConfig];
    
    
    self.mediaPlayerKit = [self.agoraKit createMediaPlayerWithDelegate:self];
    [self.mediaPlayerKit setPlayerOption:@"play_pos_change_callback" value:100];
    //NSString *strmusicurl = [[NSBundle mainBundle] pathForResource:@"daojiangxing" ofType:@"mp3"];
    //NSString *strmusicurl = @"rtmp://push.webdemo.agoraio.cn/lbhd/zsncna";
    [self.mediaPlayerKit setView:self.remoteView];
    NSString *strmusicurl = @"rtmp://pull.webdemo.agoraio.cn/lbhd/zsncna";
    [self.mediaPlayerKit open:strmusicurl startPos:0];
    
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



- (void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole newRoleOptions:(AgoraClientRoleOptions *)newRoleOptions {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didRejoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLeaveChannelWithStats:(AgoraChannelStats *)stats {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
    
}



- (void)rtcEngine:(AgoraRtcEngineKit *)engine connectionChangedToState:(AgoraConnectionState)state reason:(AgoraConnectionChangedReason)reason {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteAudioFrameOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine tokenPrivilegeWillExpire:(NSString *)token {
    
    
    
}


//audioMixingStateChanged
- (void)rtcEngine:(AgoraRtcEngineKit *)engine audioMixingStateChanged:(AgoraAudioMixingStateType)state reasonCode:(AgoraAudioMixingReasonCode)reasonCode {
    
}

//reportRtcStats
- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportRtcStats:(AgoraChannelStats *)stats {
    
}

//audioQualityOfUid
- (void)rtcEngine:(AgoraRtcEngineKit *)engine audioQualityOfUid:(NSUInteger)uid quality:(AgoraNetworkQuality)quality delay:(NSUInteger)delay lost:(NSUInteger)lost {
    //是否已废弃？
}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
    //是否已废弃？
}

//rtcEngineConnectionDidInterrupted
- (void)rtcEngineConnectionDidInterrupted:(AgoraRtcEngineKit *)engine {
    //是否已废弃？
}

- (void)rtcEngineDidAudioEffectFinish:(AgoraRtcEngineKit *)engine soundId:(int)soundId {
    //是否已废弃？
}

//rtcEngineConnectionDidBanned
- (void)rtcEngineConnectionDidBanned:(AgoraRtcEngineKit *)engine {
    //是否已废弃？
}






//音频数据回调
- (BOOL)onRecordAudioFrame:(AgoraAudioFrame *)frame channelId:(NSString *)channelId {
    //NSLog(@"打印了 onRecordAudioFrame 获得采集的原始音频数据");
    return YES;
}

- (BOOL)onPlaybackAudioFrame:(AgoraAudioFrame *)frame channelId:(NSString *)channelId {
    //NSLog(@"打印了 onPlaybackAudioFrame 获得播放的原始音频数据");
    return YES;
}

- (BOOL)onPlaybackAudioFrameBeforeMixing:(AgoraAudioFrame *)frame channelId:(NSString *)channelId uid:(NSUInteger)uid {
    //NSLog(@"打印了 onPlaybackAudioFrameBeforeMixing 获得混音前的指定用户的声音 channelId = %@ , uid = %lu",channelId,(unsigned long)uid);
    return YES;
}

- (BOOL)onMixedAudioFrame:(AgoraAudioFrame *)frame channelId:(NSString *)channelId {
    //NSLog(@"打印了 onMixedAudioFrame 获取采集和播放音频混音后的数据 channelId = %@",channelId);
    return YES;
}

- (AgoraAudioFramePosition)getObservedAudioFramePosition {
    //NSLog(@"打印了 getObservedAudioFramePosition 设置音频观测位置");
    return AgoraAudioFramePositionRecord;
}

//- (AgoraAudioParams *)getRecordAudioParams {
//    NSLog(@"打印了 getRecordAudioParams 设置 onRecordAudioFrame 回调数据的格式");
//
//    return ;
//}

//- (AgoraAudioParams *)getPlaybackAudioParams {
//    NSLog(@"打印了 getPlaybackAudioParams 设置 onPlaybackAudioFrame 回调数据的格式");
//    return ;
//}

//- (AgoraAudioParams *)getMixedAudioParams {
//    NSLog(@"打印了 getMixedAudioParams 设置 onMixedAudioFrame 回调数据的格式");
//    return ;
//}




//视频数据回调
- (BOOL)onCaptureVideoFrame:(AgoraOutputVideoFrame *)videoFrame sourceType:(AgoraVideoSourceType)sourceType {
    //NSLog(@"打印了 ");
    //NSLog(@"打印了 onCaptureVideoFrame 获取本地摄像头采集到的视频数据");
    return YES;
}

- (BOOL)onPreEncodeVideoFrame:(AgoraOutputVideoFrame *)videoFrame sourceType:(AgoraVideoSourceType)sourceType {
    //NSLog(@"打印了 onPreEncodeVideoFrame获取本地视频编码前的视频数据");
    return YES;
}

- (BOOL)onRenderVideoFrame:(AgoraOutputVideoFrame *)videoFrame uid:(NSUInteger)uid channelId:(NSString *)channelId {
    //NSLog(@"打印了 onRenderVideoFrame获取远端发送的视频数据 uid = %lu",(unsigned long)uid);
    return YES;
}

- (AgoraVideoFramePosition)getObservedFramePosition {
    //NSLog(@"打印了 getObservedFramePosition 设置视频观测位置");
    return AgoraVideoFramePositionPostCapture;
}

- (AgoraVideoFrameProcessMode)getVideoFrameProcessMode {
    //NSLog(@"打印了 getVideoFrameProcessMode 设置视频处理模式");
    return AgoraVideoFrameProcessModeReadWrite;
}

- (BOOL)getMirrorApplied {
    NSLog(@"打印了 getMirrorApplied 设置视频数据镜像");
    
    //该功能仅支持 RGBA 和 YUV420 格式的视频数据
    //该方法和 setVideoEncoderConfiguration 方法均支持设置镜像效果，声网建议你仅选择一种方法进行设置，同时使用两种方法会导致镜像效果叠加从而造成设置镜像失败。
    //NO: （默认）不镜像
    return NO;
}

- (BOOL)getRotationApplied {
    NSLog(@"打印了 getRotationApplied 设置视频数据旋转");
    //该功能仅支持视频处理模式为 AgoraVideoFrameProcessModeReadOnly 的场景
    //该功能仅支持 RGBA 和 YUV420 格式的视频数据
    //NO: （默认）不旋转
    return NO;
}

- (AgoraVideoFormat)getVideoFormatPreference {
    //NSLog(@"打印了 getVideoFormatPreference 设置 SDK 输出的原始视频数据格式");
    return AgoraVideoFormatDefault;
}

//耳返音频数据回调
- (BOOL)onEarMonitoringAudioFrame:(AgoraAudioFrame *)frame {
    NSLog(@"打印了 onEarMonitoringAudioFrame 获得耳返的原始音频数据");
    return YES;
}

//- (AgoraAudioParams *)getEarMonitoringAudioParams {
//    NSLog(@"打印了 getEarMonitoringAudioParams 设置 onEarMonitoringAudioFrame 回调数据的格式");
//    return ;
//}

//音量提示回调
- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> *)speakers totalVolume:(NSInteger)totalVolume {
    //NSLog(@"打印了 reportAudioVolumeIndicationOfSpeakers 用户音量提示回调");
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine activeSpeaker:(NSUInteger)speakerUid {
    //NSLog(@"打印了 监测到远端最活跃用户回调");
}

//
- (void)rtcEngine:(AgoraRtcEngineKit *)engine receiveStreamMessageFromUid:(NSUInteger)uid streamId:(NSInteger)streamId data:(NSData *)data {
    NSLog(@"打印了 receiveStreamMessageFromUid 接收到对方数据流消息的回调");
    
}


//
- (void)AgoraRtcMediaPlayer:(id<AgoraRtcMediaPlayerProtocol>)playerKit didChangedToState:(AgoraMediaPlayerState)state error:(AgoraMediaPlayerError)error {
    NSLog(@"打印了 didChangedToState 报告播放器状态改变 state = %ld , error = %ld",(long)state,(long)error);
    
}

- (void)AgoraRtcMediaPlayer:(id<AgoraRtcMediaPlayerProtocol>)playerKit didChangedToPosition:(NSInteger)position {
    NSLog(@"打印了 didChangedToPosition 报告当前播放进度 position = %ld",(long)position);
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine channelMediaRelayStateDidChange:(AgoraChannelMediaRelayState)state error:(AgoraChannelMediaRelayError)error {
    NSLog(@"打印了 channelMediaRelayStateDidChange 跨频道媒体流转发状态发生改变回调 AgoraChannelMediaRelayState %ld ,error %ld",(long)state,(long)error);
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didReceiveChannelMediaRelayEvent:(AgoraChannelMediaRelayEvent)event {
    NSLog(@"打印了 didReceiveChannelMediaRelayEvent 跨频道媒体流转发事件回调 AgoraChannelMediaRelayEvent %ld",(long)event);
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine audioMixingPositionChanged:(NSInteger)position {
    NSLog(@"打印了 audioMixingPositionChanged position = %ld",(long)position);
}

@end
