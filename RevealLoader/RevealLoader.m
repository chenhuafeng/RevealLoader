//
//  RevealLoader.m
//  RevealLoader
//
//  Created by 陈华锋 on 2019/5/25.
//

#import <Foundation/Foundation.h>
#include <dlfcn.h>

__attribute__((constructor)) static void entry() {
    NSString *libraryPath = @"/Library/MobileSubstrate/DynamicLibraries/RevealServer";
    void *addr = dlopen([libraryPath UTF8String], RTLD_NOW);
    if (addr) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:nil];
        NSLog(@"Reveal2Loader loaded %@ successed, address %p", libraryPath, addr);
    } else {
        NSLog(@"Reveal2Loader loaded %@ failed, address %p", libraryPath, addr);
    }
}
