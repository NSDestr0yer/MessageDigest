//
//  AppDelegate.m
//  MessageDigest
//
//  Created by Collin B. Stuart on 2014-05-01.
//  Copyright (c) 2014 CollinBStuart. All rights reserved.
//

#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>

CFStringRef Sha256FromString(CFStringRef theString)
{
    if (theString)
    {
        uint8_t shaHash[CC_SHA512_DIGEST_LENGTH];
        const char *stringChar = CFStringGetCStringPtr(theString, kCFStringEncodingUTF8);
        CC_LONG stringLength = CFStringGetLength(theString);
        
        // Confirm that the length of the user name is small enough
        // to be recast when calling the hash function.
        if (stringLength > UINT32_MAX)
        {
            CFShow(CFSTR("The string is too long to be hashed"));
            return NULL;
        }
        
        CC_SHA512_CTX sha512Context;
        bzero(&sha512Context, sizeof(sha512Context));
        CC_SHA512_Init(&sha512Context);
        CC_SHA512_Update(&sha512Context, stringChar, stringLength);
        CC_SHA512_Final(shaHash, &sha512Context);
        
        // Convert the array of bytes into a string showing its hex representation.
        CFMutableStringRef hashMutableString = CFStringCreateMutable(kCFAllocatorDefault, CC_SHA512_DIGEST_LENGTH);
        
        for (CFIndex i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        {
            // Add a dash every four bytes, for readability.
            if (i != 0 && i%4 == 0)
            {
                CFStringAppend(hashMutableString, CFSTR("-"));
            }
            
            CFStringAppendFormat(hashMutableString, 0, CFSTR("%02x"), shaHash[i]);
        }
        
        return CFAutorelease(hashMutableString);
    }
    return NULL;
}




@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Hash : %@", Sha256FromString(CFSTR("Hello World!")));
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
