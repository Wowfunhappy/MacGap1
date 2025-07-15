#import "AppDelegate.h"

@implementation AppDelegate

@synthesize windowController;

- (void) applicationWillFinishLaunching:(NSNotification *)aNotification
{
    
}

-(BOOL)applicationShouldHandleReopen:(NSApplication*)application
                   hasVisibleWindows:(BOOL)visibleWindows{
    if(!visibleWindows){
        [self.windowController.window makeKeyAndOrderFront: nil];
    }
    return YES;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.windowController = [[WindowController alloc] initWithURL: kStartPage];
    [self.windowController showWindow: [NSApplication sharedApplication].delegate];
    self.windowController.contentView.webView.alphaValue = 1.0;
    self.windowController.contentView.alphaValue = 1.0;
    [self.windowController showWindow:self];
    
    // Apply window constraints from Info.plist
    [self applyWindowConstraints];
}

- (void)applyWindowConstraints {
    // Get values from Info.plist
    NSString *minWidthString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MinimumWindowWidth"];
    NSString *minHeightString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MinimumWindowHeight"];
    NSString *maxWidthString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MaximumWindowWidth"];
    NSString *maxHeightString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MaximumWindowHeight"];
    
    // Convert strings to CGFloat values with defaults
    CGFloat minWidth = minWidthString ? [minWidthString doubleValue] : 400.0;
    CGFloat minHeight = minHeightString ? [minHeightString doubleValue] : 300.0;
    CGFloat maxWidth = maxWidthString ? [maxWidthString doubleValue] : CGFLOAT_MAX;
    CGFloat maxHeight = maxHeightString ? [maxHeightString doubleValue] : CGFLOAT_MAX;
    
    // Set minimum window size
    self.windowController.window.minSize = NSMakeSize(minWidth, minHeight);
    
    // Set maximum window size
    self.windowController.window.maxSize = NSMakeSize(maxWidth, maxHeight);
    
    // Disable full screen if maximum width or height is specified
    if (maxWidthString || maxHeightString) {
        NSWindowCollectionBehavior behavior = self.windowController.window.collectionBehavior;
        behavior &= ~NSWindowCollectionBehaviorFullScreenPrimary;
        self.windowController.window.collectionBehavior = behavior;
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    id terminateAfterLastWindowClosed = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"TerminateAfterLastWindowClosed"];
    
    if (terminateAfterLastWindowClosed && [terminateAfterLastWindowClosed isKindOfClass:[NSNumber class]]) {
        return [terminateAfterLastWindowClosed boolValue];
    }
    
    return NO;
}

@end