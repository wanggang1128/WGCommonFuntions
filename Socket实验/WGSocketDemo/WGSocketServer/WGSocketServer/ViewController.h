//
//  ViewController.h
//  WGSocketServer
//
//  Created by wanggang on 2019/9/4.
//  Copyright © 2019 wg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WGFrame.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface ViewController : UIViewController

//服务器socket（开放端口，监听客户端socket的链接）
@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
//保护客户端socket
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

