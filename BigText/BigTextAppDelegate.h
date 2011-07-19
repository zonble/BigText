#import <Cocoa/Cocoa.h>

@interface BigTextAppDelegate : NSObject <NSApplicationDelegate> {
	NSWindow *_window;
	NSTextView *textView;
}

- (IBAction)saveImage:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;

@end
