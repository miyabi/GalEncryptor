//
//  GalEncryptorViewController.h
//  GalEncryptor
//
//  Created by Masayuki Iwai on 10/07/02.
//  Copyright mybdesign 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalEncryptorViewController : UIViewController {

	UITextView *inputTextView;
	UITextView *outputTextView;
	UIToolbar *middleToolbar;
	UIToolbar *keyboardToolbar;
	
	CGRect keyboardToolbarFrame;
}

@property (nonatomic, retain) IBOutlet UITextView *inputTextView;
@property (nonatomic, retain) IBOutlet UITextView *outputTextView;
@property (nonatomic, retain) IBOutlet UIToolbar *middleToolbar;
@property (nonatomic, retain) IBOutlet UIToolbar *keyboardToolbar;

- (IBAction)didPressExchangeButton:(id)sender;
- (IBAction)didPressEncryptButton:(id)sender;
- (IBAction)didPressDecryptButton:(id)sender;
- (IBAction)didPressClearButton:(id)sender;

@end

