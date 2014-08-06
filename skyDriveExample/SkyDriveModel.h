//
// Created by Kirill on 05.08.14.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiveSDK/LiveConnectClient.h>


@protocol SkyDriveModelDelegate
    -(void)willLoadData;
    -(void)didLoadData;

@optional
    -(void)didlLoadFolderWithId:(NSString *)folderId data:(NSArray *)arrData;
    -(void)didLoadRootFolderData:(NSArray *)arrData;
    -(void)didLoadPublicLink:(NSString *)link;
    -(void)authOrOperationCanceled;
@end

@interface SkyDriveModel : NSObject <LiveAuthDelegate, LiveOperationDelegate>

@property (nonatomic, strong) NSString *clientId;
@property (strong, nonatomic) LiveConnectClient *liveClient;
@property (strong, nonatomic) UIViewController *contextVC;
@property (weak, nonatomic) id <SkyDriveModelDelegate> delegate;


- (id)initWithClientId:(NSString *)clientId andContextVC:(UIViewController *)vc;


- (void)getFolderWithId:(NSString *)folderId;

- (void)getSharedLink:(NSString *)folderId;
@end