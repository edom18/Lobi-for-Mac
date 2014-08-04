
#import <WebKit/WebKit.h>

@interface LFMWebView : WebView

/**
 *  ヒストリーバック（戻る）
 */
- (void)historyBack;

/**
 *  ヒストリーフォワード（進む）
 */
- (void)historyForward;

/**
 *  Load URL
 *
 *  @param urlString URL
 */
- (void)loadURLWithString:(NSString *)urlString;

@end
