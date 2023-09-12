//
//  ZSNVideoReceiveViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/9/10.
//

#import "ZSNVideoReceiveViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import <AgoraRtcKit/AgoraRtcMediaPlayerProtocol.h>


@interface ZSNVideoReceiveViewController ()<AgoraRtcEngineDelegate,AgoraRtcMediaPlayerDelegate>

@property (nonatomic, strong) AgoraRtcEngineKit *agoraKit;

@property (nonatomic, weak) id <AgoraRtcMediaPlayerProtocol> mediaPlayerKit;

@property (nonatomic, strong) UIView * localView;
@property (nonatomic, strong) UIView * remoteView;


@end

@implementation ZSNVideoReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height + [[UIScreen mainScreen] bounds].size.height + 50);
    [self.view addSubview:scrollView];
    
    UIView *viewbg = [[UIView alloc] init];
    viewbg.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height + [[UIScreen mainScreen] bounds].size.height + 50);
    viewbg.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:viewbg];
    
    UILabel * lblTopTitle = [[UILabel alloc] init];
    lblTopTitle.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 50, 45, 100, 40);
    lblTopTitle.text = @"观众接收端";
    lblTopTitle.textColor = [UIColor blueColor];
    lblTopTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTopTitle];
    
    //UIButton 初始化建议用buttonWithType
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(20 , 50, 70, 40);
    [btnBack setTitle:@"Play" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBack.backgroundColor = [UIColor greenColor];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnBack.layer setCornerRadius:20];
    [btnBack.layer setMasksToBounds:YES];
    [btnBack addTarget:self action:@selector(btnBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    
    
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.backgroundColor = [UIColor grayColor];
    self.remoteView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);//CGRectMake(0, [[UIScreen mainScreen] bounds].size.width + 100, 200, 200);
    
    //self.remoteView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
    
    [viewbg addSubview:self.remoteView];
    
    self.localView = [[UIView alloc] init];
    self.localView.backgroundColor = [UIColor lightGrayColor];
    //self.localView.frame = CGRectMake(0,[[UIScreen mainScreen] bounds].size.width + 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
    
    self.localView.frame = CGRectMake(0,[[UIScreen mainScreen] bounds].size.height + 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    [viewbg addSubview:self.localView];
    
    UIButton *btnInitRtcEngine = [UIButton buttonWithType:UIButtonTypeCustom];
    btnInitRtcEngine.frame = CGRectMake(0, 40, 70, 40);
    [btnInitRtcEngine setTitle:@"initRtc" forState:UIControlStateNormal];
    [btnInitRtcEngine setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnInitRtcEngine.backgroundColor = [UIColor greenColor];
    btnInitRtcEngine.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnInitRtcEngine addTarget:self action:@selector(btnInitRtcEngineAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnInitRtcEngine];
    
    UIButton *btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJoinChannel.frame = CGRectMake(0, 90, 70, 40);
    [btnJoinChannel setTitle:@"加入" forState:UIControlStateNormal];
    [btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor greenColor];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnJoinChannel];
    
    UIButton *btnInitMediaPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnInitMediaPlay.frame = CGRectMake(0, 140, 70, 40);
    [btnInitMediaPlay setTitle:@"initPlay" forState:UIControlStateNormal];
    [btnInitMediaPlay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnInitMediaPlay.backgroundColor = [UIColor greenColor];
    btnInitMediaPlay.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnInitMediaPlay addTarget:self action:@selector(btnInitMediaPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbg addSubview:btnInitMediaPlay];
    
    
}


-(void)btnBackAction:(UIButton *) button {
    NSLog(@"打印了 点击返回btnBackAction");
    
    
    
    
    [self.mediaPlayerKit play];
}

-(void)btnInitRtcEngineAction:(UIButton *) button {
    NSLog(@"打印了 点击btnInitRtcEngineAction");
    
    [self initAgoraRtcInfo];
    
}

-(void) initAgoraRtcInfo {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = AppId;
    config.channelProfile = AgoraChannelProfileLiveBroadcasting;
    
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    
    [self.agoraKit setClientRole:AgoraClientRoleAudience];
    
    
    [self.agoraKit enableLocalAudio:NO];
    [self.agoraKit enableVideo];
    
    [self.agoraKit setDefaultAudioRouteToSpeakerphone:YES];
    
    
}

-(void)btnInitMediaPlayAction:(UIButton *) button{
    self.mediaPlayerKit = [self.agoraKit createMediaPlayerWithDelegate:self];
    [self.mediaPlayerKit setPlayerOption:@"play_pos_change_callback" value:100];
    //NSString *strmusicurl = [[NSBundle mainBundle] pathForResource:@"daojiangxing" ofType:@"mp3"];
    //NSString *strmusicurl = @"rtmp://push.webdemo.agoraio.cn/lbhd/zsncna";
    [self.mediaPlayerKit setView:self.localView];
    //NSString *strmusicurl = @"https://agora-adc-artifacts.s3.cn-north-1.amazonaws.com.cn/resources/sample.mp4";
    NSString *strmusicurl = @"rtmp://l6hpmqy9874fd0rrq.boin.fun/live/2030726382?token=51a1e4b528b0e5cf76e8b6b2293d4998&t=1694539852";
    //NSString *strmusicurl = @"";
    [self.mediaPlayerKit open:strmusicurl startPos:0];
}



-(void)btnJoinChannelAction:(UIButton *) button {
    NSLog(@"打印了 点击btnJoinChannelAction");
    
    NSInteger iresult2 = [self.agoraKit joinChannelByToken:Token channelId:channelname info:nil uid:1177215367 joinSuccess:nil];
    NSLog(@"打印了 joinChannelByToken result值 %ld",(long)iresult2);
    
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



@end
