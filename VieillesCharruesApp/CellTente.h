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
#import <Foundation/Foundation.h>
#import "VCTente.h"

@interface CellTente : UITableViewCell {
    IBOutlet UILabel *latitude;
    IBOutlet UILabel *longitude;
    IBOutlet UILabel *nom;
	IBOutlet UIButton *boutonSupprimer;
}

-(void) initWithTente:(VCTente*)tente;

@end
