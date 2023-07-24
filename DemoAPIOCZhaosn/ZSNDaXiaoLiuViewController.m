//
//  ZSNDaXiaoLiuViewController.m
//  DemoAPIOCZhaosn
//
//  Created by admin on 2022/10/18.
//

#import "ZSNDaXiaoLiuViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>


@interface ZSNDaXiaoLiuViewController ()<AgoraRtcEngineDelegate>


@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * smalllocalView;
@property (nonatomic, strong) UIView * remoteView;

@property (nonatomic, assign) NSUInteger uidremote;

//@property (nonatomic, strong) AgoraRtcBoolOptional * optionbool;

@end

@implementation ZSNDaXiaoLiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.uidremote = 0;
    
    
   //self.optionbool = [[AgoraRtcBoolOptional alloc]];
     
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
    lblTopTitle.text = @"大小流";
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
    self.localView.frame = CGRectMake(5, 100, [[UIScreen mainScreen] bounds].size.width - 256.0/3.0 - 5  , ([[UIScreen mainScreen] bounds].size.width - 256.0/3.0 - 5) * 840.0 / 480.0 );
    [viewbg addSubview:self.localView];
    
    
    self.smalllocalView = [[UIView alloc] init];
    self.smalllocalView.backgroundColor = [UIColor greenColor];
    self.smalllocalView.frame = CGRectMake(5 + [[UIScreen mainScreen] bounds].size.width - 256.0/3.0 - 5 +3 , 100, 256.0/3.0, 256.0/3.0);
    [viewbg addSubview:self.smalllocalView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.backgroundColor = [UIColor redColor];
    self.remoteView.frame = CGRectMake(10, 480, [[UIScreen mainScreen] bounds].size.width - 256.0/3.0 - 5  , ([[UIScreen mainScreen] bounds].size.width - 256.0/3.0 - 5) * 840.0 / 480.0);
    [viewbg addSubview:self.remoteView];
    
    UIButton *btnBigStream = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBigStream.frame = CGRectMake(20, 50, 300, 40);
    [btnBigStream setTitle:@"大流AgoraVideoStreamTypeHigh" forState:UIControlStateNormal];
    [btnBigStream setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBigStream.backgroundColor = [UIColor greenColor];
    btnBigStream.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnBigStream addTarget:self action:@selector(btnBigStreamAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnBigStream];
    
    UIButton *btnSmallStream = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSmallStream.frame = CGRectMake(20, 95 + 600, 300, 40);
    [btnSmallStream setTitle:@"小流AgoraVideoStreamTypeLow" forState:UIControlStateNormal];
    [btnSmallStream setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnSmallStream.backgroundColor = [UIColor greenColor];
    btnSmallStream.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnSmallStream addTarget:self action:@selector(btnSmallStreamAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnSmallStream];
    
    UIButton *btnStopPreview = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStopPreview.frame = CGRectMake(20, 210 + 300, 300, 40);
    [btnStopPreview setTitle:@"关闭预览" forState:UIControlStateNormal];
    [btnStopPreview setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnStopPreview.backgroundColor = [UIColor greenColor];
    btnStopPreview.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnStopPreview addTarget:self action:@selector(btnStopPreviewAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnStopPreview];
    
    UIButton *btnQiePingSmall = [UIButton buttonWithType:UIButtonTypeCustom];
    btnQiePingSmall.frame = CGRectMake(20, 260 + 300, 300, 40);
    [btnQiePingSmall setTitle:@"切小屏" forState:UIControlStateNormal];
    [btnQiePingSmall setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnQiePingSmall.backgroundColor = [UIColor greenColor];
    btnQiePingSmall.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnQiePingSmall addTarget:self action:@selector(btnQiePingSmallAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnQiePingSmall];
    
    UIButton *btnQiePingBig = [UIButton buttonWithType:UIButtonTypeCustom];
    btnQiePingBig.frame = CGRectMake(20, 310 + 300, 300, 40);
    [btnQiePingBig setTitle:@"切大屏" forState:UIControlStateNormal];
    [btnQiePingBig setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnQiePingBig.backgroundColor = [UIColor greenColor];
    btnQiePingBig.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnQiePingBig addTarget:self action:@selector(btnQiePingBigAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnQiePingBig];
    
    
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
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:840 height:480 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoConfig];
    
    //AgoraRtcChannelMediaOptions
    AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
    //options.publishCameraTrack = @YES; //(YES); //@(YES);
    //options.publishMicrophoneTrack = @(YES);
    
    //AgoraVideoSourceType
    //AgoraSimulcastStreamConfig
    
    [self.agoraKit enableDualStreamMode:YES];//开启大小流第一种方式
    
    
    //开启大小流第二种方式
//    AgoraSimulcastStreamConfig * daxiaoliuconf = [[AgoraSimulcastStreamConfig alloc] init];
//    daxiaoliuconf.bitrate = 80;
//    daxiaoliuconf.framerate = AgoraVideoFrameRateFps15;
//    daxiaoliuconf.dimensions = CGSizeMake(256, 256);
//    [self.agoraKit enableDualStreamMode:AgoraVideoSourceTypeCamera enabled:YES streamConfig:daxiaoliuconf];
    
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
    //[self.navigationController popViewControllerAnimated:YES];
    
    [self.agoraKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

-(void)btnBigStreamAction:(UIButton *) button {
    NSLog(@"打印了 点击了 大流");
    
     //setRemoteVideoStream   AgoraVideoStreamTypeHigh
    
    [self.agoraKit setRemoteVideoStream:self.uidremote type:AgoraVideoStreamTypeHigh];
}

-(void)btnStopPreviewAction:(UIButton *) button {
    NSLog(@"打印了 stopPreview");
    
    [self.agoraKit stopPreview];
}

-(void) btnQiePingSmallAction:(UIButton *) button {
    NSLog(@"打印了 切小屏");
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:256 height:256 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoConfig];
    
    
    AgoraRtcVideoCanvas * videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.view = self.smalllocalView;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;//AgoraVideoRenderModeHidden
    [self.agoraKit setupLocalVideo:videoCanvas];
    [self.agoraKit startPreview];
}

-(void) btnQiePingBigAction:(UIButton *) button {
    NSLog(@"打印了 切大屏");
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:840 height:480 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    [self.agoraKit setVideoEncoderConfiguration:videoConfig];
    
    AgoraRtcVideoCanvas * videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.view = self.localView;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;//AgoraVideoRenderModeHidden
    [self.agoraKit setupLocalVideo:videoCanvas];
    [self.agoraKit startPreview];
    
}
-(void)btnSmallStreamAction:(UIButton *)button {
    NSLog(@"打印了 点击了 小流");
    
    [self.agoraKit setRemoteVideoStream:self.uidremote type:AgoraVideoStreamTypeLow];
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
    
    self.uidremote = uid;
    
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

//didApiCallExecute

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didApiCallExecute:(NSInteger)error api:(NSString *)api result:(NSString *)result {
    NSLog(@"打印了 didApiCallExecute api %@ , result %@ ",api, result);
}


@end
