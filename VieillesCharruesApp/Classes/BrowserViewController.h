//
//  BrowserViewController.h
//	Festival
//
//	Created by Julien Le Goff on 15/06/2010 .
//	Copyright Images Creation 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController <UIWebViewDelegate> {

	NSInteger					pageCount;
	NSInteger					maxPageCount;
	
	UILabel						*titleLabel;
	UIBarButtonItem				*previousItem;
	UIBarButtonItem				*nextItem;
	UIButton					*stopButton;
	UIView						*activityIndicator;
	
	UIWebView					*browserWebView;
	
}

@property (nonatomic, retain) UILabel						*titleLabel;
@property (nonatomic, retain) UIBarButtonItem				*previousItem;
@property (nonatomic, retain) UIBarButtonItem				*nextItem;
@property (nonatomic, retain) UIButton						*stopButton;
@property (nonatomic, retain) UIView						*activityIndicator;

@property (nonatomic, retain) UIWebView						*browserWebView;

- (id)initWithString:(NSString*)string;
- (void)previousAction;
- (void)nextAction;
- (void)refreshAction;
- (void)doneAction;
- (void)setNeedDisplayWithOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
