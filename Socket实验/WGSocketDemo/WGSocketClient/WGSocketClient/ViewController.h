//
//  ViewController.h
//  WGSocketClient
//
//  Created by wanggang on 2019/9/4.
//  Copyright © 2019 wg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WGFrame.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

