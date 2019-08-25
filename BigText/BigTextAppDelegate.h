#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface BigTextAppDelegate : NSObject <NSApplicationDelegate> 
{
	NSWindow *__unsafe_unretained _window;
	NSTextView *__unsafe_unretained textView;
	NSMatrix *__unsafe_unretained effectMatrix;
}

- (IBAction)saveImage:(id)sender;

@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (unsafe_unretained) IBOutlet NSMatrix *effectMatrix;

@end
