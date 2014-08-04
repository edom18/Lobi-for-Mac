
#import <WebKit/WebKit.h>
#import "LFMAppDelegate.h"
#import "LFMWebView.h"

static const NSString *kLFMDomain = @"https://web.lobi.co";

@interface LFMAppDelegate ()

@property (weak) IBOutlet LFMWebView *webview;

@end

@implementation LFMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self goTop:nil];
}

/**
 *  URL生成
 *
 *  @param path ドメイン以下のパス
 *
 *  @return ドメイン込みのURL
 */
- (NSString *)createURLWithPath:(NSString *)path
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLFMDomain, path];
    return urlString;
}

- (NSString *)fetchUID
{
    NSString *javascript = @"(function () {"
                            "var a = document.querySelector('.header-menu__item.header-menu__item--profile');"
                            "var href = a.getAttribute('ng-href');"
                            "var match = href.match('\\/([a-zA-Z0-9]*)$');"
                            "if (match) return match[1];"
                            "}());";
    NSString *uid = [self.webview stringByEvaluatingJavaScriptFromString:javascript];
    
    return uid;
}

// ----------------------------------------------------------
#pragma mark - for IBActions

- (IBAction)changeViewModeAsPC:(id)sender {
    [self.webview setCustomUserAgent:nil];
    [self.webview reload:nil];
}
- (IBAction)changeViewModeAsIPhone:(id)sender {
    static NSString *userAgentAsIPhone = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53";
    [self.webview setCustomUserAgent:userAgentAsIPhone];
    [self.webview reload:nil];
}
- (IBAction)webViewBack:(id)sender {
    [self.webview historyBack];
}
- (IBAction)webViewForward:(id)sender {
    [self.webview historyForward];
}
- (IBAction)goSettings:(id)sender {
    NSString *urlString = [self createURLWithPath:@"/setting"];
    [self.webview loadURLWithString:urlString];
}
- (IBAction)goFriendsList:(id)sender {
    NSString *urlString = [self createURLWithPath:@"/contact"];
    [self.webview loadURLWithString:urlString];
}
- (IBAction)goProfile:(id)sender {
    static NSString *uid = nil;
    if (!uid) {
        uid = [self fetchUID];
    }
    NSString *path = [NSString stringWithFormat:@"/user/%@", uid];
    NSString *urlString = [self createURLWithPath:path];
    [self.webview loadURLWithString:urlString];
}
- (IBAction)goHome:(id)sender {
    NSString *urlString = [self createURLWithPath:@"/home"];
    [self.webview loadURLWithString:urlString];
}
- (IBAction)goTop:(id)sender {
    NSString *urlString = [self createURLWithPath:@"/"];
    [self.webview loadURLWithString:urlString];
}
- (IBAction)reload:(id)sender {
    [self.webview reload:nil];
}

@end
