//
//  MAJ.h
//  VieillesCharruesApp
//
//  Created by Thomas Belin on 18/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constantes.h"
#import "VCNewsParser.h"

@protocol VCFluxUpdaterDelegate <NSObject>

@optional
- (void)majEnded:(int)test;

@end


@interface VCFluxUpdater : NSObject {

	
	id<VCFluxUpdaterDelegate> delegate;
}

@property (nonatomic, assign) id<VCFluxUpdaterDelegate> delegate;


-(void)miseAjourNews;
-(void)miseAjourProg;

@end
