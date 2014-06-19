//
//  ALLAppDelegate.m
//  arduinoLEDlight
//
//  Created by Nicolas Senaud on 2014/05/24.
//  Copyright (c) 2014 Nicolas Senaud. All rights reserved.
//

#import "ALLAppDelegate.h"

@implementation ALLAppDelegate

//- (id)init
//{
//    self = [super init];
//}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (IBAction)askForConnection:(id)sender
{
    [_switchOnAll  setEnabled:YES];
    [_switchOffAll setEnabled:YES];
    [_lightenAll   setEnabled:YES];
    [_darkenAll    setEnabled:YES];
    [_lightLabel   setEnabled:YES];
}

- (IBAction)askForDisconnection:(id)sender
{
    [_switchOnAll  setEnabled:NO];
    [_switchOffAll setEnabled:NO];
    [_lightenAll   setEnabled:NO];
    [_darkenAll    setEnabled:NO];
    [_lightLabel   setEnabled:NO];
}

- (IBAction)switchOnAll:(id)sender
{
    NSTask *switchOnAllTask = [[NSTask alloc] init];

    [switchOnAllTask setLaunchPath:@"/bin/sh"];

    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-c", @"/bin/echo 'Am' > /dev/tty.usbmodem1421", nil];
    [switchOnAllTask setArguments: arguments];

    [switchOnAllTask launch];
}

- (IBAction)switchOffAll:(id)sender
{
    NSTask *switchOnAllTask = [[NSTask alloc] init];

    [switchOnAllTask setLaunchPath:@"/bin/sh"];

    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-c", @"/bin/echo 'Ao' > /dev/tty.usbmodem1421", nil];
    [switchOnAllTask setArguments: arguments];

    [switchOnAllTask launch];
}

- (IBAction)lightenAll:(id)sender
{
    NSTask *switchOnAllTask = [[NSTask alloc] init];

    [switchOnAllTask setLaunchPath:@"/bin/sh"];

    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-c", @"/bin/echo 'A+' > /dev/tty.usbmodem1421", nil];
    [switchOnAllTask setArguments: arguments];

    [switchOnAllTask launch];
}

- (IBAction)darkenAll:(id)sender
{
    NSTask *switchOnAllTask = [[NSTask alloc] init];

    [switchOnAllTask setLaunchPath:@"/bin/sh"];

    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-c", @"/bin/echo 'A-' > /dev/tty.usbmodem1421", nil];
    [switchOnAllTask setArguments: arguments];

    [switchOnAllTask launch];
}

@end
