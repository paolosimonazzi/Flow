//
//  CellForAddingFriends.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "CellForAddingFriends.h"

@implementation CellForAddingFriends
@synthesize user0_sel, user2_sel, user1_sel,
			user0, user1, user2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CellForAddingFriends" owner:self options:nil];
		self = [nibArray objectAtIndex:0];
    }
    return self;
}
- (void) selectUser:(int)num {
	
	
}
- (void) userSelected:(int)num {
	float animationTime = 0.5;
	switch (num) {
		case 0: {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration: animationTime];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDelegate:self];
			//[UIView setAnimationDidStopSelector:@selector(animationContentsFeedVersionFinished)];
			
			user0_sel.frame = CGRectMake(20, 10, 65, 65);
			user0.alpha = 1.0;
			[UIView commitAnimations];
			user0Status = 1;
		}
			break;
			
		case 1: {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration: animationTime];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDelegate:self];
			//[UIView setAnimationDidStopSelector:@selector(animationContentsFeedVersionFinished)];
			
			user1_sel.frame = CGRectMake(125, 10, 65, 65);
			user1.alpha = 1.0;

			[UIView commitAnimations];
			user1Status = 1;

		}
			break;
		case 2: {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration: animationTime];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDelegate:self];
			//[UIView setAnimationDidStopSelector:@selector(animationContentsFeedVersionFinished)];
			
			user2_sel.frame = CGRectMake(230, 10, 65, 65);
			user2.alpha = 1.0;

			
			[UIView commitAnimations];
			user2Status = 1;
		}
			break;

			
		default:
			break;
	}
}
- (void) restorePositionItem0 {
	user0_sel.frame = CGRectMake(-100, 10, 65, 65);
}
- (void) restorePositionItem1 {
	user1_sel.frame = CGRectMake(-100, 10, 65, 65);
}
- (void) restorePositionItem2 {
	user2_sel.frame = CGRectMake(-100, 10, 65, 65);
}

- (void) userUnselected:(int)num {
	float animationTime = 0.5;
	switch (num) {
		case 0: {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration: animationTime];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(restorePositionItem0)];

			user0_sel.frame = CGRectMake(340, 10, 65, 65);
			user0.alpha = .5;
			[UIView commitAnimations];
			
			user0Status = 0;

		}
			break;
			
		case 1: {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration: animationTime];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(restorePositionItem1)];
			
			user1_sel.frame = CGRectMake(340, 10, 65, 65);
			user1.alpha = 0.5;
			
			[UIView commitAnimations];
			user1Status = 0;
			
		}
			break;
		case 2: {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration: animationTime];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(restorePositionItem2)];
			
			user2_sel.frame = CGRectMake(340, 10, 65, 65);
			user2.alpha = 0.5;
			
			[UIView commitAnimations];
			user2Status = 0;
			
		}
			break;
			
			
		default:
			break;
	}
}

-(IBAction) user0Click:	(id) sender {
	if (!user0Status)
		[self userSelected:0];
	else {
		[self userUnselected:0];
	}
}
-(IBAction) user1Click:	(id) sender {
	if (!user1Status) {
		user1_sel.frame = CGRectMake(-100, 10, 65, 65);
		[self userSelected:1];
	}
	else {
		[self userUnselected:1];
	}
}
-(IBAction) user2Click:	(id) sender {
	if (!user2Status)
		[self userSelected:2];
	else {
		[self userUnselected:2];
	}
}

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
