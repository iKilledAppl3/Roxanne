#import "RoxanneFolders.h"

/* Roxanne a tweak to customize UISounds with ease! 
Created by J.K. Hayslip (@iKilledAppl3) March 25th, 2019
All rights reserved. */

@implementation RoxanneFoldersListController

+ (NSString *)hb_specifierPlist {
folderSoundDirMalipo = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/Malipo/CustomSounds/" error:NULL];

    return @"RoxanneFolders";
    
}

-(void)listThatDir {
   directoryFolderContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/Roxanne/FolderSounds/Open/" error:NULL];
}

-(void)loadView {
    [super loadView];

    [self listThatDir];

}

- (void)setAndPreview:(id)value forSpecifier:(id)specifier {
// Sample sound and set
    AudioServicesDisposeSystemSoundID(soundSelected);
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Roxanne/FolderSounds/Open/%@",value]],&soundSelected);
    AudioServicesPlaySystemSound(soundSelected);
    
    [super setPreferenceValue:value specifier:specifier];
}

- (NSArray *)getData:(id)target {
NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
    for (NSURL *fileURL in [directoryFolderContent filteredArrayUsingPredicate:predicate]) {
	[listing addObject:fileURL];
    }
    return listing;
}

- (void)previewAndSet:(id)value forSpecifier:(id)specifier{
    // Sample sound and set
    AudioServicesDisposeSystemSoundID(selectedSound);
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/Malipo/CustomSounds/%@",value]],&selectedSound);
    AudioServicesPlaySystemSound(selectedSound);
    
    [super setPreferenceValue:value specifier:specifier];
}

// List our directory content
- (NSArray *)getValues:(id)target{
	NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
    for (NSURL *fileURL in [folderSoundDirMalipo filteredArrayUsingPredicate:predicate]) {
	[listing addObject:fileURL];
    }
    return listing;
}
@end

// vim:ft=objc
