#import "BigTextAppDelegate.h"

@implementation BigTextAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[textView setFont:[NSFont systemFontOfSize:48.0]];
	[textView setRulerVisible:YES];
}

- (IBAction)saveImage:(id)sender
{	
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	[savePanel setExtensionHidden:NO];
	[savePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"png", nil]];
	[savePanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result != NSOKButton) {
			return;
		}
		NSURL *URL = [savePanel URL];
		NSAttributedString *s = [textView textStorage];
		NSRect frame = [s boundingRectWithSize:NSMakeSize(3000.0, 3000.0) options:NSStringDrawingUsesLineFragmentOrigin];
		NSImage *newImage = [[NSImage alloc] initWithSize:frame.size];
		[newImage lockFocus];
		[s drawInRect:frame];
		NSBitmapImageRep *bitmapImage = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0.0, 0.0, [newImage size].width, [newImage size].height)];
		[newImage unlockFocus];
		[newImage recache];
		[newImage autorelease];
		
		NSBitmapImageFileType imageType = NSPNGFileType;
		NSData *data = [bitmapImage representationUsingType:imageType properties:nil];
		[data writeToURL:URL atomically:YES];
		
	}];
}

- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem
{
	if ([theItem action] == @selector(saveImage:)) {
		NSAttributedString *s = [textView textStorage];
		if (![s length]) {
			return NO;
		}
	}
	return YES;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	if ([menuItem action] == @selector(saveImage:)) {
		NSAttributedString *s = [textView textStorage];
		if (![s length]) {
			return NO;
		}
	}
	return YES;
}
	 

@synthesize window = _window;
@synthesize textView;


@end
