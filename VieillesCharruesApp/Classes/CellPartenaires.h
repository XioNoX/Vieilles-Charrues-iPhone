//
//  CellPartenaires.h
//
//  Created by ToM on 05/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CellPartenaires : UITableViewCell {
    IBOutlet UIImageView *imagePartenaire;
    IBOutlet UILabel *nom;
}

-(void) initWithNom:(NSString*)name;

@end
