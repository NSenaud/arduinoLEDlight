//
//  ALLAppDelegate.h
//  arduinoLEDlight
//
//  Created by Nicolas Senaud on 2014/05/24.
//  Copyright (c) 2014 Nicolas Senaud. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/NSTask.h>

@interface ALLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSButton *switchOnAll;
@property (weak) IBOutlet NSButton *switchOffAll;
@property (weak) IBOutlet NSButton *lightenAll;
@property (weak) IBOutlet NSButton *darkenAll;
@property (weak) IBOutlet NSTextField *lightLabel;

- (IBAction)askForConnection:(id)sender;
- (IBAction)askForDisconnection:(id)sender;

- (IBAction)switchOnAll:(id)sender;
- (IBAction)switchOffAll:(id)sender;
- (IBAction)lightenAll:(id)sender;
- (IBAction)darkenAll:(id)sender;

@end
