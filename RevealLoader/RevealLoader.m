//
//  RevealLoader.m
//  RevealLoader
//
//  Created by 陈华锋 on 2019/5/25.
//

#import <CaptainHook/CaptainHook.h>
#include <dlfcn.h>

CHConstructor {
    NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rheard.RHRevealLoader.plist"];
    NSString *libraryPath = @"/Library/Frameworks/RevealServer.framework/RevealServer";
    if([[preferences objectForKey:[NSString stringWithFormat:@"RHRevealEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            void *addr = dlopen([libraryPath UTF8String], RTLD_NOW);
            if(addr){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:nil];
                NSLog(@"Reveal2Loader loaded %@ successed, address %p", libraryPath,addr);
            }
            else{
                NSLog(@"Reveal2Loader loaded %@ failed, address %p", libraryPath,addr);
            }
        }
    }
}
