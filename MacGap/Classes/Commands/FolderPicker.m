//
//  FolderPicker.m
//  MacGap
//

#import "FolderPicker.h"

@implementation FolderPicker

@synthesize webView;

- (id) initWithWebView:(WebView*)view
{
    if(self = [super init]) {
        self.webView = view;
    }
    return self;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    if (selector == @selector(chooseFolder)) {
        return NO;
    }
    return YES;
}

+ (NSString *)webScriptNameForSelector:(SEL)selector {
    if (selector == @selector(chooseFolder)) {
        return @"chooseFolder";
    }
    return nil;
}

- (NSString *)chooseFolder {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    [panel setTitle:@"Choose Folder"];
    
    if ([panel runModal] == NSFileHandlingPanelOKButton) {
        NSURL *url = [[panel URLs] objectAtIndex:0];
        return [url path];
    }
    
    return @"";
}

@end