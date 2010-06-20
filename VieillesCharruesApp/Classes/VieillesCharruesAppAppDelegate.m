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

#import "VieillesCharruesAppAppDelegate.h"


@implementation VieillesCharruesAppAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == YES);
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

