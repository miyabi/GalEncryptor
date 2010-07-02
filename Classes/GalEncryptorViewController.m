//
//  GalEncryptorViewController.m
//  GalEncryptor
//
//  Created by Masayuki Iwai on 10/07/02.
//  Copyright mybdesign 2010. All rights reserved.
//

#import "GalEncryptorViewController.h"
#import "GalEncryptorAppDelegate.h"


@implementation GalEncryptorViewController

@synthesize inputTextView, outputTextView, middleToolbar, keyboardToolbar;


#pragma mark -

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	if(animationID == @"showKeyboardToolbar")
	{
	}
	else if(animationID == @"hideKeyboardToolbar")
	{
		keyboardToolbar.hidden = YES;
	}
}


- (void)showkeyboardToolbar
{
	CGRect frame = keyboardToolbar.frame;
	frame.origin.y = self.view.bounds.size.height - frame.size.height;
	keyboardToolbar.frame = frame;
	keyboardToolbar.hidden = NO;
	
	[UIView beginAnimations:@"showKeyboardToolbar" context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	keyboardToolbar.frame = keyboardToolbarFrame;
	
	[UIView commitAnimations];
}


- (void)hidekeyboardToolbar
{
	CGRect frame = keyboardToolbar.frame;
	frame.origin.y = self.view.bounds.size.height - frame.size.height;
	
	[UIView beginAnimations:@"hideKeyboardToolbar" context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	keyboardToolbar.frame = frame;
	
	[UIView commitAnimations];
}


- (void)exchangeContents
{
	NSString *temp = inputTextView.text;
	inputTextView.text = outputTextView.text;
	outputTextView.text = temp;
}


- (void)encryptContent
{
	NSMutableString *resultString = [[NSMutableString alloc] initWithString:@""];
	
	GalEncryptorAppDelegate *appDelegate = (GalEncryptorAppDelegate *)[UIApplication sharedApplication].delegate;
	
	NSInteger length = [inputTextView.text length];
	NSString *src, *dst;
	for(int i=length-1; i>=0; i--)
	{
		src = [inputTextView.text substringWithRange:NSMakeRange(i, 1)];
		dst = [appDelegate.encryptionDictionary objectForKey:src];
		if(dst != nil && [dst length] > 0)
		{
			[resultString appendString:dst];
		}
		else
		{
			[resultString appendString:src];
		}
	}
	
	outputTextView.text = resultString;
	[resultString release];
}


- (void)decryptContent
{
	NSMutableString *resultString = [[NSMutableString alloc] initWithString:@""];
	
	GalEncryptorAppDelegate *appDelegate = (GalEncryptorAppDelegate *)[UIApplication sharedApplication].delegate;
	NSMutableDictionary *reverseDictionary = [[NSMutableDictionary alloc] init];
	NSEnumerator *enumerator = [appDelegate.encryptionDictionary keyEnumerator];
	NSString *key, *value;
	while((key = [enumerator nextObject]))
	{
		value = [appDelegate.encryptionDictionary objectForKey:key];
		if(value != nil && [value length] > 0)
			[reverseDictionary setObject:key forKey:value];
	}
	
	NSInteger length = [inputTextView.text length];
	NSString *src, *dst;
	for(int i=length-1; i>=0; i--)
	{
		src = [inputTextView.text substringWithRange:NSMakeRange(i, 1)];
		dst = [reverseDictionary objectForKey:src];
		if(dst != nil && [dst length] > 0)
		{
			[resultString appendString:dst];
		}
		else
		{
			[resultString appendString:src];
		}
	}
	
	outputTextView.text = resultString;
	[resultString release];
	[reverseDictionary release];
}


#pragma mark -

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	keyboardToolbarFrame = keyboardToolbar.frame;
	keyboardToolbar.hidden = YES;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	self.inputTextView = nil;
	self.outputTextView = nil;
	self.middleToolbar = nil;
	self.keyboardToolbar = nil;
	
    [super dealloc];
}


#pragma mark -
#pragma mark IBActions

- (IBAction)didPressExchangeButton:(id)sender
{
	[self exchangeContents];
}


- (IBAction)didPressEncryptButton:(id)sender
{
	[inputTextView performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.0f];
	[self encryptContent];
}


- (IBAction)didPressDecryptButton:(id)sender
{
	[inputTextView performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.0f];
	[self decryptContent];
}


- (IBAction)didPressClearButton:(id)sender
{
	inputTextView.text = @"";
}


#pragma mark -
#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[self showkeyboardToolbar];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
	[self hidekeyboardToolbar];
}


@end
