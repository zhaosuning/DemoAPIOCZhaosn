//
//  ZSNChooseAudioProfileVC.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/11/28.
//

#import "ZSNChooseAudioProfileVC.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNChooseAudioProfileVC ()<AgoraRtcEngineDelegate>
@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

//@property (nonatomic, strong) UIView * localView;
//@property (nonatomic, strong) UIView * remoteView;

//AgoraAudioProfileDefault = 0,
///**
// * 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate up to 18 Kbps.
// */
//AgoraAudioProfileSpeechStandard = 1,
///**
// * 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
// */
//AgoraAudioProfileMusicStandard = 2,
///**
// * 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80
// * Kbps.
// */
//AgoraAudioProfileMusicStandardStereo = 3,
///**
// * 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
// */
//AgoraAudioProfileMusicHighQuality = 4,
///**
// * 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
// */
//AgoraAudioProfileMusicHighQualityStereo = 5,
///**
// * 6: A sample rate of 16 kHz, audio encoding, mono, and a bitrate of up to 64 Kbps.
// */
//AgoraAudioProfileIot = 6,



@property (nonatomic, strong) UIButton *btnAgoraAudioProfileDefault;
@property (nonatomic, strong) UIButton *btnAgoraAudioProfileSpeechStandard;
@property (nonatomic, strong) UIButton *btnAgoraAudioProfileMusicStandard;
@property (nonatomic, strong) UIButton *btnAgoraAudioProfileMusicStandardStereo;
@property (nonatomic, strong) UIButton *btnAgoraAudioProfileMusicHighQuality;
@property (nonatomic, strong) UIButton *btnAgoraAudioProfileMusicHighQualityStereo;
@property (nonatomic, strong) UIButton *btnAgoraAudioProfileIot;


//@property (nonatomic, strong) UIButton *btn;
//@property (nonatomic, strong) UIButton *btnCloseAIAEC;
//@property (nonatomic, strong) UIButton *btnOpenAudioDump;
//@property (nonatomic, strong) UIButton *btnJoinChannel;


//AgoraAudioScenarioDefault = 0,
///**
// * 3: (Recommended) The live gaming scenario, which needs to enable gaming
// * audio effects in the speaker. Choose this scenario to achieve high-fidelity
// * music playback.
// */
//AgoraAudioScenarioGameStreaming = 3,
///**
// * 5: The chatroom scenario.
// */
//AgoraAudioScenarioChatRoom = 5,
///** Chorus */
//AgoraAudioScenarioChorus = 7,
///** Meeting */
//AgoraAudioScenarioMeeting = 8

@property (nonatomic, strong) UIButton *btnAgoraAudioScenarioDefault;

@property (nonatomic, strong) UIButton *btnAgoraAudioScenarioGameStreaming;
@property (nonatomic, strong) UIButton *btnAgoraAudioScenarioChatRoom;
@property (nonatomic, strong) UIButton *btnAgoraAudioScenarioChorus;
@property (nonatomic, strong) UIButton *btnAgoraAudioScenarioMeeting;

@end

@implementation ZSNChooseAudioProfileVC

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
    lblTopTitle.text = @"音频";
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
    
    
//    self.localView = [[UIView alloc] init];
//    self.localView.backgroundColor = [UIColor lightGrayColor];
//    self.localView.frame = CGRectMake(10, 100, 300, 300);
//    [viewbg addSubview:self.localView];
//
//    self.remoteView = [[UIView alloc] init];
//    self.remoteView.backgroundColor = [UIColor redColor];
//    self.remoteView.frame = CGRectMake(10, 410, 300, 300);
//    [viewbg addSubview:self.remoteView];
    
