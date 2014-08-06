//
//  SkyDriveChooser.h
//  skyDriveExample
//
//  Created by Kirill on 05.08.14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCFolderTable.h"
#import "SkyDriveModel.h"

@class SkyDriveChooser;


@protocol  SkyDriveChooserDelegate
    -(void)skyDriveChooser:(SkyDriveChooser *)skyDriveChooser fileChoosed:(NSDictionary *)fileInfo;
    -(void)skyDriverChooserCanceled:(SkyDriveChooser *)skyDriveChooser;
@end


@interface SkyDriveChooser : UINavigationController <VCFolderTableDelegate, SkyDriveModelDelegate>
@property (nonatomic, strong) VCFolderTable *vcFolderTable;
@property (nonatomic, strong) SkyDriveModel *skyDriveModel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) id <SkyDriveChooserDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *choosedFileInfo;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) UIView *vOverlay;



- (id)initWithClientId:(NSString *)appId;
@end
