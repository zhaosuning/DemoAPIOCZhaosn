//
//  ZSNAudioVerticalAnimationViewController.m
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/11/29.
//

#import "ZSNAudioVerticalAnimationViewController.h"
#import "ZSNBoxingView.h"

@interface ZSNAudioVerticalAnimationViewController ()

@property (strong, nonatomic) UIButton *recordButton;


@property (strong, nonatomic) ZSNBoxingView *boxingview;


@end

@implementation ZSNAudioVerticalAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * lblTopTitle = [[UILabel alloc] init];
    lblTopTitle.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 50, 45, 100, 40);
    lblTopTitle.text = @"音频波形";
    lblTopTitle.textColor = [UIColor blueColor];
    lblTopTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTopTitle];
    
    UIButton *btnBoxingA = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBoxingA.frame = CGRectMake(10, 100, 200, 40);
    [btnBoxingA setTitle:@"波形1" forState:UIControlStateNormal];
    [btnBoxingA setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnBoxingA.backgroundColor = [UIColor greenColor];
    btnBoxingA.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnBoxingA addTarget:self action:@selector(btnBoxingAAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBoxingA];
       
    self.boxingview = [[ZSNBoxingView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-150,240,300, 100.0)];
    self.boxingview.middleInterval = 50;
    
    __weak typeof(self) weakSelf = self;
    __weak ZSNBoxingView * weakboview = self.boxingview;
    self.boxingview.itemLevelCallback = ^() {
        
        [weakSelf.audioRecorder updateMeters];
        //取得第一个通道的音频，音频强度范围是-160到0
        float power= [weakSelf.audioRecorder averagePowerForChannel:0];
        weakboview.level = power;
    };
    [self.view addSubview:self.boxingview];


    [self.view addSubview:self.recordButton];

    
}

-(void)btnBoxingAAction:(UIButton *) button {
    NSLog(@"打印了 btnBoxingAAction");
    
    // 1.创建一个复制图层对象，设置复制层的属性
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    // 1.1.设置复制图层中子层总数：这里包含原始层
    replicatorLayer.instanceCount = 8;
    // 1.2.设置复制子层偏移量，不包含原始层，这里是相对于原始层的x轴的偏移量
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    // 1.3.设置复制层的动画延迟事件
    replicatorLayer.instanceDelay = 0.1;
    // 1.4.设置复制层的背景色，如果原始层设置了背景色，这里设置就失去效果
    replicatorLayer.instanceColor = [UIColor greenColor].CGColor;
    // 1.5.设置复制层颜色的偏移量
    replicatorLayer.instanceGreenOffset = -0.1;
   
    // 2.创建一个图层对象  单条柱形 (原始层)
    CALayer *layer = [CALayer layer];
//layer.
    // 2.1.设置layer对象的位置
    layer.position = CGPointMake(15, self.view.bounds.size.height*0.5);
    // 2.2.设置layer对象的锚点
    layer.anchorPoint = CGPointMake(0, 1);
    // 2.3.设置layer对象的位置大小
    layer.bounds = CGRectMake(0, 0, 30, 150);
    // 2.5.设置layer对象的颜色
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    // 3.创建一个基本动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    // 3.1.设置动画的属性
    basicAnimation.keyPath = @"transform.scale.y";
//basicAnimation.keyPath = @"transform.scale.x";
    // 3.2.设置动画的属性值
    basicAnimation.toValue = @0.1;
    // 3.3.设置动画的重复次数
    basicAnimation.repeatCount = MAXFLOAT;
    // 3.4.设置动画的执行时间
    basicAnimation.duration = 0.5;
    // 3.5.设置动画反转
    basicAnimation.autoreverses = YES;
    
    // 4.将动画添加到layer层上
    [layer addAnimation:basicAnimation forKey:nil];
    
    // 5.将layer层添加到复制层上
    [replicatorLayer addSublayer:layer];
    
    // 6.将复制层添加到view视图层上
    [self.view.layer addSublayer:replicatorLayer];
//}
    
}

-(void)btnBoxingBAction:(UIButton *) button {
    
}



- (UIButton *)recordButton {
    if (!_recordButton) {
        _recordButton = [[UIButton alloc]init];


        // 开始
        [_recordButton addTarget:self action:@selector(recordStart:) forControlEvents:UIControlEventTouchDown];
        // 取消
        [_recordButton addTarget:self action:@selector(recordCancel:) forControlEvents: UIControlEventTouchUpOutside];
        //完成
        [_recordButton addTarget:self action:@selector(recordFinish:) forControlEvents:UIControlEventTouchUpInside];
        //移出
        [_recordButton addTarget:self action:@selector(recordTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
        //移入
        [_recordButton addTarget:self action:@selector(recordTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    }
    return _recordButton;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
        [self setAudioSession];
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

#pragma mark - layout

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;

    self.recordButton.frame = CGRectMake(width / 2.f - 50.f, height - 180.f, 80.f, 80.f);
    
    [self.recordButton.layer setCornerRadius:40];
    [self.recordButton.layer setMasksToBounds:YES];
    
    [self.recordButton setTitle:@"点击录音" forState:UIControlStateNormal];
    [self.recordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.recordButton.backgroundColor = [UIColor greenColor];
    self.recordButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    
    
}


#pragma mark - ControlEvents

- (void)recordStart:(UIButton *)button {
    if (![self.audioRecorder isRecording]) {
        NSLog(@"录音开始");
        [self.audioRecorder record];
        [self startAnimate];
    }
}


- (void)recordCancel:(UIButton *)button {
    
    if ([self.audioRecorder isRecording]) {
        NSLog(@"取消");
        [self.audioRecorder stop];
        
    }
}

- (void)recordFinish:(UIButton *)button {
    
    if ([self.audioRecorder isRecording]) {
        NSLog(@"完成");
        [self.audioRecorder stop];
        
    }
    
}

- (void)recordTouchDragExit:(UIButton *)button {
    if([self.audioRecorder isRecording]) {
        [self stopAnimate];
    }
}

- (void)recordTouchDragEnter:(UIButton *)button {
    if([self.audioRecorder isRecording]) {
        [self startAnimate];
    }
}


- (void)startAnimate {
    [self.boxingview start];
}

- (void)stopAnimate {
    [self.boxingview stop];
}



- (void)setAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    //AVAudioSessionCategoryPlayAndRecord用于录音和播放
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
}


/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
- (NSDictionary *)getAudioSetting {
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}


/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
- (NSURL *)getSavePath {
    
    //  在Documents目录下创建一个名为FileData的文件夹
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"AudioData"];
    NSLog(@"%@",path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir)) {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建文件夹失败！");
        }
        NSLog(@"创建文件夹成功，文件路径%@",path);
    }
    
    path = [path stringByAppendingPathComponent:@"myRecord.aac"];
    NSLog(@"file path:%@",path);
    NSURL *url=[NSURL fileURLWithPath:path];
    return url;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
