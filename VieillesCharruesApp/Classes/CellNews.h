//
//  CellNews.h
//  VieillesCharruesApp
//
//  Created by ToM on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellNews : UITableViewCell {
	IBOutlet UILabel *titre;
	IBOutlet UILabel *datePub;
	IBOutlet UIImageView *logo;
}
@property (retain, nonatomic) IBOutlet UIImageView *logo;
@property (retain, nonatomic) IBOutlet UILabel *titre;
@property (retain, nonatomic) IBOutlet UILabel *datePub;
@end
