//
//  ZSNVideoHeTuViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/7/28.
//

#import "ZSNVideoHeTuViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNVideoHeTuViewController ()<AgoraRtcEngineDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;
@property (nonatomic, strong) UIView * remoteView2;

@end

@implementation ZSNVideoHeTuViewController

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
    lblTopTitle.text = @"视频合图";
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
    self.remoteView.frame = CGRectMake(0, 400, 100, 100);
    [viewbg addSubview:self.remoteView];
    
    
    self.remoteView2 = [[UIView alloc] init];
    self.remoteView2.backgroundColor = [UIColor redColor];
    self.remoteView2.frame = CGRectMake(120, 400, 100, 100);
    [viewbg addSubview:self.remoteView2];
    
    UIButton *btnHetu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHetu.frame = CGRectMake(0, 290, 90, 40);
    [btnHetu setTitle:@"合图" forState:UIControlStateNormal];
    [btnHetu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnHetu.backgroundColor = [UIColor greenColor];
    btnHetu.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnHetu addTarget:self action:@selector(btnHetuAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnHetu];
   
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
    if (uid == 200) {
        AgoraRtcVideoCanvas *remoteVideo = [[AgoraRtcVideoCanvas alloc] init];
        remoteVideo.uid = uid;
        remoteVideo.view = self.remoteView;
        remoteVideo.renderMode = AgoraVideoRenderModeHidden;
        [self.agoraKit setupRemoteVideo:remoteVideo];
    }
    else {
        AgoraRtcVideoCanvas *remoteVideo = [[AgoraRtcVideoCanvas alloc] init];
        remoteVideo.uid = uid;
        remoteVideo.view = self.remoteView2;
        remoteVideo.renderMode = AgoraVideoRenderModeHidden;
        [self.agoraKit setupRemoteVideo:remoteVideo];
    }
    
    
}

-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:720 height:1280 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
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

-(void)btnHetuAction:(UIButton *) button {
    NSLog(@"打印了 点击btnHetuAction合图");
    //AgoraLocalTranscoderConfiguration
    
//    AgoraLiveTranscodingUser * l = [[AgoraLiveTranscodingUser alloc] init ];
//
//    AgoraLiveTranscoding * lt = [[AgoraLiveTranscoding alloc] init];
//
//    lt.videoBitrate = AgoraVideoBitrateStandard;//或者 lt.videoBitrate = 2000;
//    lt.videoFramerate = AgoraVideoFrameRateFps15
//
//    lt.videoBitrate = 2000;
//    lt.videoFramerate = AgoraVideoFrameRateFps15;
    
    //NSArray<AgoraTranscodingVideoStream *> * videoInputStreams
    
    //NSMutableArray *VideoStream =
    
    AgoraLocalTranscoderConfiguration * localTranscoderConfig = [[AgoraLocalTranscoderConfiguration alloc] init];
    
    NSMutableArray *muArrVideoStream = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i<2; ++i) {
        AgoraTranscodingVideoStream *videoInputStream = [[AgoraTranscodingVideoStream alloc] init];
        videoInputStream.sourceType = AgoraVideoSourceTypeRemote;
        
        //videoInputStream.imageUrl = @"";
        //videoInputStream.mediaPlayerId = 1;
        
        
        //videoInputStream.zOrder = 0;
        videoInputStream.alpha = 0.7;
        videoInputStream.mirror = NO;
        
        if(i == 0) {
            videoInputStream.rect = CGRectMake(0, 0, 100, 100);
            videoInputStream.remoteUserUid = 200;
            [videoInputStream setZOrder:99];
        }
        else if (i == 1) {
            videoInputStream.rect = CGRectMake(120, 120, 100, 100);
            videoInputStream.remoteUserUid = 201;
            [videoInputStream setZOrder:100];
        }
        
        [muArrVideoStream addObject:videoInputStream];
    }
    
    NSArray *arrVideoStream = muArrVideoStream;
    localTranscoderConfig.videoInputStreams = arrVideoStream;
    
    AgoraVideoEncoderConfiguration *videoConfig = [[AgoraVideoEncoderConfiguration alloc] initWithWidth:720 height:1280 frameRate:AgoraVideoFrameRateFps15 bitrate:AgoraVideoBitrateStandard orientationMode:AgoraVideoOutputOrientationModeAdaptative mirrorMode:AgoraVideoMirrorModeAuto];
    
    localTranscoderConfig.videoOutputConfiguration = videoConfig;
    
    [self.agoraKit startLocalVideoTranscoder:localTranscoderConfig];
    
    
    //    AgoraTranscodingVideoStream *videoInputStream = [[AgoraTranscodingVideoStream alloc] init];
    //    videoInputStream.sourceType = AgoraVideoSourceTypeRemote;
    //    videoInputStream.remoteUserUid = 200;
    //    //videoInputStream.imageUrl = @"";
    //    //videoInputStream.mediaPlayerId = 1;
    //
    //    videoInputStream.rect = CGRectMake(0, 0, 100, 100);
    //    //videoInputStream.zOrder = 0;
    //    videoInputStream.alpha = 0.7;
    //    videoInputStream.mirror = NO;
    //
    //    [videoInputStream setZOrder:1];
        
        
        
}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinChannel uid %lu",(unsigned long)uid);
    //[self showLocalVideo];
    
    [self showLocalVideo];
    
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinedOfUid uid %lu",(unsigned long)uid);
    [self showRemoteVideo:uid];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didLocalVideoTranscoderErrorWithStream:(AgoraTranscodingVideoStream *)stream errorCode:(AgoraVideoTranscoderError)errorCode
{
    NSLog(@"打印了 didLocalVideoTranscoderErrorWithStream 本地合图发生错误回调 AgoraTranscodingVideoStream %@  ,AgoraVideoTranscoderError %ld",stream,(long)errorCode);
    
    
}

@end
