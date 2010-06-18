//
//  NewsDetailsView.h
//  VieillesCharruesApp
//
//  Created by ToM on 23/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCNews.h"

@interface NewsDetailsView : UIViewController 
{
	IBOutlet UILabel *datePub;
	IBOutlet UITextView *description;
}

@property (retain, nonatomic) IBOutlet UILabel *datePub;
@property (retain, nonatomic) IBOutlet UITextView *description;

-(void)initWithNouvelle:(VCNews*)nouvelle;

@end
