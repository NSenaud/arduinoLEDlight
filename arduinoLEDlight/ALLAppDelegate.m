//
//  ALLAppDelegate.m
//  arduinoLEDlight
//
//  Created by Nicolas Senaud on 2014/05/24.
//  Copyright (c) 2014 Nicolas Senaud. All rights reserved.
//

#import "ALLAppDelegate.h"


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


# pragma mark Command interface for asking connekion with Arduino

- (IBAction)askForConnection:(id)sender
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
}

- (IBAction)changeConnexionType:(id)sender
{
    if ([self.connexionTypeSelector selectedSegment] == SSH)
    {
        NSLog(@"Online Mode");
    }
    else if ([self.connexionTypeSelector selectedSegment] == LOCAL)
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
