//
//  ALLAppDelegate.m
//  arduinoLEDlight
//
//  Created by Nicolas Senaud on 2014/05/24.
//
//    The MIT License (MIT)
//
//    Copyright (c) 2014 Nicolas Senaud. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "ALLAppDelegate.h"

#define SSH_MODE      [self.connexionTypeSelector selectedSegment] == SSH
#define USB_MODE      [self.connexionTypeSelector selectedSegment] == LOCAL
#define USB_AVAILABLE [self checkUSBConnectionAvailability] == YES
#define SSH_AVAILABLE  NO

typedef NS_ENUM(NSUInteger, switchStates)
{
    ON,
    OFF
};

typedef NS_ENUM(NSUInteger, lightChangeValues)
{
    MINUS,
    PLUS
};

typedef NS_ENUM(NSUInteger, connexionTypesValues)
{
    SSH,
    LOCAL
};


@implementation ALLAppDelegate

# pragma mark Initialisation

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self askForDisconnection:self];
}


# pragma mark Function to send commands to Arduino

- (void)sendCommand:(NSString *)parameter
{
    NSString *command = @"/bin/echo '";
    command = [command stringByAppendingString:parameter];
    command = [command stringByAppendingString:@"' > /dev/tty.usbmodem1421"];

    if ([self.connexionTypeSelector selectedSegment] == SSH)
    {
        NSLog(@"Send command over SSH");
    }
    else if ([self.connexionTypeSelector selectedSegment] == LOCAL)
    {
        NSArray *arguments;
        arguments = [NSArray arrayWithObjects: @"-c", command, nil];

        NSTask *commandLight = [[NSTask alloc] init];
        [commandLight setLaunchPath:@"/bin/sh"];
        [commandLight setArguments: arguments];
        [commandLight launch];
    }
}


# pragma mark Check USB connection availability

- (BOOL)checkUSBConnectionAvailability
{
    NSArray *arguments = [NSArray arrayWithObjects: @"-c", @"/bin/ls /dev/tty.usbmodem1421", nil];
    NSError *error;
    NSTask  *commandLight = [[NSTask alloc] init];

    [commandLight setLaunchPath:@"/bin/sh"];
    [commandLight setArguments: arguments];
    [commandLight setStandardError:error];

    [commandLight launch];

    if ([error isNotEqualTo:nil])
    {
        return YES;
    }
    else
    {
        NSAlert *connectionUnavailableAlert = [NSAlert
                                               alertWithMessageText:@"Arduino Uno seems not to be connected to your Mac"
                                               defaultButton:@"Ok"
                                               alternateButton:@"Help"
                                               otherButton:nil
                                               informativeTextWithFormat:@"If it is, click help!"];
        [connectionUnavailableAlert runModal];

        // FIXME: add help... Open website for help?

        return NO;
    }
}


# pragma mark Command interface for asking connekion with Arduino

- (IBAction)askForConnection:(id)sender
{
    if (USB_AVAILABLE || SSH_AVAILABLE)
    {
        [self.globalSwitchButton       setEnabled:YES];
        [self.globalLightChangeButton  setEnabled:YES];
        [self.bedSwitchButton          setEnabled:YES];
        [self.bedLightChangeButton     setEnabled:YES];
        [self.bedLightLevelIndicator   setEnabled:YES];
        [self.deskSwitchButton         setEnabled:YES];
        [self.deskLightChangeButton    setEnabled:YES];
        [self.deskLightLevelIndicator  setEnabled:YES];
        [self.shelfSwitchButton        setEnabled:YES];
        [self.shelfLightChangeButton   setEnabled:YES];
        [self.shelfLightLevelIndicator setEnabled:YES];
        [self.connexionStatusLabel setStringValue:@"Online"];
    }
}

- (IBAction)askForDisconnection:(id)sender
{
    [self.globalSwitchButton       setEnabled:NO];
    [self.globalLightChangeButton  setEnabled:NO];
    [self.bedSwitchButton          setEnabled:NO];
    [self.bedLightChangeButton     setEnabled:NO];
    [self.bedLightLevelIndicator   setEnabled:NO];
    [self.deskSwitchButton         setEnabled:NO];
    [self.deskLightChangeButton    setEnabled:NO];
    [self.deskLightLevelIndicator  setEnabled:NO];
    [self.shelfSwitchButton        setEnabled:NO];
    [self.shelfLightChangeButton   setEnabled:NO];
    [self.shelfLightLevelIndicator setEnabled:NO];
    [self.connexionStatusLabel setStringValue:@"Offline"];
}

- (IBAction)changeConnexionType:(id)sender
{
    if (SSH_MODE)
    {
        NSLog(@"Online Mode");
    }
    else if (USB_MODE)
    {
        NSLog(@"Offline Mode");
    }
}


# pragma mark Globals commands

- (IBAction)switchGlobal:(id)sender
{
    if ([self.globalSwitchButton selectedSegment] == ON)
    {
        [self sendCommand:@"Am"];
    }
    else if ([self.globalSwitchButton selectedSegment] == OFF)
    {
        [self sendCommand:@"Ao"];
    }
}

- (IBAction)lightChangeForAll:(id)sender
{
    if ([self.globalLightChangeButton selectedSegment] == MINUS)
    {
        [self sendCommand:@"A-"];
    }
    else if ([self.globalLightChangeButton selectedSegment] == PLUS)
    {
        [self sendCommand:@"A+"];
    }
}


# pragma mark Commands for Bed channel

- (IBAction)switchBed:(id)sender
{
    if ([self.globalSwitchButton selectedSegment] == ON)
    {
        [self sendCommand:@"6m"];
    }
    else if ([self.globalSwitchButton selectedSegment] == OFF)
    {
        [self sendCommand:@"6o"];
    }
}

- (IBAction)lightChangeForBed:(id)sender
{
    if ([self.globalLightChangeButton selectedSegment] == MINUS)
    {
        [self sendCommand:@"6-"];
    }
    else if ([self.globalLightChangeButton selectedSegment] == PLUS)
    {
        [self sendCommand:@"6+"];
    }
}


# pragma mark Commands for Desk channel

- (IBAction)switchDesk:(id)sender
{
    if ([self.globalSwitchButton selectedSegment] == ON)
    {
        [self sendCommand:@"5m"];
    }
    else if ([self.globalSwitchButton selectedSegment] == OFF)
    {
        [self sendCommand:@"5o"];
    }
}

- (IBAction)lightChangeForDesk:(id)sender
{
    if ([self.globalLightChangeButton selectedSegment] == MINUS)
    {
        [self sendCommand:@"5-"];
    }
    else if ([self.globalLightChangeButton selectedSegment] == PLUS)
    {
        [self sendCommand:@"5+"];
    }
}


# pragma mark Commands for Shelf channel

- (IBAction)switchShelf:(id)sender
{
    if ([self.globalSwitchButton selectedSegment] == ON)
    {
        [self sendCommand:@"3m"];
    }
    else if ([self.globalSwitchButton selectedSegment] == OFF)
    {
        [self sendCommand:@"3o"];
    }
}

- (IBAction)lightChangeForShelf:(id)sender
{
    if ([self.globalLightChangeButton selectedSegment] == MINUS)
    {
        [self sendCommand:@"3-"];
    }
    else if ([self.globalLightChangeButton selectedSegment] == PLUS)
    {
        [self sendCommand:@"3+"];
    }
}

@end
