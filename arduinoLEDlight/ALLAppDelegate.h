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

# pragma mark Global buttons' outlets
@property (weak) IBOutlet NSSegmentedControl *globalSwitchButton;
@property (weak) IBOutlet NSSegmentedControl *globalLightChangeButton;

# pragma mark Channel choice buttons' outlets
@property (weak) IBOutlet NSTabView *channelsTabViewButtons;

# pragma mark Buttons' outlets for Bed channel
@property (weak) IBOutlet NSSegmentedControl *bedSwitchButton;
@property (weak) IBOutlet NSSegmentedControl *bedLightChangeButton;
@property (weak) IBOutlet NSLevelIndicator   *bedLightLevelIndicator;

# pragma mark Buttons' outlets for Desk channel
@property (weak) IBOutlet NSSegmentedControl *deskSwitchButton;
@property (weak) IBOutlet NSSegmentedControl *deskLightChangeButton;
@property (weak) IBOutlet NSLevelIndicator   *deskLightLevelIndicator;

# pragma mark Buttons' outlets for Shelf channel
@property (weak) IBOutlet NSSegmentedControl *shelfSwitchButton;
@property (weak) IBOutlet NSSegmentedControl *shelfLightChangeButton;
@property (weak) IBOutlet NSLevelIndicator   *shelfLightLevelIndicator;


# pragma mark Connexion action buttons
- (IBAction)askForConnection:   (id)sender;
- (IBAction)askForDisconnection:(id)sender;

# pragma mark Buttons actions for all channels
- (IBAction)switchGlobal:       (id)sender;
- (IBAction)lightChangeForAll:  (id)sender;

# pragma mark Buttons actions for Bed channel
- (IBAction)switchBed:          (id)sender;
- (IBAction)lightChangeForBed:  (id)sender;

# pragma mark Buttons actions for Desk channel
- (IBAction)switchDesk:         (id)sender;
- (IBAction)lightChangeForDesk: (id)sender;

# pragma mark Buttons actions for Shelf channel
- (IBAction)switchShelf:        (id)sender;
- (IBAction)lightChangeForShelf:(id)sender;

@end
