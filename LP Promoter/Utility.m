//
//  Utility.m
//  sales and tracking
//
//  Created by Sejal Pandya on 9/5/12.
//
//

#import "Utility.h"
#import "AppDelegate.h"

@implementation Utility

+(NSString*)retrieveFromUserDefaults:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
    
	if (standardUserDefaults)
		val = [standardUserDefaults objectForKey:key];
    
	if (val == nil) {
		NSLog(@"user defaults may not have been loaded from Settings.bundle ... doing that now ...");
		//Get the bundle path
		NSString *bPath = [[NSBundle mainBundle] bundlePath];
		NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
		NSString *plistFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];
        
		//Get the Preferences Array from the dictionary
		NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
		NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
        
		//Loop through the array
		NSDictionary *item;
		for(item in preferencesArray)
		{
			//Get the key of the item.
			NSString *keyValue = [item objectForKey:@"Key"];
            
			//Get the default value specified in the plist file.
			id defaultValue = [item objectForKey:@"DefaultValue"];
            
			if (keyValue && defaultValue) {
				[standardUserDefaults setObject:defaultValue forKey:keyValue];
				if ([keyValue compare:key] == NSOrderedSame)
					val = defaultValue;
			}
		}
		[standardUserDefaults synchronize];
	}
	return val;
}


-(void)setUserSettings:(NSInteger)keyValue keyName:(NSString *)keyName{
    [[NSUserDefaults standardUserDefaults] setInteger:keyValue forKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)getUserSettings:(NSString *)keyName{
    return [[NSUserDefaults standardUserDefaults] integerForKey:keyName];
}

-(NSString*)retrieveFromUserSavedData:(NSString*)key {
    
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    
    NSMutableDictionary *project = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    return [project objectForKey:key];
}

-(void)saveToUserSavedDataWithKey:(NSString*)key Data:(NSString*)object {
    NSString *localSettingsPath = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).localSettingsPath;
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: localSettingsPath];
    [data setObject:object forKey:key];
    
    [data writeToFile: localSettingsPath atomically:YES];
}



@end
