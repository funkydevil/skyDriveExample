//
// Created by Kirill on 05.08.14.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "SkyDriveModel.h"


@implementation SkyDriveModel

- (id)initWithClientId:(NSString *)clientId andContextVC:(UIViewController *)vc
{
    self = [super init];
    if (self)
    {
        self.clientId = clientId;
        self.contextVC = vc;
        self.liveClient = [[LiveConnectClient alloc] initWithClientId:self.clientId
                                                             delegate:self
                                                            userState:@"initilize"];
    }

    return self;
}



-(void)dealloc
{
    NSLog(@"SkyDriveModel dealloc");
}




- (void)authCompleted:(LiveConnectSessionStatus)status session:(LiveConnectSession *) session userState:(id) userState
{
    if ([userState isEqual:@"initilize"])
    {
        [self.liveClient login:self.contextVC scopes:[NSArray arrayWithObjects:@"wl.signin",@"wl.skydrive",@"wl.offline_access", nil] delegate:self userState:@"signin"];
    }



    if ([userState isEqual:@"signin"])
    {
        if (session != nil)
        {
            [self getRootFolder];
        }

    }
}

- (void)authFailed:(NSError *) error userState:(id)userState
{
    [self.delegate authOrOperationCanceled];
}



-(void)getRootFolder
{
    [self.delegate willLoadData];
    [self.liveClient getWithPath:@"me/skydrive/files" delegate:self userState:@"getRootFolder"];
}


-(void)getFolderWithId:(NSString *)folderId
{
    [self.delegate willLoadData];
    [self.liveClient getWithPath:[NSString stringWithFormat:@"%@/files", folderId] delegate:self userState:@"getFolder"];
}



-(void)getSharedLink:(NSString *)folderId
{
    [self.delegate willLoadData];
    [self.liveClient getWithPath:[NSString stringWithFormat:@"%@/shared_read_link", folderId] delegate:self userState:@"getSharedLink"];
}




-(void)liveOperationSucceeded:(LiveOperation *)operation
{
    [self.delegate didLoadData];

    if ([operation.userState isEqualToString:@"getRootFolder"])
    {
        [self.delegate didLoadRootFolderData:operation.result[@"data"]];
    }
    else if ([operation.userState isEqualToString:@"getFolder"])
    {
        NSString *folderId = [operation.path substringToIndex:[operation.path rangeOfString:@"/files"].location];
        [self.delegate didlLoadFolderWithId:folderId data:operation.result[@"data"]];
    }
    else if ([operation.userState isEqualToString:@"getSharedLink"])
    {
        [self.delegate didLoadPublicLink:operation.result[@"link"]];
    }
}




-(void)liveOperationFailed:(NSError *)error operation:(LiveOperation *)operation
{
    if ([operation.userState isEqual:@"getFolder"])
    {
        NSLog(@"ERROR");
    };
    [self.delegate authOrOperationCanceled];
}



@end