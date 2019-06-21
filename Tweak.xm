#import "Roxanne_header.h"

/* Roxanne a tweak to customize UISounds with ease! 
Created by J.K. Hayslip (@iKilledAppl3) March 25th, 2019
All rights reserved. */

SBMediaController *mediaController = [%c(SBMediaController) sharedInstance];
//CUCaptureController *captureController = [%c(CUCaptureController) sharedInstance];
//&& !captureController.isCapturingVideo && !captureController.isCapturingBurst) {

%hook CAMViewfinderViewController
-(void)_handleShutterButtonReleased:(id)arg1 {
if(kEnabled && !kUseDefaultCameraShutter && self.isCapturingPhoto) {
			%orig;
		if (kUseMalipoCameraShutter) {
								cameraShutter = 0;

AudioServicesDisposeSystemSoundID(cameraShutter);

AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoCameraShutter]],& cameraShutter);
				 AudioServicesPlaySystemSound(cameraShutter);
		}

		else {
								cameraShutter = 0;

AudioServicesDisposeSystemSoundID(cameraShutter);
                 
AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/Shutter/%@", kCameraShutterString]],& cameraShutter);
				 AudioServicesPlaySystemSound(cameraShutter);

		}
	}

	else {
		%orig;
	}
}
%end

//All of these methods are used to play the shutter sound when the shutter button is on a still image capture.
//I'm disabling these by default so I can play a custom sound when the button is hit.
%hook CMKMutableStillImageCaptureRequest
-(void)setWantsAudioForCapture:(BOOL)arg1 {
	if (kEnabled && !kUseDefaultCameraShutter) {
		arg1 = FALSE;
	}

	else {
		%orig;
	}
}
%end

%hook CAMStillImageCaptureRequest
-(BOOL)wantsAudioForCapture {
	if (kEnabled && !kUseDefaultCameraShutter) {
		return FALSE;
	}

	else {
		return %orig;
	}
}
%end

%hook CMKStillImageCaptureRequest
-(BOOL)wantsAudioForCapture {
	if (kEnabled && !kUseDefaultCameraShutter) {
		return FALSE;
	}

	else {
		return %orig;
	}
}
%end

%hook SpringBoard
-(void)_ringerChanged:(id)arg1 {
	if (kEnabled) {
		%orig;
		if (kUseMalipoRinger) {
					ringerSound = 0;

                  AudioServicesDisposeSystemSoundID(ringerSound);

				 AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoRinger]],& ringerSound);
				 AudioServicesPlaySystemSound(ringerSound);
		}

		else {
			        ringerSound = 0;

                  AudioServicesDisposeSystemSoundID(ringerSound);

				 AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/Ringer/%@",kRingerString]],& ringerSound);
				 AudioServicesPlaySystemSound(ringerSound);
		}

	}

	else {
		%orig;
	}
}

//call the sound when the screenshot is being taken 
-(void)takeScreenshotAndEdit:(BOOL)arg1 {
	if (kEnabled && !kUseDefaultScreenshot && !mediaController.isRingerMuted) {
     %orig;
if (kUseMalipoScreenshotSound) {
	  				screenShotSound = 0;

AudioServicesDisposeSystemSoundID(screenShotSound);

AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoScreenshot]],& screenShotSound);
				 AudioServicesPlaySystemSound(screenShotSound);

}

    else {
    	screenShotSound = 0;

AudioServicesDisposeSystemSoundID(screenShotSound);
                 
AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/Shutter/%@", kScreenshotSounds]],& screenShotSound);
				 AudioServicesPlaySystemSound(screenShotSound);

}

 }
      else {
    %orig;
}
}

%end

%hook SSScreenCapturer
+(void)playScreenshotSound {
  if (kEnabled && !kUseDefaultScreenshot && !mediaController.isRingerMuted) {
  //Silence the original sound 
  // can’t call a nil statement here because it won’t play the sound :/ if we add the systemSoundID here it will only fire once. 
}

else {
  %orig;
}
}
%end

