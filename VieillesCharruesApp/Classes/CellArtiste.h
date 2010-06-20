//
//  CellArtiste.h
//  VieillesCharruesApp
//
//  Created by ToM on 20/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellArtiste : UITableViewCell {
	
	UILabel		*groupeLabel;
	UIView		*colorView;

}

@property (retain, nonatomic) UILabel *groupeLabel;

-(void) loadWithArtiste:(NSString*)nomArtiste parity:(BOOL)isOdd;

@end
