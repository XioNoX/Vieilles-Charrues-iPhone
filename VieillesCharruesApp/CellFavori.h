//
//  CellFavori.h
//
//  Created by ToM on 07/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VCConcert.h"

@interface CellFavori : UITableViewCell {
    IBOutlet UILabel *heure;
    IBOutlet UILabel *nomGroupe;
    IBOutlet UILabel *scene;
}

@property (retain, nonatomic) IBOutlet UILabel *heure;
@property (retain, nonatomic) IBOutlet UILabel *nomGroupe;
@property (retain, nonatomic) IBOutlet UILabel *scene;

-(void) initWithConcert:(VCConcert*) concert;
-(void) initWithId:(NSNumber*)ident Groupe:(NSString *)bandName scene:(NSString *)nomScene heure:(NSString *)heureConcert;

@end