%hook TPDialerSoundController
-(void)playSoundForDialerCharacter:(unsigned)arg1 {

    if (kEnabled && !kUseDefaultTP) {

	    if (kUseMalipoTP) {
			
                         tpDialerSound = 0;

                  AudioServicesDisposeSystemSoundID(tpDialerSound);

				 AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoTPDial]],& tpDialerSound);
				 AudioServicesPlaySystemSound(tpDialerSound);
			}


               else {
                           tpDialerSound = 0;

			     AudioServicesDisposeSystemSoundID(tpDialerSound);
				AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/KeyboardSounds/TPDialer/%@", kTPDialSounds]],&tpDialerSound);
				AudioServicesPlaySystemSound(tpDialerSound);
		}

      }
	
	else {
		%orig;
	}
}

%end

%hook VolumeControl 

-(void)increaseVolume {

    if (kEnabled && ![[%c(SBLockScreenManager) sharedInstance] isUILocked]) {
    	 %orig;
       if (kUseMalipoVol) {
    volumeSound = 0;
    AudioServicesDisposeSystemSoundID(volumeSound);

AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoVol]],& volumeSound);
			AudioServicesPlaySystemSound(volumeSound);
}

			if (!mediaController.isPlaying) {

			volumeSound = 0;

			AudioServicesDisposeSystemSoundID(volumeSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/VolumeSounds/%@",kVolumeSounds]],& volumeSound);
			AudioServicesPlaySystemSound(volumeSound); 

}

				else {
      
      			AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:volString] error:nil];
    			[player setNumberOfLoops:0];
    			[player play];
             	[session setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
		}

}
	
	else {
		%orig;
	}
}

-(void)decreaseVolume {
       if (kEnabled && ![[%c(SBLockScreenManager) sharedInstance] isUILocked]) {
       	 %orig;
       if (kUseMalipoVol) {
    volumeSound = 0;
    AudioServicesDisposeSystemSoundID(volumeSound);

AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoVol]],& volumeSound);
			AudioServicesPlaySystemSound(volumeSound);
}

			if (!mediaController.isPlaying){

			volumeSound = 0;

			AudioServicesDisposeSystemSoundID(volumeSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/VolumeSounds/%@",kVolumeSounds]],& volumeSound);
			AudioServicesPlaySystemSound(volumeSound); 

			

}

				else {
      
      			AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:volString] error:nil];
    			[player setNumberOfLoops:0];
    			[player play];
             	[session setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
            
		}

}
	
	else {
		%orig;
	}
}
%end

//grouping this so we don’t have it be called on iOS 10!
%group 1112
%hook SBCoverSheetPrimarySlidingViewController
 //fixes issues with duplicate unlock sound -__- 
-(void)_handleDismissGesture:(id)arg1 {
    if (kEnabled && [[[%c(SBLockScreenManager) sharedInstance] lockScreenViewController] isAuthenticated]) {
              %orig;
        AudioServicesDisposeSystemSoundID(unlockSound);
    }
 
     else {

     %orig;

    }
}
%end
%end
 
%hook SBDashBoardViewController
-(void)prepareForUIUnlock {

	if (kEnabled) {
         	%orig;

	    if (kUseMalipoUnlock) {
			
                         unlockSound = 0;

                  AudioServicesDisposeSystemSoundID(unlockSound);

				 AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoUnlock]],& unlockSound);
				 AudioServicesPlaySystemSound(unlockSound);
			}


               else {
                           unlockSound = 0;

			     AudioServicesDisposeSystemSoundID(unlockSound);
				AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/LockSounds/Unlock/%@", kUnlock]],& unlockSound);
				AudioServicesPlaySystemSound(unlockSound);
		}

      }
	
	else {
		%orig;
	}
	
}
%end

%hook SBUIPasscodeLockViewBase 

-(void)_sendDelegateKeypadKeyDown {

if (kEnabled && !kUseDefaultLSCode) {
        %orig;
	    if (kUseMalipoLSCode) {
			SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoLSCode]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);
		}

               else {
            SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/LockSounds/LSPasscode/%@",kLSCode]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);

      }
		
}

	
	else {
		%orig;
	}
}
-(void)setPlaysKeypadSounds:(BOOL)arg1 {
     if (kEnabled && !kUseDefaultLSCode) {
        
} 

      else {
		%orig;
	}
}
%end
	
