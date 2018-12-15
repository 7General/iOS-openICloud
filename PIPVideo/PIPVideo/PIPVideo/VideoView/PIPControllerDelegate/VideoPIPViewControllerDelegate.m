//
//  VideoPIPViewControllerDelegate.m
//  PIPVideo
//
//  Created by zzg on 2018/12/15.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "VideoPIPViewControllerDelegate.h"

@implementation VideoPIPViewControllerDelegate

//=========================================
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController failedToStartPictureInPictureWithError:(NSError *)error {
    if (_view.delegate && [_view.delegate respondsToSelector:@selector(pictureInPictureController:failedToStartPictureInPictureWithError:)]) {
        [_view.delegate pictureInPictureController:pictureInPictureController failedToStartPictureInPictureWithError:error];
    }
}


/**
 退出PIP

 @param pictureInPictureController AVPictureInPictureController
 @param completionHandler completionHandler
 */
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    if (_view.delegate && [_view.delegate respondsToSelector:@selector(pictureInPictureController:restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:)]) {
        [_view.delegate pictureInPictureController:pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:completionHandler];
    }
}


/**
 进入PIP

 @param pictureInPictureController AVPictureInPictureController
 */
- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    NSLog(@"=start=====");
    if (_view.delegate && [_view.delegate respondsToSelector:@selector(pictureInPictureControllerDidStartPictureInPicture:)]) {
        [_view.delegate pictureInPictureControllerDidStartPictureInPicture:pictureInPictureController];
    }
}

- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    if (_view.delegate && [_view.delegate respondsToSelector:@selector(pictureInPictureControllerDidStopPictureInPicture:)]) {
        [_view.delegate pictureInPictureControllerDidStopPictureInPicture:pictureInPictureController];
    }
}

- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    if (_view.delegate && [_view.delegate respondsToSelector:@selector(pictureInPictureControllerWillStartPictureInPicture:)]) {
        [_view.delegate pictureInPictureControllerWillStartPictureInPicture:pictureInPictureController];
    }
}

- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    if (_view.delegate && [_view.delegate respondsToSelector:@selector(pictureInPictureControllerWillStopPictureInPicture:)]) {
        [_view.delegate pictureInPictureControllerWillStopPictureInPicture:pictureInPictureController];
    }
}

@end
