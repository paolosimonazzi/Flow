//
//  AddFriends.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "AddFriends.h"
#import "CellForAddingFriends.h"
#import "Connection.h"
#import "UIImage+animatedGIF.h"

@interface AddFriends ()

@end

@implementation AddFriends
@synthesize friendsToAddTable, usersArray, loadingPage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
		self.friendsToAddTable.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
    }
    return self;
}
- (void) usersBack:(NSData*)_data {
	
	NSError* error;
	
	usersArray = [NSJSONSerialization JSONObjectWithData:_data //1
													 options:kNilOptions
													   error:&error];
	
	for (int idx = 0; idx<[usersArray count]; ++idx) {
		//NSDictionary *dict = [array objectAtIndex:idx] objectForKey:@"username";
		NSString *userName = [[usersArray objectAtIndex:idx] objectForKey:@"username"];
		if (nil!=userName)
			NSLog(@"username: %@", userName);
	}
	
	NSLog(@"num users: %d", [usersArray count]);
	
	[self.friendsToAddTable reloadData];
	[loadingPage removeFromSuperview];

}
- (void)viewWillAppear:(BOOL)animated {    // Called when the view is about to made visible. Default does nothing
	[self loadNetwork];
	[self.view addSubview:loadingPage];
}

- (void) loadNetwork {
	
	Connection *conn = [[Connection alloc] initWithTarget:self withSelector:@selector(usersBack:)];
	[conn loadUsersNetwork];
	

}

- (void) viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"glance-animation" withExtension:@"gif"];
    
	self.gif.image = [UIImage animatedImageWithAnimatedGIFURL:url];
	
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table's stuff

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return [usersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CellForAddingFriends";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if ( nil == cell ) {
		cell = [[CellForAddingFriends alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	CellForAddingFriends *myCell = (CellForAddingFriends*) cell;
	cell.backgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];

	return cell;
	
	/*
	 static NSString *CellIdentifier = @"Cell";
	 
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	 }
	 
	 // Set the data for this cell:
	 
	 cell.textLabel.text = @"ciao";//[dataArray objectAtIndex:indexPath.row];
	 cell.detailTextLabel.text = @"More text";
	 cell.imageView.image = [UIImage imageNamed:@"flower.png"];
	 
	 // set the accessory view:
	 cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	 return cell;
	 */
}

#pragma mark -


@end
