//
//  FolderPicker.h
//  MacGap
//

#import <Foundation/Foundation.h>
#import "WindowController.h"

@interface FolderPicker : NSObject

@property (nonatomic, retain) WebView *webView;
- (id) initWithWebView:(WebView *)view;
- (NSString *)chooseFolder;

@end