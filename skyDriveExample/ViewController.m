//
//  ViewController.m
//  skyDriveExample
//
//  Created by Kirill on 05.08.14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "ViewController.h"
#import "SkyDriveChooser.h"

#define CLIENT_ID @"0000000040126E26"

@interface ViewController () <SkyDriveChooserDelegate>

@end

@implementation ViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onSkyDriveTapped:(id)sender
{
    SkyDriveChooser *skyDriveChooser = [[SkyDriveChooser alloc] initWithClientId:CLIENT_ID];
    skyDriveChooser.delegate = self;

    [self presentViewController:skyDriveChooser
                       animated:YES
                     completion:nil];
}




#pragma mark - sky drive delegates

- (void)skyDriveChooser:(SkyDriveChooser *)skyDriveChooser fileChoosed:(NSDictionary *)fileInfo
{
    [skyDriveChooser dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", fileInfo);
    
    self.details.text = [fileInfo description];
}


- (void)skyDriverChooserCanceled:(SkyDriveChooser *)skyDriveChooser
{
    [skyDriveChooser dismissViewControllerAnimated:YES completion:nil];
}

@end
