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

#import "CellNews.h"


@implementation CellNews

@synthesize datePub, titre;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
		
		
		self.datePub = [[UILabel alloc] initWithFrame:CGRectMake(51, 5, 216, 17)];
		[datePub setFont:[UIFont systemFontOfSize:11]];
		[datePub setTextColor:[UIColor colorWithRed:48.0/255 green:131/255.0 blue:243/255.0 alpha:1.0]];
		[datePub setBackgroundColor:[UIColor clearColor]];
		[[self contentView] addSubview:datePub];
		[datePub release];
		
		self.titre = [[UILabel alloc] initWithFrame:CGRectMake(51, 20, 232, 37)];
		[titre setBackgroundColor:[UIColor clearColor]];
		[titre setNumberOfLines:2];
		[titre setFont:[UIFont systemFontOfSize:14.0]];
		[[self contentView] addSubview:titre];
		
		UIImage *imageSource = nil;
		
        if([reuseIdentifier isEqualToString:@"CellTwitter"])
			imageSource = [UIImage imageNamed:@"Twitter.png"];
		else if([reuseIdentifier isEqualToString:@"CellFacebook"])
			imageSource = [UIImage imageNamed:@"Facebook.png"];
		else if([reuseIdentifier isEqualToString:@"CellVieillesCharrues"])
			imageSource = [UIImage imageNamed:@"VieillesCharrues.png"];
		
		UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(3.0, 14.0, 40.0, 40.0)];
		[[self contentView] addSubview:logo];
		[logo release];
		
		[logo setImage:imageSource];
		
		colorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 70)];
		[self setBackgroundView:colorView];
    }
    return self;
}

-(void) loadWithNews:(VCNews *) nouvelle andParity:(BOOL)isOdd{
	
	NSDateFormatter *formateurDeDate = [[NSDateFormatter alloc] init];
	[formateurDeDate setDateFormat:@"dd MMM yyyy HH:mm:ss"];
	[formateurDeDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	NSString *jour = [formateurDeDate stringFromDate:nouvelle.date];
	[formateurDeDate release];
	
	
	
	self.tag = [nouvelle.idNews intValue];
	if([nouvelle.titre length] > 5)
		titre.text = nouvelle.titre;
	else {
		titre.text = nouvelle.description;
	}
	
	datePub.text = jour;
	
	if (isOdd)
		[colorView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.90 alpha:1]];
	else {
		[colorView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
	}	
}



- (void)dealloc {
	[colorView release];
	[datePub release]; 
	[titre release];
    [super dealloc];
}


@end