%group iOS12
%hook SBSleepWakeHardwareButtonInteraction
-(void)_playLockSound {
	if (kEnabled && ![[%c(SBLockScreenManager) sharedInstance] isUILocked] && ! kUseDefaultLock) {
	    if (kUseMalipoLock) {
			SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoLock]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);
		}

               else {
            SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/LockSounds/Lock/%@",kLock]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);

      }
		
}
	
	else {
		%orig;
	}
}
%end
%end

%group iOS11	
%hook SBLockHardwareButtonActions
-(void)_playLockSound {
	if (kEnabled && ![[%c(SBLockScreenManager) sharedInstance] isUILocked] && ! kUseDefaultLock)  {
	    if (kUseMalipoLock) {
			SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoLock]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);
		}

               else {
            SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/LockSounds/Lock/%@",kLock]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);

      }
		
}
	
	else {
		%orig;
	}
}
%end	
%end	

%hook SBFolderController

-(void)folderControllerWillOpen:(id)arg1  {
	if (kEnabled && self.isOpen) {
		%orig;

		if (kUseMalipoFolders) {
             //This is here to fix another audio bug -__-AudioServicesDisposeSystemSoundID(folderClosedSound);

			folderOpenSound = 0;

AudioServicesDisposeSystemSoundID(folderOpenSound);
		    
AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoFolders]],& folderOpenSound);
			AudioServicesPlaySystemSound(folderOpenSound);
		}

               else {
            folderOpenSound = 0;

			AudioServicesDisposeSystemSoundID(folderOpenSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/FolderSounds/Open/%@",kFolders]],& folderOpenSound);
			AudioServicesPlaySystemSound(folderOpenSound);

      }
	}

	else {
		%orig;
	}
}

-(void)folderControllerWillClose:(id)arg1 {
      if (kEnabled) {
		%orig;
		 if (kUseMalipoFoldersClosed) {
                //This is here to fix another audio bug -__- AudioServicesDisposeSystemSoundID(folderOpenSound);

   folderClosedSound = 0;

			AudioServicesDisposeSystemSoundID(folderClosedSound);
		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoFoldersClosed]],& folderClosedSound);
			AudioServicesPlaySystemSound(folderClosedSound);
		}

               else {
            folderClosedSound = 0;

			AudioServicesDisposeSystemSoundID(folderClosedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/FolderSounds/Close/%@",kFoldersClosed]],& folderClosedSound);
			AudioServicesPlaySystemSound(folderClosedSound);

      }
	}

	else {
		%orig;
	}
}
%end

%hook UIKeyboardLayoutStar
-(void)playKeyClickSoundOnDownForKey:(UIKBTree *)key {

	if (kEnabled && !kUseDefaultKB) {
	    if (kUseMalipoKB) {
			SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",kMalipoKB]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);
		}

     else {

            SystemSoundID selectedSound = 0;

			AudioServicesDisposeSystemSoundID(selectedSound);

		    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/KeyboardSounds/%@",kKBSounds]],&selectedSound);
			AudioServicesPlaySystemSound(selectedSound);

      }


}
	
	
	else {
		%orig;
	}
}

-(void)setPlayKeyClickSoundOn:(int)arg1 {
	if (kEnabled && !kUseDefaultKB) {

	            UIKBTree *delKey = [%c(UIKBTree) key];
				NSString *myDelKeyString = [delKey name];

		 if ([myDelKeyString isEqualToString:@"Delete-Key"]) {
		// We are doing this to silence the delete key by default for custom sounds :P
		// Don't think people will care about this lol XD
            
		
      }
}

	else {
		%orig;
	}
}

%end

extern NSString *const HBPreferencesDidChangeNotification;

%ctor {

if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
       %init(1112);
}
	
if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)
{
	%init(iOS12);
}
else
{
  	%init(iOS11);
}
 
