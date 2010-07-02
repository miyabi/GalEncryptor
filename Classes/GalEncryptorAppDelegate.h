//
//  GalEncryptorAppDelegate.h
//  GalEncryptor
//
//  Created by Masayuki Iwai on 10/07/02.
//  Copyright mybdesign 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GalEncryptorViewController;

@interface GalEncryptorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GalEncryptorViewController *viewController;
	
	NSDictionary *encryptionDictionary;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GalEncryptorViewController *viewController;

@property (nonatomic, retain) NSDictionary *encryptionDictionary;

@end

