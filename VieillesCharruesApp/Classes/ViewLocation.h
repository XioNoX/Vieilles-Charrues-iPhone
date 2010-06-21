/*
 * Copyright Thomas Belin 2010
 *
 * This file is part of Vieilles Charrues 2010.
 *
 * Vieilles Charrues 2010 is free software: you can redistribute it
 and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Vieilles Charrues 2010 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Vieilles Charrues 2010.  If not, see
 <http://www.gnu.org/licenses/>.
 */

#import <UIKit/UIKit.h>
#import "VCTente.h"
#import "VCCLLocationController.h"

@interface ViewLocation : UIViewController <UIScrollViewDelegate>
{
	VCCLLocationController		*locationController;
	
	
	UIScrollView				*carteScrollView;	
	UIView						*plan;
	UIImageView					*pointLocalisation;
	UIImageView					*carte;
	
	UIView						*pointTente;
	UILabel						*nomTente;
	
	
	NSTimer						*timer;
	CGFloat						initialDistance;
	CGRect						cadreInitial;
	CGPoint						pointInitial;
	
	CGPoint						pointHautGauche;
	CGPoint						pointBasDroit;
	
	CGPoint						locationAcutelle;
	VCTente						*tente;
}

@property (retain, nonatomic) VCCLLocationController *locationController;

//-(id)initWithNibName:(NSString*)nibName bundle:(NSBundle *)nibBundleOrNil isExtern:(BOOL)isExtern;

-(id) initMap:(BOOL)isExtern ;

-(void) updateLocation;

-(void) setTenteLocation:(VCTente*)tente;

//-(void) changerCarte:(id) sender;

-(float) determinerPositionX:(float) longitude;

-(float) determinerPositionY:(float) latitude;


@end
