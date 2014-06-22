//
//  ALLAppDelegate.h
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

#import <Cocoa/Cocoa.h>
#import <Foundation/NSTask.h>

@interface ALLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSSegmentedControl *connexionTypeSelector;

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

@property (weak) IBOutlet NSTextField *connexionStatusLabel;
@property (weak) IBOutlet NSImageView *connexionStatusImage;


# pragma mark Connexion action buttons
- (IBAction)askForConnection:   (id)sender;
- (IBAction)askForDisconnection:(id)sender;
- (IBAction)changeConnexionType:(id)sender;

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
