//
//  ZSNMPMusicPlayerVC.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/5/4.
//

#import "ZSNMPMusicPlayerVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface ZSNMPMusicPlayerVC ()<MPMediaPickerControllerDelegate,AgoraRtcEngineDelegate>

@property (nonatomic, strong) MPMediaPickerController *mediaPicker;//媒体选择控制器
@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;//音乐播放器


@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIButton *btnRoleChoose;
@property (nonatomic, strong) UIButton *btnJoinChannel;
@property (nonatomic, strong) UIButton *btnSendAudio;

@property (nonatomic, assign) BOOL isJoinChannel;
@property (nonatomic, assign) BOOL isRoleBroadcaster;
@property (nonatomic, assign) BOOL isSendAudio;

@end

@implementation ZSNMPMusicPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAny];
    self.mediaPicker.allowsPickingMultipleItems = YES;//允许多选
    self.mediaPicker.showsCloudItems = YES;//显示icloud选项
    self.mediaPicker.prompt = @"请选择音乐";
    self.mediaPicker.delegate = self;//设置选择器代理
    
    UIButton *btnSelectClick = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSelectClick.frame = CGRectMake(20, 100, 170, 40);
    [btnSelectClick setTitle:@"SelectClick" forState:UIControlStateNormal];
    [btnSelectClick setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnSelectClick.backgroundColor = [UIColor greenColor];
    btnSelectClick.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnSelectClick addTarget:self action:@selector(btnSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectClick];
    
    
    UIButton *btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlay.frame = CGRectMake(20, 150, 170, 40);
    [btnPlay setTitle:@"Play" forState:UIControlStateNormal];
    [btnPlay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnPlay.backgroundColor = [UIColor greenColor];
    btnPlay.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnPlay addTarget:self action:@selector(btnPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlay];
    
    UIButton *btnPause = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPause.frame = CGRectMake(20, 200, 170, 40);
    [btnPause setTitle:@"Pause" forState:UIControlStateNormal];
    [btnPause setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnPause.backgroundColor = [UIColor greenColor];
    btnPause.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnPause addTarget:self action:@selector(btnPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPause];
    
    UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStop.frame = CGRectMake(20, 250, 170, 40);
    [btnStop setTitle:@"Stop" forState:UIControlStateNormal];
    [btnStop setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnStop.backgroundColor = [UIColor greenColor];
    btnStop.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnStop addTarget:self action:@selector(btnStopAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStop];
    
    UIButton *btnNextMusic = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNextMusic.frame = CGRectMake(20, 300, 170, 40);
    [btnNextMusic setTitle:@"NextMusic" forState:UIControlStateNormal];
    [btnNextMusic setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnNextMusic.backgroundColor = [UIColor greenColor];
    btnNextMusic.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnNextMusic addTarget:self action:@selector(btnNextMusicAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNextMusic];
    
    UIButton *btnPreviousItem = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPreviousItem.frame = CGRectMake(20, 350, 170, 40);
    [btnPreviousItem setTitle:@"PreviousItem" forState:UIControlStateNormal];
    [btnPreviousItem setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnPreviousItem.backgroundColor = [UIColor greenColor];
    btnPreviousItem.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnPreviousItem addTarget:self action:@selector(btnPreviousItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPreviousItem];
    
    self.btnJoinChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnJoinChannel.frame = CGRectMake(202, [[UIScreen mainScreen] bounds].size.width + 100, 170, 40);
    [self.btnJoinChannel setTitle:@"加入频道" forState:UIControlStateNormal];
    [self.btnJoinChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btnJoinChannel.backgroundColor = [UIColor greenColor];
    self.btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.btnJoinChannel addTarget:self action:@selector(btnJoinChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnJoinChannel];
    
    
    
    self.isJoinChannel = NO;
    self.isRoleBroadcaster = NO;
    self.isSendAudio = NO;
    
    
}

- (void)dealloc {
    [self.musicPlayer endGeneratingPlaybackNotifications];//关闭播放通知
}

//创建媒体选择器，返回媒体选择器
//-(MPMediaPickerController *)mediaPicker {
//    if(!_mediaPicker) {
//        //初始化媒体选择器，这里设置媒体类型为音乐，其实这里也可以选择视频、广播等
//        _mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAny];
//        _mediaPicker.allowsPickingMultipleItems = YES;//允许多选
//        _mediaPicker.showsCloudItems = YES;//显示icloud选项
//        _mediaPicker.prompt = @"请选择音乐";
//        _mediaPicker.delegate = self;//设置选择器代理
//    }
//    return _mediaPicker;
//}

//音乐播放器
-(MPMusicPlayerController *)musicPlayer {
    if(!_musicPlayer) {
        _musicPlayer = [MPMusicPlayerController systemMusicPlayer];
        [_musicPlayer beginGeneratingPlaybackNotifications];//开启通知，否则监控不到MPMusicPlayerController的通知
        [self addNotification];//添加通知
        
        //如果不使用MPMediaPickerController可以使用如下方法获得音乐库媒体队列
        //[_musicPlayer setQueueWithItemCollection:[self getLocalMediaItemCollection]];
    }
    return _musicPlayer;
}

//获取媒体队列

-(MPMediaQuery *) getLocalMediaQuery {
    MPMediaQuery *mediaQueue = [MPMediaQuery songsQuery];
    for (MPMediaItem *item in mediaQueue.items) {
        NSLog(@"标题 %@ %@",item.title,item.albumTitle);
    }
    return mediaQueue;
}

//获取媒体集合
-(MPMediaItemCollection *)getLocalMediaItemCollection {
    MPMediaQuery *mediaQueue = [MPMediaQuery songsQuery];
    NSMutableArray *array = [NSMutableArray array];
    for (MPMediaItem *item in mediaQueue.items) {
        [array addObject:item];
        NSLog(@"标题 %@ %@",item.title,item.albumTitle);
    }
    MPMediaItemCollection *mediaItemCollection = [[MPMediaItemCollection alloc] initWithItems:[array copy]];
    return mediaItemCollection;
}

//MPMediaPickerController代理方法
-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    MPMediaItem *mediaItem = [mediaItemCollection.items firstObject];//第一个播放音乐
    //注意很多音乐信息如标题、专辑、表演者、封面、时长等信息都可以通过MPMediaItem的valueForKey:方法得到,但是从iOS7开始都有对应的属性可以直接访问
        //    NSString *title= [mediaItem valueForKey:MPMediaItemPropertyAlbumTitle];
        //    NSString *artist= [mediaItem valueForKey:MPMediaItemPropertyAlbumArtist];
        //    MPMediaItemArtwork *artwork= [mediaItem valueForKey:MPMediaItemPropertyArtwork];
        //UIImage *image=[artwork imageWithSize:CGSizeMake(100, 100)];//专辑图片
    NSLog(@"标题 %@ ,表演者 %@ ,专辑 %@",mediaItem.title,mediaItem.artist,mediaItem.albumTitle);
    [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//取消选择
-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//通知
-(void) addNotification {
    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(playbackStateChange:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
}

//播放状态改变通知 ,notification 通知对象
-(void) playbackStateChange:(NSNotification *) notification {
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
            
        case MPMusicPlaybackStatePaused:
            NSLog(@"播放暂停");
            break;
            
        case MPMusicPlaybackStateStopped:
            NSLog(@"播放停止");
            break;
            
        default:
            break;
    }
}


-(void) btnSelectClickAction:(UIButton *) sender {
    [self presentViewController:self.mediaPicker animated:YES completion:nil];
}

-(void)btnPlayAction:(UIButton *) sender {
    [self.musicPlayer play];
}

-(void)btnPauseAction:(UIButton *) sender {
    [self.musicPlayer pause];
}

-(void)btnStopAction:(UIButton *)sender {
    [self.musicPlayer stop];
}

-(void) btnNextMusicAction :(UIButton *)sender {
    [self.musicPlayer skipToNextItem];
}

-(void)btnPreviousItemAction :(UIButton *)sender {
    [self.musicPlayer skipToPreviousItem];
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
    [self.agoraKit disableVideo];
    
    //AgoraVideoOutputOrientationMode
    //AgoraVideoMirrorMode
    
    //AgoraRtcChannelMediaOptions
    AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
    
    NSInteger result = [self.agoraKit joinChannelByToken:Token channelId:channelname uid:0 mediaOptions:options joinSuccess:nil];
    
    NSLog(@"打印了 joinChannelByToken result值 %ld",(long)result);
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
        //[self.btnRoleChoose setTitle:@"点击变为观众" forState:UIControlStateNormal];
        //[self.btnRoleChoose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else if (newRole == AgoraClientRoleAudience) {
        self.isRoleBroadcaster = NO;
        NSLog(@"打印了 点击了 didClientRoleChanged 直播场景下用户角色已切换回调 为观众");
        //[self.btnRoleChoose setTitle:@"点击变为主播" forState:UIControlStateNormal];
        //[self.btnRoleChoose setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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
