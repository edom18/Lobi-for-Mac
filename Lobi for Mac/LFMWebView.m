
#import "LFMWebView.h"

typedef NS_ENUM(NSInteger, LFMSwipeDirection) {
    LFMSwipeDirectionNone = 0,
    LFMSwipeDirectionLeft = 1,
    LFMSwipeDirectionRight = -1,
};

@implementation LFMWebView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

// ヒストリーバック
- (void)historyBack
{
    if ([self canGoBack]) {
        [self goBack];
    }
}

// ヒストリーフォワード
- (void)historyForward
{
    if ([self canGoForward]) {
        [self goForward];
    }
}

// load URL
- (void)loadURLWithString:(NSString *)urlString
{
    [self setMainFrameURL:urlString];
}


// ----------------------------------------------
#pragma mark - Event delegate

- (void)swipeWithEvent:(NSEvent *)event
{
    LFMSwipeDirection x = (LFMSwipeDirection)[event deltaX];
    
    switch (x) {
        case LFMSwipeDirectionNone: {
            return;
        }
        case LFMSwipeDirectionLeft: {
            [self historyBack];
            break;
        }
        case LFMSwipeDirectionRight: {
            [self historyForward];
            break;
        }
    }
}

@end
