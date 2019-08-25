#import "BigTextAppDelegate.h"

typedef enum {
	BTEffectNone = 0,
	BTEffectZoomBlur = 1,
	BTEffectLeftTransform = 2
} BTEffect ;

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
		NSBitmapImageRep *bitmapImage = nil;
		NSAttributedString *s = [textView textStorage];
		NSRect frame = [s boundingRectWithSize:NSMakeSize(3000.0, 3000.0) options:NSStringDrawingUsesLineFragmentOrigin];
		NSImage *newImage = [[NSImage alloc] initWithSize:frame.size];
		[newImage lockFocus];
		[s drawInRect:frame];
		bitmapImage = [[[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0.0, 0.0, [newImage size].width, [newImage size].height)] autorelease];
		[newImage unlockFocus];
		[newImage recache];
		[newImage autorelease];
		
		NSBitmapImageFileType imageType = NSPNGFileType;
		NSData *data = [bitmapImage representationUsingType:imageType properties:@{}];
		
		NSInteger effect = [effectMatrix selectedTag];
		if (effect == BTEffectZoomBlur) {
			CIFilter *filter = [CIFilter filterWithName:@"CIZoomBlur"];
			[filter setDefaults];
			[filter setValue:[CIImage imageWithData:data] forKey:@"inputImage"];
			CIVector *v = [CIVector vectorWithX:[newImage size].width / 2.0 Y:[newImage size].height / 2.0];
			[filter setValue:v forKey:@"inputCenter"];
			[filter setValue:[NSNumber numberWithFloat:3.0] forKey:@"inputAmount"];
			CIImage *effectedImage = [filter valueForKey: @"outputImage"];
			bitmapImage = [[NSBitmapImageRep alloc] initWithCIImage:effectedImage];
			data = [bitmapImage representationUsingType:imageType properties:@{}];
		}
		else if (effect == BTEffectLeftTransform) {
			CIFilter *filter = [CIFilter filterWithName:@"CIPerspectiveTransform"];
			[filter setDefaults];
			[filter setValue:[CIImage imageWithData:data] forKey:@"inputImage"];
			[filter setValue:[CIVector vectorWithX:0 Y:[newImage size].height] forKey:@"inputTopLeft"];
			[filter setValue:[CIVector vectorWithX:0 Y:0] forKey:@"inputBottomLeft"];
			[filter setValue:[CIVector vectorWithX:[newImage size].width Y:([newImage size].height * 0.8)] forKey:@"inputTopRight"];
			[filter setValue:[CIVector vectorWithX:[newImage size].width Y:([newImage size].height * 0.2)] forKey:@"inputBottomRight"];

			CIImage *effectedImage = [filter valueForKey: @"outputImage"];
			bitmapImage = [[NSBitmapImageRep alloc] initWithCIImage:effectedImage];
			data = [bitmapImage representationUsingType:imageType properties:@{}];

		}
		
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
@synthesize effectMatrix;
@end
