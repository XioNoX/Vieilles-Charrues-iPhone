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

#import "ViewPlanVC.h"
#import "ViewLocation.h"
#import "ViewOuEstMaTente.h"

@implementation ViewPlanVC


 - (void)viewDidAppear:(BOOL)animated {
	[super viewDidLoad];
	//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pour bientôt" message:@"Le plan du site sera disponible juste avant le festival, n'oublie pas de télécharger la mise à jour avant d'arriver sur le site" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//[alert show];
	//[alert release];
}

- (IBAction)chargerPlanInterieur:(id)sender {
	ViewLocation *planDuSite = [[ViewLocation alloc] initWithNibName:@"ViewLocation" bundle:nil isExtern:NO];
	[self.navigationController pushViewController:planDuSite animated:YES];
	[planDuSite release];
    
}

- (IBAction)chargerPlanExterieur:(id)sender {
	ViewLocation *planDuSite = [[ViewLocation alloc] initWithNibName:@"ViewLocation" bundle:nil isExtern:YES];
	[self.navigationController pushViewController:planDuSite animated:YES];
	[planDuSite release];
    
}

- (IBAction)ouEstMaTente:(id)sender {
	ViewOuEstMaTente *ouEstMaTente = [[ViewOuEstMaTente alloc] initWithNibName:@"ViewOuEstMaTente" bundle:nil];
	[self.navigationController pushViewController:ouEstMaTente animated:YES];
	[ouEstMaTente release];
}
@end
