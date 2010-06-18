//
//  ViewLocation.h
//  VieillesCharruesApp
//
//  Created by ToM on 31/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCTente.h"
#import "VCCLLocationController.h"

@interface ViewLocation : UIViewController <UIScrollViewDelegate>
{
	VCCLLocationController *locationController;
	IBOutlet UIImageView *pointLocalisation;
	IBOutlet UIView *pointTente;
	IBOutlet UILabel *nomTente;
	IBOutlet UIImageView *carte;
	IBOutlet UIView *plan;
	IBOutlet UIScrollView *contenantPlan;
	NSTimer *timer;
	CGFloat initialDistance;
	CGRect cadreInitial;
	CGPoint pointInitial;
}

@property (retain, nonatomic) VCCLLocationController *locationController;

-(void) updateLocation;

-(void) setTenteLocation:(VCTente*)tente;

@end
