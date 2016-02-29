//
//  main.m
//  FastScrolling
//
//  Created by Loren Brichter on 12/9/08.
//  Copyright atebits 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FastScrollingAppDelegate.h"


int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([FastScrollingAppDelegate class]));
    [pool release];
    return retVal;
}
