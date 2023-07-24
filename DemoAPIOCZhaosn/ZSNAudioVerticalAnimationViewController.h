//
//  ZSNAudioVerticalAnimationViewController.h
//  DemoAPIOCZhaosn
//
//  Created by zhaosuning on 2022/11/29.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSNAudioVerticalAnimationViewController : UIViewController<AVAudioRecorderDelegate>
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;
@end

NS_ASSUME_NONNULL_END
