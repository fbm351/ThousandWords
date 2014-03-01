//
//  FMPhotosCollectionViewController.h
//  Thousand Words
//
//  Created by Fredrick Myers on 2/28/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface FMPhotosCollectionViewController : UICollectionViewController

@property (strong, nonatomic) Album *album;

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
