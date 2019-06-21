//libcephei prefs headers we need 
#import <CepheiPrefs/HBListController.h>
#import <CepheiPrefs/HBTintedTableCell.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBTwitterCell.h>
#import <CepheiPrefs/HBImageTableCell.h>
#import <CepheiPrefs/HBPackageNameHeaderCell.h>
//regular ones we need 
#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioServices.h>

/* Roxanne a tweak to customize UISounds with ease! 
Created by J.K. Hayslip (@iKilledAppl3) March 25th, 2019
All rights reserved. */

//preferences interface 

@interface RoxanneCamShutterListController : HBListController {
	   SystemSoundID selectedSound;
       SystemSoundID soundSelected;
}
- (NSArray *)getValues:(id)target;
- (void)previewAndSet:(id)value forSpecifier:(id)specifier;
- (NSArray *)getData:(id)target;
- (void)setAndPreview:(id)value forSpecifier:(id)specifier;
- (void)listThatDir;
@end
  
  NSArray *camShutterDirMalipo;
  NSArray *directoryCamShutterContent;
