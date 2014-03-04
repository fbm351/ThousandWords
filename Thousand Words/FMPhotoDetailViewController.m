//
//  FMPhotoDetailViewController.m
//  Thousand Words
//
//  Created by Fredrick Myers on 2/28/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMPhotoDetailViewController.h"
#import "Photo.h"
#import "FMFilterCollectionViewController.h"
#define TO_FILTER_VIEW @"toFilterViewController"


@interface FMPhotoDetailViewController ()

@end

@implementation FMPhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageView.image = self.photo.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFilterButtonPressed:(UIButton *)sender {
}

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
    [[self.photo managedObjectContext] deleteObject:self.photo];
    NSError *error = nil;
    [[self.photo managedObjectContext] save:&error];
    
    if (error) {
        NSLog(@"error");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TO_FILTER_VIEW])
    {
        FMFilterCollectionViewController *targetVC = segue.destinationViewController;
        targetVC.photo = self.photo;
    }
}





@end
