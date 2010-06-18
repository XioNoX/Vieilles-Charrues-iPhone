//
//  ViewControllerInfos.h
//
//  Created by ToM on 30/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewControllerInfos : UIViewController {
    IBOutlet UIWebView *webView;
	IBOutlet UIView *viewAbout;
	IBOutlet UIWebView *textAbout;
}
- (IBAction)revealAbout:(id)sender;
- (IBAction) hideAbout:(id)sender;
- (IBAction) loadPartenaires;
@end
