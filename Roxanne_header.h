//headers we need! 
#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>

/* Roxanne a tweak to customize UISounds with ease! 
Created by J.K. Hayslip (@iKilledAppl3) March 25th, 2019
All rights reserved. */

//see if tweak is enabled!
BOOL kEnabled;

//Malipo switches 
BOOL kUseMalipoUnlock;
BOOL kUseMalipoLock;
BOOL kUseMalipoLSCode;
BOOL kUseMalipoKB;
BOOL kUseMalipoFolders;
BOOL kUseMalipoFoldersClosed;
BOOL kUseMalipoVol;
BOOL kUseMalipoTP;
BOOL kUseMalipoScreenshotSound;
BOOL kUseMalipoRinger;
BOOL kUseMalipoCameraShutter;

//default sound switches 
BOOL kUseDefaultLock;
BOOL kUseDefaultLSCode;
BOOL kUseDefaultKB;
BOOL kUseDefaultTP;
BOOL kUseDefaultScreenshot;
BOOL kUseDefaultCameraShutter;

//Roxanne Strings (for audio)
NSString *kUnlock;
NSString *kLock;
NSString *kFolders;
NSString *kFoldersClosed;
NSString *kLSCode;
NSString *kKBSounds;
NSString *kVolumeSounds;
NSString *kTPDialSounds;
NSString *kScreenshotSounds;
NSString *kRingerString;
NSString *kCameraShutterString;

//Malipo strings :P
NSString *kMalipoLSCode;
NSString *kMalipoLock;
NSString *kMalipoUnlock;
NSString *kMalipoFolders;
NSString *kMalipoFoldersClosed;
NSString *kMalipoKB;
NSString *kMalipoVol;
NSString *kMalipoTPDial;
NSString *kMalipoScreenshot;
NSString *kMalipoRinger;
NSString *kMalipoCameraShutter;

HBPreferences *preferences;

//Sound identifiers
SystemSoundID unlockSound;
SystemSoundID folderOpenSound;
SystemSoundID folderClosedSound;
SystemSoundID volumeSound;
SystemSoundID tpDialerSound;
SystemSoundID screenShotSound;
SystemSoundID ringerSound;
SystemSoundID cameraShutter;

//delete key file :P
NSString *deleteKeyFile = [[NSBundle bundleWithPath:@"/System/Library/Audio/UISounds/"] pathForResource:@"key_press_delete" ofType:@"caf"];

//volume control string :P
#define volString [NSString stringWithFormat:@"/Library/Application Support/Roxanne/VolumeSounds/%@", kVolumeSounds]

AVAudioSession *session = [AVAudioSession sharedInstance];

//interfaces 

@interface CUCaptureController : NSObject
+(id)sharedInstance;
-(BOOL)isCapturingVideo;
-(BOOL)isCapturingBurst;
@end

@interface CAMViewfinderViewController : UIViewController
-(BOOL)isCapturingPhoto;
@end

@interface SBHUDView : UIView
@end

@interface SBRingerHUDView : SBHUDView
@end

@interface SBMediaController : NSObject
+(id)sharedInstance;
-(BOOL)isPlaying;
-(BOOL)isRingerMuted;
@end

@interface SBFolderController : NSObject 
-(BOOL)isOpen;
@end

@interface SBLockScreenViewControllerBase : UIViewController
-(BOOL)isAuthenticated;
@end
 
@interface SBLockScreenManager : NSObject
+(SBLockScreenManager *)sharedInstance;
-(SBLockScreenViewControllerBase *)lockScreenViewController;
-(BOOL)isUILocked;
@end

@interface SBCoverSheetSlidingViewController : UIViewController
-(void)_handleDismissGesture:(id)arg1 ;
-(void)setPresented:(BOOL)arg1 animated:(BOOL)arg2 withCompletion:(/*^block*/id)arg3 ;
@end

@interface UIKBTree : NSObject
@property (nonatomic, strong, readwrite) NSString * name;
+(id)sharedInstance;
+(id)key;
@end

@interface UIKeyboardLayoutStar : UIView
@property (nonatomic, copy) NSString * localizedInputKey;
-(void)setPlayKeyClickSoundOn:(int)arg1;
@end
