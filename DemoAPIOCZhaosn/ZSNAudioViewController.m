//
//  ZSNAudioViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/3/15.
//

#import "ZSNAudioViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNAudioViewController ()<AgoraRtcEngineDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIButton *btnRoleChoose;
@property (nonatomic, strong) UIButton *btnJoinChannel;
@property (nonatomic, strong) UIButton *btnSendAudio;

@property (nonatomic, assign) BOOL isJoinChannel;
@property (nonatomic, assign) BOOL isRoleBroadcaster;
@property (nonatomic, assign) BOOL isSendAudio;

@end

@implementation ZSNAudioViewController

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
    [self.btnSendAudio setTitle:@"音频已关闭" forState:UIControlStateNormal];
    [self.btnSendAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnSendAudio.backgroundColor = [UIColor greenColor];
    self.btnSendAudio.titleLabel.font = [UIFont systemFontOfSize:17.0];
    //[self.btnSendAudio addTarget:self action:@selector(btnSendAudioAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:self.btnSendAudio];
    
    self.isJoinChannel = NO;
    self.isRoleBroadcaster = NO;
    self.isSendAudio = NO;
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [AgoraRtcEngineKit destroy];
}

-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    
    [self.agoraKit setClientRole:AgoraClientRoleAudience];
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    [self.agoraKit setAudioProfile:AgoraAudioProfileDefault];
    [self.agoraKit setAudioScenario:AgoraAudioScenarioGameStreaming];
    [self.agoraKit disableVideo];
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
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

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    NSLog(@"打印了 didJoinChannel 成功加入频道回调 uid %lu",(unsigned long)uid);
    
    self.isJoinChannel = YES;
    self.btnJoinChannel.enabled = NO;
    
    [self.btnJoinChannel setTitle:@"已加入频道" forState:UIControlStateNormal];
    [self.btnJoinChannel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole newRoleOptions:(AgoraClientRoleOptions *)newRoleOptions {
    
    if (newRole == AgoraClientRoleBroadcaster) {
        self.isRoleBroadcaster = YES;
        NSLog(@"打印了 点击了 didClientRoleChanged 直播场景下用户角色已切换回调 为主播");
        [self.btnRoleChoose setTitle:@"点击变为观众" forState:UIControlStateNormal];
        [self.btnRoleChoose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if (newRole == AgoraClientRoleAudience) {
        self.isRoleBroadcaster = NO;
        NSLog(@"打印了 点击了 didClientRoleChanged 直播场景下用户角色已切换回调 为观众");
        [self.btnRoleChoose setTitle:@"点击变为主播" forState:UIControlStateNormal];
        [self.btnRoleChoose setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine localAudioStateChanged:(AgoraAudioLocalState)state error:(AgoraAudioLocalError)error {
    
    if (state == AgoraAudioLocalStateStopped) {
        self.isSendAudio = NO;
        NSLog(@"打印了 点击了 localAudioStateChanged 本地音频状态发生改变回调 AgoraAudioLocalStateStopped");
        [self.btnSendAudio setTitle:@"音频已关闭" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    else if(state == AgoraAudioLocalStateEncoding) {
        self.isSendAudio = YES;
//        NSLog(@"打印了 点击了 localAudioStateChanged 本地音频状态发生改变回调 AgoraAudioLocalStateEncoding");
//        [self.btnSendAudio setTitle:@"音频已打开Encoding" forState:UIControlStateNormal];
//        [self.btnSendAudio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if (state == AgoraAudioLocalStateRecording) {
        self.isSendAudio = YES;
        NSLog(@"打印了 点击了 localAudioStateChanged 本地音频状态发生改变回调 AgoraAudioLocalStateRecording");
        [self.btnSendAudio setTitle:@"音频已打开Recording" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if(state == AgoraAudioLocalStateFailed) {
        NSLog(@"打印了 点击了 localAudioStateChanged 本地音频状态发生改变回调 AgoraAudioLocalStateFailed");
        [self.btnSendAudio setTitle:@"音频本地音频启动失败" forState:UIControlStateNormal];
        [self.btnSendAudio setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstLocalAudioFramePublished:(NSInteger)elapsed {
    NSLog(@"打印了 点击了 firstLocalAudioFramePublished 已发布本地音频首帧回调");
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didAudioPublishStateChange:(NSString *)channelId oldState:(AgoraStreamPublishState)oldState newState:(AgoraStreamPublishState)newState elapseSinceLastState:(int)elapseSinceLastState {
    NSLog(@"打印了 点击了 didAudioPublishStateChange 音频发布状态改变回调 oldState = %ld,newState = %ld",oldState,newState);
    
}



@end
