//
//  BrowserViewController.m
//	Festival
//
//	Created by Julien Le Goff on 15/06/2010 .
//	Copyright Images Creation 2010. All rights reserved.
//

#import "BrowserViewController.h"

@implementation BrowserViewController

@synthesize titleLabel;
@synthesize previousItem;
@synthesize nextItem;
@synthesize stopButton;
@synthesize activityIndicator;

@synthesize browserWebView;

#pragma mark -
#pragma mark Init

- (id)initWithString:(NSString*)string {

	if (self = [super init]) {
		
		pageCount = 0;
		maxPageCount = pageCount;
		
		[[self view] setBackgroundColor:[UIColor whiteColor]];
		
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
		[toolbar setTintColor:[UIColor blackColor]];
		[[self view] addSubview:toolbar];
		[toolbar release];
		
		self.previousItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"previous.png"] style:UIBarButtonItemStylePlain target:self action:@selector(previousAction)];
		[previousItem setEnabled:NO];
		self.nextItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStylePlain target:self action:@selector(nextAction)];
		[nextItem setEnabled:NO];
	
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 170.0, 44.0)];
		[titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
		[titleLabel setTextColor:[UIColor whiteColor]];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextAlignment:UITextAlignmentLeft];
		[titleLabel setAdjustsFontSizeToFitWidth:YES];
		[titleLabel setMinimumFontSize:11.0];
		[titleLabel setShadowColor:[UIColor colorWithWhite:0.5 alpha:1.0]];
		[titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
		[titleLabel setText:string];
		UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
		[titleLabel release];
		UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
		
		NSMutableArray *arrayOfItems = [[NSMutableArray alloc] initWithObjects:previousItem, nextItem, titleItem, doneItem, nil];
		[previousItem	release];
		[nextItem		release];
		[titleItem		release];
		[doneItem		release];
		
		[toolbar setItems:arrayOfItems];
		[arrayOfItems release];
		
		self.browserWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 431.0)];
		[browserWebView setScalesPageToFit:YES];
		[browserWebView setOpaque:YES];
		[browserWebView setUserInteractionEnabled:YES];
		[browserWebView setDelegate:self];
		[[self view] addSubview:browserWebView];
		[browserWebView release];
	
		NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
		[browserWebView	loadRequest:urlRequest];
		[urlRequest release];
		
		
		self.activityIndicator = [[UIView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 431.0)];
		[activityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
		UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[activity setFrame:CGRectMake(145.0, 200.0, 30.0, 30.0)];
		[activity startAnimating];
		[activity setAlpha:1.0];
		[activityIndicator addSubview:activity];
		[activity release];
		
		[[self view] addSubview:activityIndicator];
		[activityIndicator release];
		
	}
	
	return self;
}

#pragma mark -
#pragma mark Orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:duration];
	[self setNeedDisplayWithOrientation:toInterfaceOrientation];
	[UIView commitAnimations];
}

- (void)setNeedDisplayWithOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	switch (interfaceOrientation) {
		case UIDeviceOrientationPortrait:
		case UIDeviceOrientationPortraitUpsideDown:
			[browserWebView setFrame:CGRectMake(0.0, 44.0, 768.0, 960.0)];
			break;
		case UIDeviceOrientationLandscapeLeft:
		case UIDeviceOrientationLandscapeRight:
			[browserWebView setFrame:CGRectMake(0.0, 44.0, 768.0, 704.0)];
		default:
			break;
	}
	
}

#pragma mark -
#pragma mark UIButton Targets

- (void)previousAction {
	pageCount = pageCount - 2;
	[browserWebView goBack];
}

- (void)nextAction {
	[browserWebView goForward];
}

- (void)refreshAction {
	pageCount--;
	[browserWebView reload];
}

- (void)stopAction {
	[browserWebView stopLoading];
}

- (void)doneAction {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

	if([[[request URL] description] isEqualToString:@"about:blank"])
		return NO;
	
	pageCount++;
	if(pageCount > maxPageCount)
		maxPageCount = pageCount;
	
	if(pageCount > 1)
		[previousItem setEnabled:YES];
	else
		[previousItem setEnabled:NO];
	
	if(pageCount < maxPageCount)
		[nextItem setEnabled:YES];
	else
		[nextItem setEnabled:NO];
	
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[activityIndicator setAlpha:1.0];
	
	[stopButton setAlpha:1.0];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[activityIndicator setAlpha:0.0];
	
	[stopButton setAlpha:0.0];
	
	// Title
	[titleLabel setText:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[activityIndicator setAlpha:0.0];
	
	[stopButton setAlpha:0.0];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	
	[titleLabel			release];
	[previousItem		release];
	[nextItem			release];
	[stopButton			release];
	[activityIndicator	release];
	
	[browserWebView		release];
	
    [super dealloc];
}

@end