//    UIButton *btnMuteLocalAudio = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnMuteLocalAudio.frame = CGRectMake(20, 100, 200, 40);
//    [btnMuteLocalAudio setTitle:@"MuteLocalAudio YES" forState:UIControlStateNormal];
//    [btnMuteLocalAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    btnMuteLocalAudio.backgroundColor = [UIColor greenColor];
//    btnMuteLocalAudio.titleLabel.font = [UIFont systemFontOfSize:17.0];
//    [btnMuteLocalAudio addTarget:self action:@selector(btnMuteLocalAudioAction:) forControlEvents:UIControlEventTouchUpInside];
//    [viewbg addSubview:btnMuteLocalAudio];
//
//    UIButton *btnMuteLocalAudioNO = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnMuteLocalAudioNO.frame = CGRectMake(20, 160, 200, 40);
//    [btnMuteLocalAudioNO setTitle:@"MuteLocalAudio NO" forState:UIControlStateNormal];
//    [btnMuteLocalAudioNO setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    btnMuteLocalAudioNO.backgroundColor = [UIColor greenColor];
//    btnMuteLocalAudioNO.titleLabel.font = [UIFont systemFontOfSize:17.0];
//    [btnMuteLocalAudioNO addTarget:self action:@selector(btnMuteLocalAudioNOAction:) forControlEvents:UIControlEventTouchUpInside];
//    [viewbg addSubview:btnMuteLocalAudioNO];
//
//    UIButton *btnRoleBroadcaster = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnRoleBroadcaster.frame = CGRectMake(20, 220, 200, 40);
//    [btnRoleBroadcaster setTitle:@"Role Broadcaster" forState:UIControlStateNormal];
//    [btnRoleBroadcaster setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    btnRoleBroadcaster.backgroundColor = [UIColor greenColor];
//    btnRoleBroadcaster.titleLabel.font = [UIFont systemFontOfSize:17.0];
//    [btnRoleBroadcaster addTarget:self action:@selector(btnRoleBroadcasterAction:) forControlEvents:UIControlEventTouchUpInside];
//    [viewbg addSubview:btnRoleBroadcaster];
//
//    UIButton *btnRoleAudience = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnRoleAudience.frame = CGRectMake(20, 280, 200, 40);
//    [btnRoleAudience setTitle:@"Role Audience" forState:UIControlStateNormal];
//    [btnRoleAudience setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    btnRoleAudience.backgroundColor = [UIColor greenColor];
//    btnRoleAudience.titleLabel.font = [UIFont systemFontOfSize:17.0];
//    [btnRoleAudience addTarget:self action:@selector(btnRoleAudienceAction:) forControlEvents:UIControlEventTouchUpInside];
//    [viewbg addSubview:btnRoleAudience];
    
    
    
    self.btnAgoraAudioProfileDefault = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileDefault.frame = CGRectMake(10, 100, 330, 40);
    [self.btnAgoraAudioProfileDefault setTitle:@"AgoraAudioProfileDefault" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileDefault.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileDefault.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileDefault addTarget:self action:@selector(btnAgoraAudioProfileDefaultAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileDefault];
    
    self.btnAgoraAudioProfileSpeechStandard = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileSpeechStandard.frame = CGRectMake(10, 150, 330, 40);
    [self.btnAgoraAudioProfileSpeechStandard setTitle:@"AgoraAudioProfileSpeechStandard" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileSpeechStandard.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileSpeechStandard.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileSpeechStandard addTarget:self action:@selector(btnAgoraAudioProfileSpeechStandardAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileSpeechStandard];
    
    self.btnAgoraAudioProfileMusicStandard = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileMusicStandard.frame = CGRectMake(10, 200, 330, 40);
    [self.btnAgoraAudioProfileMusicStandard setTitle:@"AgoraAudioProfileMusicStandard" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileMusicStandard.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileMusicStandard.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileMusicStandard addTarget:self action:@selector(btnAgoraAudioProfileMusicStandardAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileMusicStandard];
    
    self.btnAgoraAudioProfileMusicStandardStereo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileMusicStandardStereo.frame = CGRectMake(10, 250, 330, 40);
    [self.btnAgoraAudioProfileMusicStandardStereo setTitle:@"AgoraAudioProfileMusicStandardStereo" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileMusicStandardStereo.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileMusicStandardStereo.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileMusicStandardStereo addTarget:self action:@selector(btnAgoraAudioProfileMusicStandardStereoAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileMusicStandardStereo];
    
    
    self.btnAgoraAudioProfileMusicHighQuality = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileMusicHighQuality.frame = CGRectMake(10, 300, 330, 40);
    [self.btnAgoraAudioProfileMusicHighQuality setTitle:@"AgoraAudioProfileMusicHighQuality" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileMusicHighQuality.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileMusicHighQuality.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileMusicHighQuality addTarget:self action:@selector(btnAgoraAudioProfileMusicHighQualityAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileMusicHighQuality];
    
    
    self.btnAgoraAudioProfileMusicHighQualityStereo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileMusicHighQualityStereo.frame = CGRectMake(10, 350, 330, 40);
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitle:@"AgoraAudioProfileMusicHighQualityStereo" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileMusicHighQualityStereo.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileMusicHighQualityStereo.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileMusicHighQualityStereo addTarget:self action:@selector(btnAgoraAudioProfileMusicHighQualityStereoAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileMusicHighQualityStereo];
    
    
    self.btnAgoraAudioProfileIot = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioProfileIot.frame = CGRectMake(10, 400, 330, 40);
    [self.btnAgoraAudioProfileIot setTitle:@"AgoraAudioProfileIot" forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioProfileIot.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioProfileIot.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioProfileIot addTarget:self action:@selector(btnAgoraAudioProfileIotAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioProfileIot];
    
    
    self.btnAgoraAudioScenarioDefault = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioScenarioDefault.frame = CGRectMake(10, 450, 330, 40);
    [self.btnAgoraAudioScenarioDefault setTitle:@"AgoraAudioScenarioDefault" forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioScenarioDefault.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioScenarioDefault.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioScenarioDefault addTarget:self action:@selector(btnAgoraAudioScenarioDefaultAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioScenarioDefault];
    
    self.btnAgoraAudioScenarioGameStreaming = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioScenarioGameStreaming.frame = CGRectMake(10, 500, 330, 40);
    [self.btnAgoraAudioScenarioGameStreaming setTitle:@"AgoraAudioScenarioGameStreaming" forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioGameStreaming setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioScenarioGameStreaming.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioScenarioGameStreaming.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioScenarioGameStreaming addTarget:self action:@selector(btnAgoraAudioScenarioGameStreamingAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioScenarioGameStreaming];
    
    self.btnAgoraAudioScenarioChatRoom = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioScenarioChatRoom.frame = CGRectMake(10, 550, 330, 40);
    [self.btnAgoraAudioScenarioChatRoom setTitle:@"AgoraAudioScenarioChatRoom" forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChatRoom setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioScenarioChatRoom.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioScenarioChatRoom.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioScenarioChatRoom addTarget:self action:@selector(btnAgoraAudioScenarioChatRoomAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioScenarioChatRoom];
    
    
    self.btnAgoraAudioScenarioChorus = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioScenarioChorus.frame = CGRectMake(10, 600, 330, 40);
    [self.btnAgoraAudioScenarioChorus setTitle:@"AgoraAudioScenarioChorus" forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChorus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioScenarioChorus.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioScenarioChorus.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioScenarioChorus addTarget:self action:@selector(btnAgoraAudioScenarioChorusAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioScenarioChorus];
    
    
    self.btnAgoraAudioScenarioMeeting = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAgoraAudioScenarioMeeting.frame = CGRectMake(10, 650, 330, 40);
    [self.btnAgoraAudioScenarioMeeting setTitle:@"AgoraAudioScenarioMeeting" forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioMeeting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnAgoraAudioScenarioMeeting.backgroundColor = [UIColor greenColor];
    self.btnAgoraAudioScenarioMeeting.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnAgoraAudioScenarioMeeting addTarget:self action:@selector(btnAgoraAudioScenarioMeetingAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnAgoraAudioScenarioMeeting];
    
    UIButton *btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJoinChannel.frame = CGRectMake(10, 700, 330, 40);
    [btnJoinChannel setTitle:@"join channel" forState:UIControlStateNormal];
    [btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor greenColor];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnJoinChannel];
    
   
    
    [self initAgoraRtcInfo];
}

-(void) viewWillDisappear:(BOOL)animated {
    [AgoraRtcEngineKit destroy];
}

//-(void)showLocalVideo {
//    AgoraRtcVideoCanvas * videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
//    videoCanvas.uid = 0;
//    videoCanvas.view = self.localView;
//    videoCanvas.renderMode = AgoraVideoRenderModeHidden;//AgoraVideoRenderModeHidden
//    [self.agoraKit setupLocalVideo:videoCanvas];
//    [self.agoraKit startPreview];
//}
//
//-(void)showRemoteVideo:(NSInteger) uid {
//    AgoraRtcVideoCanvas *remoteVideo = [[AgoraRtcVideoCanvas alloc] init];
//    remoteVideo.uid = uid;
//    remoteVideo.view = self.remoteView;
//    remoteVideo.renderMode = AgoraVideoRenderModeHidden;
//    [self.agoraKit setupRemoteVideo:remoteVideo];
//
//
//}

-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    //[self.agoraKit setClientRole:AgoraClientRoleAudience];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileDefault];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioDefault];
    
    [self.agoraKit enableAudio];
    
    [self.agoraKit disableVideo];
    
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
}

-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    [self.agoraKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
}


//[self.agoraKit setAudioProfile:AgoraAudioProfileDefault];
-(void)btnAgoraAudioProfileDefaultAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileDefault];
    NSLog(@"打印了 AgoraAudioProfileDefault");
    
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioProfileSpeechStandardAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileSpeechStandard];
    NSLog(@"打印了 AgoraAudioProfileSpeechStandard");
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioProfileMusicStandardAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicStandard];
    NSLog(@"打印了 AgoraAudioProfileMusicStandard");
    
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioProfileMusicStandardStereoAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicStandardStereo];
    NSLog(@"打印了 AgoraAudioProfileMusicStandardStereo");
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioProfileMusicHighQualityAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];
    NSLog(@"打印了 AgoraAudioProfileMusicHighQuality");
    
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioProfileMusicHighQualityStereoAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQualityStereo];
    NSLog(@"打印了 AgoraAudioProfileMusicHighQualityStereo");
    
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioProfileIotAction:(UIButton *) button {
    [self.agoraKit setAudioProfile:AgoraAudioProfileIot];
    NSLog(@"打印了 AgoraAudioProfileIot");
    
    [self.btnAgoraAudioProfileDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileSpeechStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicStandardStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQuality setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileMusicHighQualityStereo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioProfileIot setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

//
//@property (nonatomic, strong) UIButton *;
//
//@property (nonatomic, strong) UIButton *;
//@property (nonatomic, strong) UIButton *;
//@property (nonatomic, strong) UIButton *;
//@property (nonatomic, strong) UIButton *;

//[self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
-(void)btnAgoraAudioScenarioDefaultAction:(UIButton *) button {
    [self.agoraKit setAudioScenario:AgoraAudioScenarioDefault];
    NSLog(@"打印了 AgoraAudioScenarioDefault");
    
    [self.btnAgoraAudioScenarioDefault setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioGameStreaming setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChatRoom setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChorus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioMeeting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
}

-(void)btnAgoraAudioScenarioGameStreamingAction:(UIButton *) button {
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    NSLog(@"打印了 AgoraAudioScenarioGameStreaming");
    
    [self.btnAgoraAudioScenarioDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioGameStreaming setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChatRoom setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChorus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioMeeting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioScenarioChatRoomAction:(UIButton *) button {
    [self.agoraKit setAudioScenario:AgoraAudioScenarioChatRoom];
    NSLog(@"打印了 AgoraAudioScenarioChatRoom");
    
    [self.btnAgoraAudioScenarioDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioGameStreaming setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChatRoom setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChorus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioMeeting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioScenarioChorusAction:(UIButton *) button {
    [self.agoraKit setAudioScenario:AgoraAudioScenarioChorus];
    NSLog(@"打印了 AgoraAudioScenarioChorus");
    
    [self.btnAgoraAudioScenarioDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioGameStreaming setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChatRoom setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChorus setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioMeeting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)btnAgoraAudioScenarioMeetingAction:(UIButton *) button {
    [self.agoraKit setAudioScenario:AgoraAudioScenarioMeeting];
    NSLog(@"打印了 AgoraAudioScenarioMeeting");
    
    [self.btnAgoraAudioScenarioDefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioGameStreaming setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChatRoom setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioChorus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAgoraAudioScenarioMeeting setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void)btnJoinChannelAction:(UIButton *) button {
    AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
    options.publishCameraTrack = NO;
    
   int result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:options joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        NSLog(@"打印了 joinChannelByToken 成功");
       
    }];
}



//
//-(void)btnMuteLocalAudioNOAction:(UIButton *)button {
//    NSLog(@"打印了 点击了 btnMuteLocalAudioAction");
//
//    [self.agoraKit muteLocalAudioStream:NO];
//}
//
//-(void)btnRoleBroadcasterAction :(UIButton *) button {
//    NSLog(@"打印了 点击了 btnRoleBroadcasterAction");
//
//    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
//}
//
//-(void)btnRoleAudienceAction :(UIButton *) button {
//    NSLog(@"打印了 点击了 btnRoleAudienceAction");
//
//    [self.agoraKit setClientRole:AgoraClientRoleAudience];
//}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinChannel uid %lu",(unsigned long)uid);
    //[self showLocalVideo];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinedOfUid uid %lu",(unsigned long)uid);
    //[self showRemoteVideo:uid];
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
