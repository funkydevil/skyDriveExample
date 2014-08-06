//
//  SkyDriveChooser.m
//  skyDriveExample
//
//  Created by Kirill on 05.08.14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "SkyDriveChooser.h"

@interface SkyDriveChooser ()

@end

@implementation SkyDriveChooser


-(id)initWithClientId:(NSString *)clientId
{
    VCFolderTable *vc = [[VCFolderTable alloc] init];
    self = [super initWithRootViewController:vc];
    if (self)
    {
        self.vcFolderTable = vc;
        vc.delegate = self;

        self.clientId = clientId;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.




//    self.navigationItem.leftBarButtonItems = @[bCancel];
//    NSLog(@"%@", self.navigationItem);

    //[self.navigationItem setLeftBarButtonItem:bCancel animated:YES];
}



- (void)viewDidAppear:(BOOL)animated
{
    if (!self.skyDriveModel) {
        self.skyDriveModel = [[SkyDriveModel alloc] initWithClientId:self.clientId
                                                                  andContextVC:self.vcFolderTable];

        [self.vcFolderTable setSkyDriveModel:self.skyDriveModel andFolderId:nil];
    }

}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView)
    {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.center = self.view.center;
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.color = [UIColor grayColor];
        [self.view addSubview:_activityIndicatorView];
    }

    return _activityIndicatorView;
}


- (UIView *)vOverlay
{
    if (!_vOverlay)
    {
        _vOverlay = [[UIView alloc] initWithFrame:self.view.frame];
        _vOverlay.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self.view addSubview:_vOverlay];
    }

    return _vOverlay;
}





#pragma mark folders delegate

- (void)fileSelected:(NSDictionary *)fileInfo
{
    self.choosedFileInfo = [fileInfo mutableCopy];
    [self popToRootViewControllerAnimated:YES];
    self.skyDriveModel.delegate = self;
    [self.skyDriveModel getSharedLink:fileInfo[@"id"]];
}

- (void)canceled
{
   [self.delegate skyDriverChooserCanceled:self];
}




#pragma mark - SkyDrive delegate



- (void)willLoadData
{
    self.vOverlay.hidden = NO;
    [self.activityIndicatorView startAnimating];
}



- (void)didLoadData
{
    self.vOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}



- (void)didLoadPublicLink:(NSString *)link
{
    if (self.choosedFileInfo)
    {
        self.choosedFileInfo[@"public_link"] = link;
        [self.delegate skyDriveChooser:self fileChoosed:self.choosedFileInfo];
    }
}

- (void)authOrOperationCanceled
{
    [self.delegate skyDriverChooserCanceled:self];
}


@end
