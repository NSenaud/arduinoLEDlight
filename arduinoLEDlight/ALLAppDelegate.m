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
    [self.switchOnAll  setEnabled:YES];
    [self.switchOffAll setEnabled:YES];
    [self.lightenAll   setEnabled:YES];
    [self.darkenAll    setEnabled:YES];
    [self.lightLabel   setEnabled:YES];
}

- (IBAction)askForDisconnection:(id)sender
{
    [self.switchOnAll  setEnabled:NO];
    [self.switchOffAll setEnabled:NO];
    [self.lightenAll   setEnabled:NO];
    [self.darkenAll    setEnabled:NO];
    [self.lightLabel   setEnabled:NO];
}

- (IBAction)switchOnAll:(id)sender
{
    [self sendCommand:@"Am"];
}

- (IBAction)switchOffAll:(id)sender
{
    [self sendCommand:@"Ao"];
}

- (IBAction)lightenAll:(id)sender
{
    [self sendCommand:@"A+"];
}

- (IBAction)darkenAll:(id)sender
{
    [self sendCommand:@"A-"];
}

- (void)sendCommand:(NSString *)parameter
{
    NSTask *commandLight = [[NSTask alloc] init];

    NSString *command = @"/bin/echo '";
    [command stringByAppendingString:parameter];
    [command stringByAppendingString:@"' > /dev/tty.usbmodem1421"];

    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-c", command, nil];

    [commandLight setLaunchPath:@"/bin/sh"];
    [commandLight setArguments: arguments];
    [commandLight launch];
}

@end
