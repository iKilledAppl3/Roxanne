#import "Roxanne_prefsheader.h"

/* Roxanne a tweak to customize UISounds with ease! 
Created by J.K. Hayslip (@iKilledAppl3) March 25th, 2019
All rights reserved. */

@implementation RoxanneListController

+ (NSString *)hb_specifierPlist {
    return @"Roxanne";
    
}


//share button
-(void)loadView {
    [super loadView];

self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(shareTapped)];
	
	/* Uncomment this if you want large titles for iOS 11 and higher!
self.navigationController.navigationBar.prefersLargeTitles = YES;
self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic; */
	
}

//tint color to use for toggles and buttons 
+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:224.0/255.0 green: 17.0/255.0 blue: 95.0/255.0 alpha:1.0];
}

//share button action 
- (void)shareTapped {
   
	 NSString *shareText = @"Check out #Roxanne by @iKilledAppl3! It changes various UISounds with ease! Download today on the @iospackixrepo! https://cydia.saurik.com/api/share#?source=https://repo.packix.com/&package=com.ikilledappl3.roxanne";
	 NSArray * itemsToShare = @[shareText];
	 
    	UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
}

- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.rightBarButtonItem;
 
}
-(void)respring {
  //thanks to @skittyblock no more system deprecation errors :P
  NSTask *task = [[[NSTask alloc] init] autorelease];
  [task setLaunchPath:@"/usr/bin/killall"];
  [task setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
  [task launch];
}

@end

// vim:ft=objc
