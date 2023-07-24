//
//  ZSNTestViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2023/5/23.
//

#import "ZSNTestViewController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>


#import <AgoraRtcKit/AgoraRtcEngineKitEx.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
//#import "SLLiveRoomModel.h"//房间信息模型
//#import "SLEngineVolumModel.h"
//#import "SLRoomManager.h"
//#import "SLLiveRoomScene.h"
//#import "SLLiveRoomScene+View.h"
//#import "MIKIThirdPart.h"
//#import <Hydra/MiKiDispatch.h>

//#import <>
//#import <>

@interface ZSNTestViewController ()<MPMediaPickerControllerDelegate,AgoraRtcEngineDelegate>
@property (nonatomic, strong) AgoraRtcEngineKit * agoraKit;

@property (nonatomic, strong) UIButton *btnJoinChannel;

@property(nonatomic, strong) AgoraRtcEngineKit *rtcKit;


//@property(nonatomic, assign, readwrite) SLLiveClientRole clientRole;
///// RTC重连次数
//@property(nonatomic, assign) NSInteger roomRtcTryCount;
///// 是否需要重新登录RTC
//@property(nonatomic, assign) BOOL isRejoinRoomRtc;
///// 存放声网上行音频质量数组
//@property (nonatomic,strong) NSMutableArray <NSNumber *> *agoraUpstreamAudioQuality;
///// 存放声网下行音频质量数组
//@property (nonatomic,strong) NSMutableArray <NSNumber *> *agoraDownstreamAudioQuality;
//@property (nonatomic,strong) NSMutableArray <NSNumber *> *lastmiledelayRtt;
//@property (nonatomic,strong) NSMutableArray <NSNumber *> *agoraUpstreamRtt;
//@property (nonatomic,strong) NSMutableArray <NSNumber *> *agoraDownstreamRtt;
///// 屏幕共享channelId
//@property (nonatomic,copy) NSString *shareScreenChannelId;


@end

@implementation ZSNTestViewController

//@synthesize clientRole = _clientRole;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}


-(void) btnSelectClickAction:(UIButton *) sender {
    //[self presentViewController:self.mediaPicker animated:YES completion:nil];
}

-(void)btnPlayAction:(UIButton *) sender {
    //[self.musicPlayer play];
}

-(void)btnPauseAction:(UIButton *) sender {
    //[self.musicPlayer pause];
}

-(void)btnStopAction:(UIButton *)sender {
    //[self.musicPlayer stop];
}

-(void) btnNextMusicAction :(UIButton *)sender {
    //[self.musicPlayer skipToNextItem];
}

