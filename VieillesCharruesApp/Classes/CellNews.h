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
#import "VCNews.h"


@interface CellNews : UITableViewCell {
	UILabel			*titre;
	UILabel			*datePub;
	NSDateFormatter	*formateurDeDate;
	UIView			*colorView;
}

@property (nonatomic, retain) NSDateFormatter *formateurDeDate;
@property (retain, nonatomic) UILabel *titre;
@property (retain, nonatomic) UILabel *datePub;
@property (retain, nonatomic) UIView			*colorView;

-(void) loadWithNews:(VCNews *) nouvelle andParity:(BOOL)isOdd;

@end
