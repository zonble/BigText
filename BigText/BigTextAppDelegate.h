#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface BigTextAppDelegate : NSObject <NSApplicationDelegate> 
{
	NSWindow *_window;
	NSTextView *textView;
	NSMatrix *effectMatrix;
}

- (IBAction)saveImage:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSMatrix *effectMatrix;

@end
