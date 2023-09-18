//
//  ZSNAIAECAINSViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/10/27.
//

#import "ZSNAIAECAINSViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>


@interface ZSNAIAECAINSViewController ()<AgoraRtcEngineDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIButton *btnChooseDefaultScenario;
@property (nonatomic, strong) UIButton *btnChooseScenarioGameStreaming;
@property (nonatomic, strong) UIButton *btnChooseScenarioMeeting;
@property (nonatomic, strong) UIButton *btnPlayMusic;
@property (nonatomic, strong) UIButton *btnOpenAINS;
@property (nonatomic, strong) UIButton *btnCloseAINS;
@property (nonatomic, strong) UIButton *btnOpenAIAEC;
@property (nonatomic, strong) UIButton *btnCloseAIAEC;
@property (nonatomic, strong) UIButton *btnOpenAudioDump;
@property (nonatomic, strong) UIButton *btnJoinChannel;


@end

@implementation ZSNAIAECAINSViewController

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
    lblTopTitle.text = @"AINS+AIAEC";
    lblTopTitle.textColor = [UIColor blueColor];
    lblTopTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTopTitle];
    
    //UIButton 初始化建议用buttonWithType
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(20 , 45, 70, 40);
    [btnBack.layer setCornerRadius:20];
    [btnBack.layer setMasksToBounds:YES];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.backgroundColor = [UIColor greenColor];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnBack addTarget:self action:@selector(btnBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    _btnChooseDefaultScenario = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnChooseDefaultScenario.frame = CGRectMake(20, 90, 290, 40);
    [_btnChooseDefaultScenario setTitle:@"选择AgoraAudioScenarioDefault" forState:UIControlStateNormal];
    [_btnChooseDefaultScenario setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnChooseDefaultScenario.backgroundColor = [UIColor greenColor];
    [_btnChooseDefaultScenario.layer setCornerRadius:20];
    [_btnChooseDefaultScenario.layer setMasksToBounds:YES];
    _btnChooseDefaultScenario.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnChooseDefaultScenario addTarget:self action:@selector(btnChooseDefaultScenarioAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnChooseDefaultScenario];
    
    _btnChooseScenarioGameStreaming = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnChooseScenarioGameStreaming.frame = CGRectMake(20, 150, 290, 40);
    [_btnChooseScenarioGameStreaming.layer setCornerRadius:20];
    [_btnChooseScenarioGameStreaming.layer setMasksToBounds:YES];
    
    [_btnChooseScenarioGameStreaming setTitle:@"选择AudioScenarioGameStreaming" forState:UIControlStateNormal];
    [_btnChooseScenarioGameStreaming setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnChooseScenarioGameStreaming.backgroundColor = [UIColor greenColor];
    _btnChooseScenarioGameStreaming.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnChooseScenarioGameStreaming addTarget:self action:@selector(btnChooseScenarioGameStreamingAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnChooseScenarioGameStreaming];
    
    _btnChooseScenarioMeeting = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnChooseScenarioMeeting.frame = CGRectMake(20, 210, 290, 40);
    [_btnChooseScenarioMeeting.layer setCornerRadius:20];
    [_btnChooseScenarioMeeting.layer setMasksToBounds:YES];
    
    [_btnChooseScenarioMeeting setTitle:@"选择AgoraAudioScenarioMeeting" forState:UIControlStateNormal];
    [_btnChooseScenarioMeeting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnChooseScenarioMeeting.backgroundColor = [UIColor greenColor];
    _btnChooseScenarioMeeting.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnChooseScenarioMeeting addTarget:self action:@selector(btnChooseScenarioMeetingAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnChooseScenarioMeeting];
    
    
    _btnPlayMusic = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnPlayMusic.frame = CGRectMake(20, 270, 290, 40);
    [_btnPlayMusic.layer setCornerRadius:20];
    [_btnPlayMusic.layer setMasksToBounds:YES];
    [_btnPlayMusic setTitle:@"播放音乐" forState:UIControlStateNormal];
    [_btnPlayMusic setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnPlayMusic.backgroundColor = [UIColor greenColor];
    _btnPlayMusic.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnPlayMusic addTarget:self action:@selector(btnPlayMusicAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnPlayMusic];
    
    _btnOpenAINS = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnOpenAINS.frame = CGRectMake(20, 330, 290, 40);
    [_btnOpenAINS.layer setCornerRadius:20];
    [_btnOpenAINS.layer setMasksToBounds:YES];
    [_btnOpenAINS setTitle:@"打开 AINS" forState:UIControlStateNormal];
    [_btnOpenAINS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnOpenAINS.backgroundColor = [UIColor greenColor];
    _btnOpenAINS.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnOpenAINS addTarget:self action:@selector(btnOpenAINSAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnOpenAINS];
    
    _btnCloseAINS = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCloseAINS.frame = CGRectMake(20, 390, 290, 40);
    [_btnCloseAINS.layer setCornerRadius:20];
    [_btnCloseAINS.layer setMasksToBounds:YES];
    [_btnCloseAINS setTitle:@"关闭 AINS" forState:UIControlStateNormal];
    [_btnCloseAINS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnCloseAINS.backgroundColor = [UIColor greenColor];
    _btnCloseAINS.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnCloseAINS addTarget:self action:@selector(btnCloseAINSAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnCloseAINS];
    
    
    _btnOpenAIAEC = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnOpenAIAEC.frame = CGRectMake(20, 450, 290, 40);
    [_btnOpenAIAEC.layer setCornerRadius:20];
    [_btnOpenAIAEC.layer setMasksToBounds:YES];
    [_btnOpenAIAEC setTitle:@"打开 AIAEC" forState:UIControlStateNormal];
    [_btnOpenAIAEC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnOpenAIAEC.backgroundColor = [UIColor greenColor];
    _btnOpenAIAEC.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnOpenAIAEC addTarget:self action:@selector(btnOpenAIAECAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnOpenAIAEC];
    
    _btnCloseAIAEC = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCloseAIAEC.frame = CGRectMake(20, 510, 290, 40);
    [_btnCloseAIAEC.layer setCornerRadius:20];
    [_btnCloseAIAEC.layer setMasksToBounds:YES];
    [_btnCloseAIAEC setTitle:@"关闭 AIAEC" forState:UIControlStateNormal];
    [_btnCloseAIAEC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnCloseAIAEC.backgroundColor = [UIColor greenColor];
    _btnCloseAIAEC.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnCloseAIAEC addTarget:self action:@selector(btnCloseAIAECAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnCloseAIAEC];
    
    
    _btnOpenAudioDump = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnOpenAudioDump.frame = CGRectMake(20, 570, 290, 40);
    [_btnOpenAudioDump.layer setCornerRadius:20];
    [_btnOpenAudioDump.layer setMasksToBounds:YES];
    [_btnOpenAudioDump setTitle:@"打开Audio Dump" forState:UIControlStateNormal];
    [_btnOpenAudioDump setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnOpenAudioDump.backgroundColor = [UIColor greenColor];
    _btnOpenAudioDump.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnOpenAudioDump addTarget:self action:@selector(btnOpenAudioDumpAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnOpenAudioDump];
    
    _btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnJoinChannel.frame = CGRectMake(20, 630, 290, 40);
    [_btnJoinChannel.layer setCornerRadius:20];
    [_btnJoinChannel.layer setMasksToBounds:YES];
    [_btnJoinChannel setTitle:@"加入频道" forState:UIControlStateNormal];
    [_btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnJoinChannel.backgroundColor = [UIColor greenColor];
    _btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:_btnJoinChannel];
    
    [self initAgoraRtcInfo];
    
}



-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit enableAudio];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQuality];//4
    [self.agoraKit setAudioScenario:AgoraAudioScenarioDefault];
    
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
}

-(void)btnChooseDefaultScenarioAction:(UIButton *) button {
    NSLog(@"打印了 点击了打开 btnChooseDefaultScenarioAction");
    
    [self.agoraKit setAudioScenario:AgoraAudioScenarioDefault];
    
    [_btnChooseDefaultScenario setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}

-(void)btnChooseScenarioGameStreamingAction:(UIButton *)button {
    NSLog(@"打印了 点击了打开 btnChooseScenarioGameStreamingAction");
    
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    [_btnChooseScenarioGameStreaming setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void)btnChooseScenarioMeetingAction:(UIButton *)button {
    NSLog(@"打印了 点击了 btnChooseScenarioMeetingAction");
    [self.agoraKit setAudioScenario:AgoraAudioScenarioMeeting];
    
    [_btnChooseScenarioMeeting setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}

-(void)btnJoinChannelAction:(UIButton *)button {
    NSLog(@"打印了 点击了打开 btnJoinChannelAction");
    [_btnJoinChannel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //AgoraRtcChannelMediaOptions
    AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
    //options.publishCameraTrack = YES;
    options.publishMicrophoneTrack = YES;
    //options.clientRoleType = AgoraClientRoleBroadcaster;
   int result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:options joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        NSLog(@"打印了 joinChannelByToken 成功");
       
    }];
    
    NSLog(@"打印了 joinChannelByToken result值 %d",result);
}

-(void)btnPlayMusicAction:(UIButton *)button {
    NSLog(@"打印了 点击了打开 btnPlayMusicAction");
    NSString * strurl = [[NSBundle mainBundle] pathForResource:@"longlidiansi_lpb" ofType:@"wav"];
    [self.agoraKit startAudioMixing:strurl loopback:YES cycle:-1 startPos:0];
    
    [_btnPlayMusic setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void)btnOpenAINSAction:(UIButton *)button {
    NSLog(@"打印了 点击了打开 btnOpenAINSAction");
    
    
    [self.agoraKit setParameters:@"{\"che.audio.ains_mode\":2}"];
    [self.agoraKit setParameters:@"{\"che.audio.nsng.lowerBound\":0}"];
    [self.agoraKit setParameters:@"{\"che.audio.nsng.lowerMask\":0}"];
    [self.agoraKit setParameters:@"{\"che.audio.nsng.statisticalbound\":0}"];
    [self.agoraKit setParameters:@"{\"che.audio.nsng.finallowermask\":0}"];
    
    [_btnOpenAINS setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
//    [self.agoraKit setParameters:[NSString stringWithFormat:@"%@",@"{\"che.audio.ns_mode\":2}"]];
//    [self.agoraKit setParameters:[NSString stringWithFormat:@"%@",@"{\"che.audio.nsng.lowerBound\":0}"]];
//    [self.agoraKit setParameters:[NSString stringWithFormat:@"%@",@"{\"che.audio.nsng.lowerMask\":0}"]];
//    [self.agoraKit setParameters:[NSString stringWithFormat:@"%@",@"{\"che.audio.nsng.statisticalbound\":0}"]];
//    [self.agoraKit setParameters:[NSString stringWithFormat:@"%@",@"{\"che.audio.nsng.finallowermask\":0}"]];
    
    //65535
    
    
    
    //获取debug log
    
    [self.agoraKit setParameters:@"{\"rtc.log_filter\":65535}"];
    [self.agoraKit setParameters:@"{\"rtc.log_size\":999999999}"];
    
}


-(void)btnCloseAINSAction:(UIButton *)button {
    NSLog(@"打印了 点击了 关闭 btnOpenAINSAction");
    
    [self.agoraKit setParameters:@"{\"che.audio.ains_mode\":0}"];
    
    [_btnCloseAINS setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //[self.agoraKit setParameters:[NSString stringWithFormat:@"%@",@"{\"che.audio.ns_mode\":0}"]];
}

-(void)btnOpenAIAECAction:(UIButton *)button {
    NSLog(@"打印了 点击了 btnOpenAIAECAction");
    
    [self.agoraKit setParameters:@"{\"che.audio.aiaec.working_mode\":2}"];
    
    [_btnOpenAIAEC setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void)btnCloseAIAECAction:(UIButton *) button {
    NSLog(@"打印了 点击了 关闭 btnCloseAIAECAction");
    
    [self.agoraKit setParameters:@"{\"che.audio.aiaec.working_mode\":0}"];
    
    [_btnCloseAIAEC setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}


-(void)btnInitEngineKitAction:(UIButton *)button {
    NSLog(@"打印了 点击了 btnInitEngineKitAction");
}

-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)btnMuteLocalAudioAction:(UIButton *) button {
    NSLog(@"打印了 点击了 btnMuteLocalAudioAction");
    
    [self.agoraKit muteLocalAudioStream:YES];
}

-(void)btnMuteLocalAudioNOAction:(UIButton *)button {
    NSLog(@"打印了 点击了 btnMuteLocalAudioAction");
    
    [self.agoraKit muteLocalAudioStream:NO];
}

-(void)btnOpenAudioDumpAction:(UIButton *)button {
    NSLog(@"打印了 点击了 btnOpenAudioDumpAction");
    
    [self.agoraKit setParameters:@"{\"rtc.debug.enable\":true}"];
    [self.agoraKit setParameters:@"{\"che.audio.frame_dump\":{\"location\":\"apm\",\"action\":\"start\",\"max_size_bytes\":\"120000000\",\"uuid\":\"123456789\",\"duration\":\"1200000\"}}"];


    [_btnOpenAudioDump setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
