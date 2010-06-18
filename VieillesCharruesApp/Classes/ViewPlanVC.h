//
//  ViewPlanVC.h
//
//  Created by ToM on 17/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewPlanVC : UIViewController {
    IBOutlet UIButton *buttonOuEstTente;
    IBOutlet UIButton *buttonPlanDuSite;
}
- (IBAction)chargerPlan:(id)sender;
- (IBAction)ouEstMaTente:(id)sender;
@end