%init(_ungrouped);
 
    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ikilledappl3.roxanne"];

	[preferences registerBool:&kEnabled default:NO forKey:@"kEnabled"];

	[preferences registerBool:&kUseMalipoUnlock default:NO forKey:@"kUseMalipoUnlock"];
	[preferences registerObject:&kUnlock default:nil forKey:@"kUnlock"];
	[preferences registerObject:&kMalipoUnlock default:nil forKey:@"kMalipoUnlock"];

	[preferences registerBool:&kUseMalipoVol default:NO forKey:@"kUseMalipoVol"];
	[preferences registerObject:& kVolumeSounds default:nil forKey:@"kVolumeSounds"];
	[preferences registerObject:&kMalipoVol default:nil forKey:@"kMalipoVol"];

	[preferences registerBool:& kUseMalipoTP default:NO forKey:@"kUseMalipoTP"];
	[preferences registerBool:& kUseDefaultTP default:NO forKey:@"kUseDefaultTP"];
	[preferences registerObject:& kTPDialSounds default:nil forKey:@"kTPDialSounds"];
	[preferences registerObject:&kMalipoTPDial default:nil forKey:@"kMalipoTPDial"];

	[preferences registerBool:&kUseMalipoScreenshotSound default:NO forKey:@"kUseMalipoScreenshotSound"];
	[preferences registerBool:&kUseDefaultScreenshot default:NO forKey:@"kUseDefaultScreenshot"];
	[preferences registerObject:&kScreenshotSounds default:nil forKey:@"kScreenshotSounds"];
	[preferences registerObject:&kMalipoScreenshot default:nil forKey:@"kMalipoScreenshot"];

	[preferences registerBool:&kUseMalipoCameraShutter default:NO forKey:@"kUseMalipoCameraShutter"];
	[preferences registerBool:&kUseDefaultCameraShutter default:NO forKey:@"kUseDefaultCameraShutter"];
	[preferences registerObject:&kCameraShutterString default:nil forKey:@"kCameraShutterString"];
	[preferences registerObject:&kMalipoCameraShutter default:nil forKey:@"kMalipoCameraShutter"];

	[preferences registerBool:&kUseMalipoRinger default:NO forKey:@"kUseMalipoRinger"];
	[preferences registerObject:&kRingerString default:nil forKey:@"kRingerString"];
	[preferences registerObject:&kMalipoRinger default:nil forKey:@"kMalipoRinger"];

	[preferences registerBool:& kUseMalipoKB default:NO forKey:@"kUseMalipoKB"];
	[preferences registerObject:& kKBSounds default:nil forKey:@"kKBSounds"];
	[preferences registerObject:& kMalipoKB default:nil forKey:@"kMalipoKB"];
	[preferences registerBool:& kUseDefaultKB default:NO forKey:@"kUseDefaultKB"];

	[preferences registerBool:&kUseMalipoFoldersClosed default:NO forKey:@"kUseMalipoFoldersClosed"];
	[preferences registerObject:&kFoldersClosed default:nil forKey:@"kFoldersClosed"];
	[preferences registerObject:&kMalipoFoldersClosed default:nil forKey:@"kMalipoFoldersClosed"];

	[preferences registerBool:&kUseMalipoFolders default:NO forKey:@"kUseMalipoFolders"];
	[preferences registerObject:&kFolders default:nil forKey:@"kFolders"];
	[preferences registerObject:&kMalipoFolders default:nil forKey:@"kMalipoFolders"];

	[preferences registerBool:&kUseMalipoLSCode default:NO forKey:@"kUseMalipoLSCode"];
	[preferences registerObject:&kLSCode default:nil forKey:@"kLSCode"];
	[preferences registerObject:&kMalipoLSCode default:nil forKey:@"kMalipoLSCode"];
	[preferences registerBool:&kUseDefaultLSCode default:NO forKey:@"kUseDefaultLSCode"];

	[preferences registerBool:&kUseMalipoLock default:NO forKey:@"kUseMalipoLock"];
	[preferences registerObject:&kLock default:nil forKey:@"kLock"];
	[preferences registerObject:&kMalipoLock default:nil forKey:@"kMalipoLock"];
	[preferences registerBool:&kUseDefaultLock default:NO forKey:@"kUseDefaultLock"];

}