-(void)btnPreviousItemAction :(UIButton *)sender {
    //[self.musicPlayer skipToPreviousItem];
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


//
////1V1要用到
//-(void)joinRoomRtcChanelBy:(NSString *)roomId
//                  rtcToken:(NSString *)rtcToken
//                completion:(void(^)(BOOL success))completion{
//    self.roomId = roomId;
//    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
//    options.autoSubscribeAudio = YES;
//    options.autoSubscribeVideo = YES;
//    options.publishCameraTrack = NO;
//    int state = [self.rtcKit joinChannelByToken:rtcToken channelId:roomId uid:SLSignInstance.displayUserId.integerValue mediaOptions:options joinSuccess:nil];
//    if (state ==0) {
//        if (completion)completion(YES);
//    }else{
//        if (completion)completion(NO);
//    }
//    MIKILogInfo("AgoraRtcKit", @"1V1 rtcKitLoginState:%d roomId:%@",state, SLRoomManager.roomId);
//}
//
//#pragma mark - 操作房间服务
//-(void)joinRoomRtcChanel{
//    if (!self.delegate|| !self.delegate.roomModel) return;
//    self.roomId = self.delegate.roomModel.liveRoomInfo.roomId;
//    AgoraRtcChannelMediaOptions *options = [AgoraRtcChannelMediaOptions new];
//    options.autoSubscribeAudio = YES;
//    options.autoSubscribeVideo = YES;
//    options.publishCameraTrack = NO;
//    int state = [self.rtcKit joinChannelByToken:self.delegate.roomModel.agoraToken.rtcToken channelId:self.roomId uid:SLSignInstance.displayUserId.integerValue mediaOptions:options joinSuccess:nil];
//    NSLog(@"token:%@",self.delegate.roomModel.agoraToken.rtcToken);
//    NSLog(@"roomId:%@",self.roomId);
//    NSLog(@"uid:%@",SLSignInstance.displayUserId);
//    MIKILogInfo("AgoraRtcKit", @"进入房间 rtcKitJoinState:%d roomId:%@",state, SLRoomManager.roomId);
//}
//
///// 离开房间
//- (void)leaveRoom:(BOOL)isAsync{
//    [super leaveRoom:isAsync];
//
//    MIKILogInfo("AgoraRtcKit", @"离开房间 rtcKitLeave roomId:%@ ", SLRoomManager.roomId);
//
//    [MiKiAnalyticsReportUtil reportedAnalyseData:@{@"sdk_type":@1,@"tx_packetloss":[self.agoraUpstreamRtt componentsJoinedByString:@","],@"rx_packetloss":[self.agoraDownstreamRtt componentsJoinedByString:@","],@"lastmiledelay":[self.lastmiledelayRtt componentsJoinedByString:@","]} eventName:@"audio_report"];
//    if (SLRoomManager.shareManager.roomScene.playerState != livePlayerMusicStateNone) {
//        [self stopAudio];
//        if (self.displayLink) {
//            [self.displayLink invalidate];
//            self.displayLink = nil;
//        }
//    }
//    [MiKiAnalyticsReportUtil reportedAnalyseData:@{@"sdk_type":@1,@"up_quality_count":[self.agoraUpstreamAudioQuality componentsJoinedByString:@","],@"down_quality_count":[self.agoraDownstreamAudioQuality componentsJoinedByString:@","]} eventName:@"audio_quality"];
//    [self.agoraUpstreamAudioQuality removeAllObjects];
//    [self.agoraUpstreamAudioQuality addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)]];
//    [self.agoraDownstreamAudioQuality removeAllObjects];
//    [self.agoraDownstreamAudioQuality addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)]];
//#if DEBUG
//        [[SLLiveLogView shareLogView] addLog:@"Agora rtc 离开房间"];
//#endif
//    [SLRoomManager.shareManager.roomScene.screenShareEngine leaveShareScreenChannel:isAsync];
//
//    //不是异步
//    if (isAsync == NO) {
//        [self.rtcKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
//            dispatch_miki_async(dispatch_get_miki_main_queue(), ^{
//                NSNotificationPostNotification(NSNotificationLeaveChannelComplete, nil, nil);
//            });
//        }];
//        return;
//    }
//    dispatch_miki_async(dispatch_get_miki_channel_queue(), ^{
//        [self.rtcKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSNotificationPostNotification(NSNotificationLeaveChannelComplete, nil, nil);
//            });
//        }];
//    });
//}
//
///// 设置语音发言角色
//- (void)setVoiceClientRole:(SLLiveClientRole)clientRole{
//    _clientRole = clientRole;
//    if (clientRole == SLLiveClientRoleBroadcaster) {
////        [SLRoomManager.shareManager.roomScene.screenShareEngine muteScreenShareAudio:YES];//关闭屏幕共享的音频，切换至原通道，兼容旧版获取声音来源
//        [self.rtcKit setClientRole:AgoraClientRoleBroadcaster];
//    }else if (clientRole == SLLiveClientRoleAudience) {
////        [self.roomChannel setClientRole:(AgoraClientRoleAudience)];
////        //重新开启屏幕共享的音频
////        [SLRoomManager.shareManager.roomScene.screenShareEngine muteScreenShareAudio:NO];
//        [self.rtcKit setClientRole:AgoraClientRoleAudience];
//    }
//    //    SLLiveClientRoleBroadcaster = 1,//主播
////    SLLiveClientRoleAudience = 2,//观众
//    MIKILogInfo("AgoraRtcKit", @"角色变化 setVoiceClientRole:%@ roomId:%@",clientRole ==1 ?@"主播":@"观众", SLRoomManager.roomId);
//
//}
//
///// 取消或恢复发布本地音频流 type:0 取消发布本地音频流 -1：只取消发布麦克风 1:恢复（音频有来源有可能是音频engine，也有可能是视频engine）
//- (void)forceMuteLocalAudioStream:(NSInteger)type{
//    if (type == 0) {
//        [self.rtcKit enableLocalAudio:NO];
//        [self.rtcKit muteLocalAudioStream:YES];
//    }else if (type == -1){
//        [self.rtcKit muteLocalAudioStream:(self.clientRole != SLLiveClientRoleBroadcaster)];
//        [self.rtcKit enableLocalAudio:NO];
////        [_rtcKit adjustRecordingSignalVolume:0];
//    }else{
//        [self.rtcKit muteLocalAudioStream:(self.clientRole != SLLiveClientRoleBroadcaster)];
//        [self.rtcKit enableLocalAudio:YES];
////        [_rtcKit adjustRecordingSignalVolume:100];
//    }
//    MIKILogInfo("AgoraRtcKit", @"取消或恢复发布本地音频流 type:0 取消发布本地音频流 -1：只取消发布麦克风 1:恢复（音频有来源有可能是音频engine，也有可能是视频engine）forceMuteLocalAudioStream:%ld",type);
//}
//
///// 取消或恢复订阅所有远端用户的音频流 YES:取消
//- (void)muteAllRemoteAudioStreams:(BOOL)mute{
//    [super muteAllRemoteAudioStreams:mute];
//    if (mute) {
//        [_rtcKit adjustPlaybackSignalVolume:0];
//        [_rtcKit adjustAudioMixingPlayoutVolume:0];
//    }else{
//        [_rtcKit adjustPlaybackSignalVolume:100];
//        [_rtcKit adjustAudioMixingPlayoutVolume:100];
//    }
//    MIKILogInfo("AgoraRtcKit", @"取消或恢复订阅所有远端用户的音频流 YES:取消 muteAllRemoteAudioStreams:%@ roomId:%@",mute?@"取消订阅":@"订阅", SLRoomManager.roomId);
//}
//
//- (int)setEnableSpeakerphone:(BOOL)enableSpeaker {
//    int state = [_rtcKit setEnableSpeakerphone:enableSpeaker];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 设置是否允许外放 setEnableSpeakerphone %@ state:%d roomId:%@",enableSpeaker?@"允许":@"不允许",state,SLRoomManager.roomId);
//    return state;
//}
//
//- (int)setDefaultAudioRouteToSpeakerphone:(BOOL)enableSpeaker {
//    int state = [_rtcKit setDefaultAudioRouteToSpeakerphone:enableSpeaker];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 设置默认是否允许扩音器 setDefaultAudioRouteToSpeakerphone %@ state:%d roomId:%@",enableSpeaker?@"允许":@"不允许",state,SLRoomManager.roomId);
//    return state;
//}
//
///// 销毁
//+ (void)destroy{
//    MIKILogInfo("AgoraRtcKit", @"rtckit 销毁 AgoraRtcEngineKit  roomId:%@",SLRoomManager.roomId);
//    [AgoraRtcEngineKit destroy];
//}
//
//#pragma mark - 音频相关的
///// 播放音效文件
///// @param filePath 音效文件路径
///// @param effectId 音效Id
///// @param loop 播放次数
//-(void)playAudioEffectFile:(NSString *)filePath
//                  effectId:(int)effectId
//                      loop:(int)loop
//{
//    int state = [_rtcKit playEffect:effectId filePath:filePath loopCount:loop ==1?0:loop pitch:1 pan:0 gain:50 publish:NO startPos:0];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 播放音效文件 playAudioEffectFile state:%d effectId:%d roomId:%@",state,effectId,SLRoomManager.roomId);
//}
////暂停播放音效文件
//-(void)pauseAudioEffectFile:(int)effectId{
//    int state = [_rtcKit pauseEffect:effectId];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 暂停播放音效文件 pauseAudioEffectFile state:%d effectId:%d roomId:%@",state,effectId,SLRoomManager.roomId);
//}
//
///// 停止播放音效文件
///// @param effectId 音效Id
//-(void)stopAudioEffect:(int)effectId{
//    int state = [_rtcKit stopEffect:effectId];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 停止播放音效文件 stopAudioEffect state:%d effectId:%d roomId:%@",state,effectId,SLRoomManager.roomId);
//}
///// 恢复播放音效文件
///// @param effectId 音效文件Id
//-(void)resumeAudioEffect:(int)effectId{
//    int state = [_rtcKit resumeEffect:effectId];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 恢复播放音效文件 resumeAudioEffect state:%d effectId:%d roomId:%@",state,effectId,SLRoomManager.roomId);
//}
///// 暂停所有音效文件播放
//-(void)pauseAllAudioEffect{
//    int state = [_rtcKit pauseAllEffects];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 暂停所有音效文件播放 pauseAllAudioEffect state:%d roomId:%@",state,SLRoomManager.roomId);
//}
///// 播放音频文件
///// @param filePath 文件路径
//- (void)playAudioWithFile:(NSString*)filePath{
//    //空打断回调
//    if (filePath.length <= 0) {
//        self.filePath = nil;
//        self.playerStatus = livePlayerMusicStateNone;
//        self.currentTime = 0;
//        self.totalTime = 0;
//        [self stopAudio];
//        [self displayCallBack];
//        return;
//    }
////    //处理播放路径相同的
////    if ([self.filePath isEqualToString:filePath] && self.playerStatus == livePlayerMusicStatePlaying) {
////        return;
////    }
//    //先停止播放
//    if (self.playerStatus == livePlayerMusicStatePlaying) {
//        [self stopAudio];
//    }
//    self.filePath = filePath;
//    __unused int state  = [self.rtcKit startAudioMixing:filePath loopback:NO cycle:1 startPos:0];
//    //设置一下音量
//    [self adjustAudioVolume:self.volume];
//    self.totalTime = 0;
//    //读取音乐时长
//    self.totalTime = [self.rtcKit getEffectDuration:self.filePath];
//    self.currentTime = 0;
//}
//#pragma mark --YES: 重新开启本地语音功能，即开启本地语音采集（默认）NO: 关闭本地语音功能，即停止本地语音采集或处理
//-(int)enableLocalAudio:(BOOL)mute{
//    int state = [_rtcKit enableLocalAudio:mute];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 重新开启本地语音功能，即开启本地语音采集（默认）NO: 关闭本地语音功能，即停止本地语音采集或处理 enableLocalAudio %@ state:%d roomId:%@",mute ?@"开启":@"关闭",state,SLRoomManager.roomId);
//    return state;
//}
//
//-(void)stopAuioPassive{
//    int state = [_rtcKit stopAudioMixing];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 停止混音 stopAuioPassive state:%d roomId:%@",state,SLRoomManager.roomId);
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(stopAuioByRoomTypeChange)]) {
//            [obj stopAuioByRoomTypeChange];
//        }
//    }];
//    if (isSuccess)[self.lock unlock];
//}
///// 停止播放
//- (void)stopAudio{
//    int state = [_rtcKit stopAudioMixing];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 暂停音频停止播放 stopAudio state:%d roomId:%@",state,SLRoomManager.roomId);
//}
//
///// 恢复音频播放
//- (void)resumeAudio{
//   int state = [_rtcKit resumeAudioMixing];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 暂停音频恢复播放 resumeAudio state:%d roomId:%@",state,SLRoomManager.roomId);
//    //设置一下音量
//   [self adjustAudioVolume:self.volume];
//}
//
///// 暂停音频播放
//- (void)pauseAudio{
//    int state = [_rtcKit pauseAudioMixing];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 暂停音频播放 pauseAudio state:%d roomId:%@",state,SLRoomManager.roomId);
//}
//
///// 设置音频播放位置
///// @param position 时间进度 %
//- (void)setAudioPosition:(CGFloat)position{
//    int state = [_rtcKit setAudioMixingPosition:position];
//    MIKILogInfo("AgoraRtcKit", @"rtckit 调整音效文件播放位置  setAudioPosition position:%f state:%d roomId:%@",position,state,SLRoomManager.roomId);
//}
//
///// 设置音频播放音量
///// @param volume 0-100
//- (void)adjustAudioVolume:(int)volume{
//    MIKILogInfo("AgoraRtcKit", @"rtckit 调整音量  adjustAudioVolume %d  roomId:%@",volume,SLRoomManager.roomId);
//    self.volume = volume;
//    [_rtcKit adjustAudioMixingVolume:self.volume];
//}
///// 播放更新回调
//- (void)displayCallBack{
//
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(audioEngine:currentTime:totalTime:progress:)]) {
//            CGFloat progress = 0;
//            CGFloat currentTime = self.currentTime;
//            if (self.totalTime > 0 && self.filePath.length > 0) {
//                progress = currentTime / (CGFloat)self.totalTime;
//            }
//            [obj audioEngine:self currentTime:currentTime totalTime:self.totalTime progress:progress];
//
//        }
//    }];
//    if (isSuccess)[self.lock unlock];
//
//}
//
//
//
///// 刷新RTCToken
//- (void)refreshRoomRTCToken{
//    MIKILogInfo("AgoraRtcKit", @"rtckit 刷新rtcToken  rtckitrefreshRoomRTCToken  roomId:%@",SLRoomManager.roomId);
//
//    if (_roomRtcTryCount > 15) return;
//    kWeakSelf;
//    SLLog(@"RTC重连次数:%ld",_roomRtcTryCount);
//    [SLRoomManager.shareManager requestRtmToken:^(SLRoomStreamToken * _Nonnull rtmToken) {
//        weakSelf.delegate.roomModel.agoraToken.rtcToken = rtmToken.rtcToken;
//
//        if (weakSelf.isRejoinRoomRtc) {
//            [weakSelf joinRoomRtcChanelBy:weakSelf.roomId rtcToken:rtmToken.rtcToken completion:^(BOOL success){
//                if (!success) {
//                    weakSelf.roomRtcTryCount++;
//                }
//            }];
//            return;
//        }
//        [weakSelf.rtcKit renewToken:rtmToken.rtcToken];
//    } retryMaxCount:1];
//
//}
//
//#pragma mark - AgoraRtcEngineDelegate
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed{
//    MIKILogInfo("AgoraRtcKit", @"rtckit加入频道成功  didJoinChannel channel:%@  uid:%ld elapsed:%ld roomId:%@",channel,uid,elapsed,SLRoomManager.roomId);
//    _roomRtcTryCount = 0;
//    _isRejoinRoomRtc = NO;
//    //手动恢复
//#if DEBUG
//    [[SLLiveLogView shareLogView] addLog:@"声网RTC加入房间成功"];
//#endif
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(audioEngineJoinRoomSuccess)]) {
//            [obj audioEngineJoinRoomSuccess];
//        }
//    }];
//    if (isSuccess)[self.lock unlock];
//}
//
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine didClientRoleChanged:(AgoraClientRole)oldRole newRole:(AgoraClientRole)newRole{
//    MIKILogInfo("AgoraRtcKit", @"rtckit角色发生变化  didClientRoleChanged oldRole:%ld  newRole:%ld roomId:%@",oldRole,newRole,SLRoomManager.roomId);
//    //设置当前角色
//    if (oldRole == newRole) return;
//    if (newRole == AgoraClientRoleBroadcaster) {
//        [self setVoiceClientRole:SLLiveClientRoleBroadcaster];
//    }else{
//        [self setVoiceClientRole:SLLiveClientRoleAudience];
//    }
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(audioEngine:currentRole:oldRole:)]) {
//            [obj audioEngine:self currentRole:[@(newRole) integerValue] oldRole:[@(oldRole) integerValue]];
//        }
//    }];
//    if (isSuccess)[self.lock unlock];
//}
//
///** Occurs when the network connection state changes.*/
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine connectionChangedToState:(AgoraConnectionState)state reason:(AgoraConnectionChangedReason)reason{
//    MIKILogInfo("AgoraRtcKit", @"rtckit链接状态变化  connectionChangedToState:%ld  roomId:%@",state,SLRoomManager.roomId);
//
//    //离开通道，重新加入
//    if (state == AgoraConnectionStateFailed && reason == AgoraConnectionChangedReasonJoinFailed) {
//        [engine leaveChannel:nil];
//        _isRejoinRoomRtc = YES;
//        method_execute_frequency(self, @selector(refreshRoomRTCToken), kMethodOnceDuration);
//    }
//}
//
///** Occurs when the token expires in 30 seconds.*/
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine tokenPrivilegeWillExpire:(NSString *)token{
//    MIKILogInfo("AgoraRtcKit", @"rtcToken即将过期 tokenPrivilegeWillExpire  roomId:%@",SLRoomManager.roomId);
//    method_execute_frequency(self, @selector(refreshRoomRTCToken), kMethodOnceDuration);
//}
//
///** Occurs when the token expires. */
//- (void)rtcEngineRequestToken:(AgoraRtcEngineKit *)engine{
//    MIKILogInfo("AgoraRtcKit", @"rtcToken过期续签 rtcEngineRequestToken  roomId:%@",SLRoomManager.roomId);
//    method_execute_frequency(self, @selector(refreshRoomRTCToken), kMethodOnceDuration);
//}
//
///** Reports the last mile network quality of each user in the channel once every two seconds.*/
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine networkQuality:(NSUInteger)uid txQuality:(AgoraNetworkQuality)txQuality rxQuality:(AgoraNetworkQuality)rxQuality{
//    MIKILogInfo("AgoraRtcKit", @"reportRtcStats状态回调 networkQuality txQuality:%ld rxQuality:%ld roomId:%@",txQuality,rxQuality, SLRoomManager.roomId);
//    if (uid)return;
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(networkQualityOnChange:rxQuality:)]) {
//            [obj networkQualityOnChange:txQuality rxQuality:rxQuality];
//        }
//    }];
//    if (isSuccess)  [self.lock unlock];
//
//    if (rxQuality>=self.agoraDownstreamAudioQuality.count)return;
//    NSNumber *downQualityNumber = self.agoraDownstreamAudioQuality[rxQuality];
//    [self.agoraDownstreamAudioQuality replaceObjectAtIndex:rxQuality withObject:@([downQualityNumber integerValue] +1)];
//
//
//    if (txQuality >=self.agoraUpstreamAudioQuality.count) return;
//    NSNumber *upQualityNumber = self.agoraUpstreamAudioQuality[txQuality];
//    [self.agoraUpstreamAudioQuality replaceObjectAtIndex:txQuality withObject:@([upQualityNumber integerValue] +1)];
//
//}
//
///** Reports the statistics of the current call. The SDK triggers this callback once every two seconds after the user joins the channel.*/
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportRtcStats:(AgoraChannelStats *)stats{
//
//    MIKILogInfo("AgoraRtcKit", @"reportRtcStats状态回调 reportRtcStats lastmileDelay:%ld  roomId:%@",stats.lastmileDelay, SLRoomManager.roomId);
//
//    BOOL isSuccess  = [self.lock tryLock];
//
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(netDelayOnChange:)]) {
//            [obj netDelayOnChange:stats.lastmileDelay];;
//        }
//    }];
//    if (isSuccess)  [self.lock unlock];
//
//
//
//    // n0是统计用户在房间这段时间回调的网络延迟（单位毫秒）落在[0,100)区间的次数（回调时间间隔2秒）
//     //    n1是统计网络延迟（单位毫秒）落在[100,500)区间的次数
//     //    n2是统计网络延迟（单位毫秒）落在[500,1000)区间的次数
//     //    n3是统计网络延迟（单位毫秒）落在[1000,2000)区间的次数
//     //    n4是统计网络延迟（单位毫秒）落在[2000,5000)区间的次数
//     //    n5是统计网络延迟（单位毫秒）落在[5000,+∞）区间的次数
//     NSInteger rtt = stats.lastmileDelay;
//     if (rtt<100) {
//         NSNumber *rtt0 = self.lastmiledelayRtt[0];
//         [self.lastmiledelayRtt replaceObjectAtIndex:0 withObject:@([rtt0 integerValue]+1)];
//     }else if (rtt >= 100 && rtt<500) {
//         NSNumber *rtt1 = self.lastmiledelayRtt[1];
//         [self.lastmiledelayRtt replaceObjectAtIndex:1 withObject:@([rtt1 integerValue]+1)];
//     }else if (rtt >=500 && rtt <1000){
//         NSNumber *rtt2 = self.lastmiledelayRtt[2];
//         [self.lastmiledelayRtt replaceObjectAtIndex:2 withObject:@([rtt2 integerValue]+1)];
//     }else if (rtt >=1000 && rtt <2000){
//         NSNumber *rtt3 = self.lastmiledelayRtt[3];
//         [self.lastmiledelayRtt replaceObjectAtIndex:3 withObject:@([rtt3 integerValue]+1)];
//     }else if (rtt >=2000 && rtt<5000){
//         NSNumber *rtt4 = self.lastmiledelayRtt[4];
//         [self.lastmiledelayRtt replaceObjectAtIndex:4 withObject:@([rtt4 integerValue]+1)];
//     }else if (rtt>=5000){
//         NSNumber *rtt5 = self.lastmiledelayRtt[5];
//         [self.lastmiledelayRtt replaceObjectAtIndex:5 withObject:@([rtt5 integerValue]+1)];
//     }
//
//
//    NSInteger uprtt = stats.txKBitrate;
//    if (uprtt<100) {
//        NSNumber *rtt0 = self.agoraUpstreamRtt[0];
//        [self.agoraUpstreamRtt replaceObjectAtIndex:0 withObject:@([rtt0 integerValue]+1)];
//    }else if (uprtt >= 100 && uprtt<500) {
//        NSNumber *rtt1 = self.agoraUpstreamRtt[1];
//        [self.agoraUpstreamRtt replaceObjectAtIndex:1 withObject:@([rtt1 integerValue]+1)];
//    }else if (uprtt >=500 && uprtt <1000){
//        NSNumber *rtt2 = self.agoraUpstreamRtt[2];
//        [self.agoraUpstreamRtt replaceObjectAtIndex:2 withObject:@([rtt2 integerValue]+1)];
//    }else if (uprtt >=1000 && uprtt <2000){
//        NSNumber *rtt3 = self.agoraUpstreamRtt[3];
//        [self.agoraUpstreamRtt replaceObjectAtIndex:3 withObject:@([rtt3 integerValue]+1)];
//    }else if (uprtt >=2000 && uprtt<5000){
//        NSNumber *rtt4 = self.agoraUpstreamRtt[4];
//        [self.agoraUpstreamRtt replaceObjectAtIndex:4 withObject:@([rtt4 integerValue]+1)];
//    }else if (uprtt>=5000){
//        NSNumber *rtt5 = self.agoraUpstreamRtt[5];
//        [self.agoraUpstreamRtt replaceObjectAtIndex:5 withObject:@([rtt5 integerValue]+1)];
//    }
//
//    NSInteger rxrtt = stats.rxKBitrate;
//    if (rxrtt<100) {
//        NSNumber *rtt0 = self.agoraDownstreamRtt[0];
//        [self.agoraDownstreamRtt replaceObjectAtIndex:0 withObject:@([rtt0 integerValue]+1)];
//    }else if (rxrtt >= 100 && rxrtt<500) {
//        NSNumber *rtt1 = self.agoraDownstreamRtt[1];
//        [self.agoraDownstreamRtt replaceObjectAtIndex:1 withObject:@([rtt1 integerValue]+1)];
//    }else if (rxrtt >=500 && rxrtt <1000){
//        NSNumber *rtt2 = self.agoraDownstreamRtt[2];
//        [self.agoraDownstreamRtt replaceObjectAtIndex:2 withObject:@([rtt2 integerValue]+1)];
//    }else if (rxrtt >=1000 && rxrtt <2000){
//        NSNumber *rtt3 = self.agoraDownstreamRtt[3];
//        [self.agoraDownstreamRtt replaceObjectAtIndex:3 withObject:@([rtt3 integerValue]+1)];
//    }else if (rxrtt >=2000 && rxrtt<5000){
//        NSNumber *rtt4 = self.agoraDownstreamRtt[4];
//        [self.agoraDownstreamRtt replaceObjectAtIndex:4 withObject:@([rtt4 integerValue]+1)];
//    }else if (rxrtt>=5000){
//        NSNumber *rtt5 = self.agoraDownstreamRtt[5];
//        [self.agoraDownstreamRtt replaceObjectAtIndex:5 withObject:@([rtt5 integerValue]+1)];
//    }
//}
//
//
//#pragma mark RTC Core Delegate Methods
//
///** Occurs when a method is executed by the SDK.
//
// @param engine AgoraRtcEngineKit object.
// @param error  The error code (AgoraErrorCode) returned by the SDK when the method call fails. If the SDK returns 0, then the method call succeeds.
// @param api    The method executed by the SDK.
// @param result The result of the method call.
// */
////- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didApiCallExecute:(NSInteger)error api:(NSString* _Nonnull)api result:(NSString* _Nonnull)result{
////    if (error == 0) {
////        return;
////    }
////#if DEBUG
////    [[SLLiveLogView shareLogView] addLog:[NSString stringWithFormat:@"声网RTC error didApiCallExecute:%@",api]];
////#endif
////}
//#pragma mark Media Delegate Methods
//
//- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine lastmileProbeTestResult:(AgoraLastmileProbeResult* _Nonnull)result{
//    MIKILogInfo("AgoraRtcKit", @"网络状态回调 lastmileProbeTestResult:%ld  roomId:%@",result.rtt, SLRoomManager.roomId);
//
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(netDelayOnChange:)]) {
//            [obj netDelayOnChange:result.rtt];
//        }
//    }];
//    if (isSuccess)  [self.lock unlock];
//
//}
//
///// 用户说话音量回调 需要开启[AgoraRtcEngineKit enableAudioVolumeIndication:smooth:report_vad:]
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo *> *)speakers totalVolume:(NSInteger)totalVolume{
//    NSMutableDictionary *logFile = [NSMutableDictionary dictionaryWithCapacity:9];
//    for (AgoraRtcAudioVolumeInfo *info in speakers) {
//        SLEngineVolumModel *engineModel = [SLEngineVolumModel new];
//        engineModel.displayUserId = info.uid?@(info.uid).stringValue:SLSignInstance.displayUserId;
//        engineModel.volum = info.volume;
//        logFile[@"displayUserId"] = engineModel.displayUserId;
//        logFile[@"volum"] = @(engineModel.volum);
//
//        BOOL isSuccess  = [self.lock tryLock];
//        NSArray *array = [self.weakRefTargets allObjects];
//        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj respondsToSelector:@selector(audioEngineVolunme:totalVolume:params:)]) {
//                [obj audioEngineVolunme:engineModel totalVolume:0 params:nil];
//            }
//        }];
//        if (isSuccess)  [self.lock unlock];
//    }
//    MIKILogInfo("AgoraRtcKit", @"用户说话音量回调 reportAudioVolumeIndicationOfSpeakers:%@ roomId:%@",logFile, SLRoomManager.roomId);
//}
//
//- (void)rtcEngine:(AgoraRtcEngineKit *)engine audioMixingStateChanged:(AgoraAudioMixingStateType)state reasonCode:(AgoraAudioMixingReasonCode)reasonCode{
////    [self.displayLink setPaused:YES];
//    [self.displayLink setFireDate:NSDate.distantFuture];
//    MIKILogInfo("AgoraRtcKit", @"混音回调 audioMixingStateChanged:%ld  reasonCode:%ld  roomId:%@",state,reasonCode, SLRoomManager.roomId);
//
//    switch (state) {
//        case AgoraAudioMixingStateTypePlaying:{
//            self.playerStatus = livePlayerMusicStatePlaying;
//            //读取音乐时长
//            self.totalTime = [_rtcKit getEffectDuration:self.filePath];
////            [self.displayLink setPaused:NO];
//            [self.displayLink setFireDate:NSDate.distantPast];
//            break;
//        }
//        case AgoraAudioMixingStateTypePaused: {
//            self.playerStatus = livePlayerMusicStatePaused;
//            break;
//        }
//        case AgoraAudioMixingStateTypeStopped: {
//            //暂停
//            if (reasonCode == AgoraAudioMixingReasonStoppedByUser) {
//                self.playerStatus = livePlayerMusicStateStoped;
//            }else if (reasonCode == AgoraAudioMixingReasonAllLoopsCompleted){
//                self.playerStatus = livePlayerMusicStateFinish;
//            }
//
//            break;
//        }
//        case AgoraAudioMixingStateTypeFailed: {
//            self.playerStatus = livePlayerMusicStateFailed;
//
//            break;
//        }
//    }
//
//    BOOL isSuccess  = [self.lock tryLock];
//    NSArray *array = [self.weakRefTargets allObjects];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(audioEngine:playStatus:)]) {
//            [obj audioEngine:self playStatus:self.playerStatus];
//        }
//    }];
//    if (isSuccess) [self.lock unlock];
//    //更新播放时间
//    [self displayCallBack];
//}
//
//#pragma mark - getter or setter
//
//
//-(AgoraRtcEngineKit *)rtcKit{
//    if (!_rtcKit) {
//        AgoraRtcEngineKit *rtcKit = [AgoraRtcEngineKit sharedEngineWithAppId:AGORALKEY delegate:self];
//        [rtcKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
//        [rtcKit setClientRole:AgoraClientRoleAudience];
//        [rtcKit enableAudioVolumeIndication:1000 smooth:3 reportVad:NO];
//        [rtcKit setAudioProfile:AgoraAudioProfileDefault];
//        [rtcKit setParameters:@"{\"che.audio.keep.audiosession\":true}"];
//        [rtcKit setAudioScenario:(AgoraAudioScenarioGameStreaming)];//屏幕共享时切换成AgoraAudioScenarioChatRoom
////        [rtcKit setExternalVideoSource:YES useTexture:YES sourceType:(AgoraExternalVideoSourceTypeVideoFrame)];
////        AgoraSimulcastStreamConfig *config = [[AgoraSimulcastStreamConfig alloc] init];
//        AgoraVideoEncoderConfiguration *configuration = [[AgoraVideoEncoderConfiguration alloc] initWithSize:CGSizeMake(640, 360) frameRate:AgoraVideoFrameRateFps30 bitrate:AgoraVideoBitrateStandard orientationMode:(AgoraVideoOutputOrientationModeAdaptative) mirrorMode:AgoraVideoMirrorModeAuto];
//        [rtcKit setVideoEncoderConfiguration:configuration];
//        [rtcKit enableVideo];
//        [rtcKit enableAudio];
//        [rtcKit startLastmileProbeTest:nil];
//        MIKILogInfo("AgoraRtcKit", @"AgoraRtcEngineKit初始化 roomId:%@", SLRoomManager.roomId);
//
//        _rtcKit = rtcKit;
//    }
//    return _rtcKit;
//}
//
//-(int)currentTime{
//    return [_rtcKit getAudioMixingCurrentPosition];
//}
//-(NSMutableArray<NSNumber *> *)agoraUpstreamAudioQuality{
//    if (!_agoraUpstreamAudioQuality) {
//        _agoraUpstreamAudioQuality = [NSMutableArray array];
//        [_agoraUpstreamAudioQuality addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)]];
//    }
//    return _agoraUpstreamAudioQuality;
//}
//-(NSMutableArray<NSNumber *> *)agoraDownstreamAudioQuality{
//    if (!_agoraDownstreamAudioQuality) {
//        _agoraDownstreamAudioQuality = [NSMutableArray array];
//        [_agoraDownstreamAudioQuality addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)]];
//    }
//    return _agoraDownstreamAudioQuality;
//}
//-(NSMutableArray<NSNumber *> *)lastmiledelayRtt{
//    if (!_lastmiledelayRtt) {
//        _lastmiledelayRtt = [NSMutableArray array];
//        [_lastmiledelayRtt addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0)]];
//    }
//    return _lastmiledelayRtt;
//}
//-(NSMutableArray<NSNumber *> *)agoraUpstreamRtt{
//    if (!_agoraUpstreamRtt) {
//        _agoraUpstreamRtt = [NSMutableArray array];
//        [_agoraUpstreamRtt addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0)]];
//    }
//    return _agoraUpstreamRtt;
//}
//-(NSMutableArray<NSNumber *> *)agoraDownstreamRtt{
//    if (!_agoraDownstreamRtt) {
//        _agoraDownstreamRtt = [NSMutableArray array];
//        [_agoraDownstreamRtt addObjectsFromArray:@[@(0),@(0),@(0),@(0),@(0),@(0)]];
//    }
//    return _agoraDownstreamRtt;
//}



@end
