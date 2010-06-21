//
//  UINavigationBar+Image.m
//  VieillesCharruesApp
//
//  Created by ToM on 20/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+Image.h"


@implementation UINavigationBar(UINavigationBarCategory)

-(void) drawRect:(CGRect) rect {
	
	UIImage *img	= [UIImage imageNamed: @"BandeauVieillesCharrues.png"];
	
	[img drawInRect:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height) blendMode:kCGBlendModeOverlay alpha:1];
	
}

@end
