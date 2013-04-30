//
//  CustomCell.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "GlanceCell.h"
#import "ContentPage.h"
#import "GlancePage.h"

#define XGRAPHTRANSLATIION 400
@implementation GlanceCell

@synthesize profilePic, mask, graphPic, acceptButton, declineButton, row, GlancePageRef, time, where;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil];
		self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) loadingFriendShipVersion {
	
	CGRect graphFrame = graphPic.frame;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: 1];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(restorePositionItem2)];
	
	graphPic.frame = CGRectMake(graphFrame.origin.x+-XGRAPHTRANSLATIION, graphFrame.origin.y, graphFrame.size.width, graphFrame.size.height);
	//userSel.frame = CGRectMake(340, 10, 65, 65);
	//user.alpha = .5;
	acceptButton.alpha  = 0.0;
	declineButton.alpha = 0.0;
	[UIView commitAnimations];


}
- (void) acceptanceVersion {
	CGRect graphFrame = graphPic.frame;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: 1];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(restorePositionItem2)];

	graphPic.frame = CGRectMake(graphFrame.origin.x+XGRAPHTRANSLATIION, graphFrame.origin.y, graphFrame.size.width, graphFrame.size.height);
	//userSel.frame = CGRectMake(340, 10, 65, 65);
	//user.alpha = .5;
	acceptButton.alpha  = 1.0;
	declineButton.alpha = 1.0;
	[UIView commitAnimations];

}

- (void) normalVersion {

}

-(IBAction) acceptClick:	(id) sender {
	
	[GlancePageRef acceptFriendship:row];

}

-(IBAction) declineClick:	(id) sender {

}


@end
