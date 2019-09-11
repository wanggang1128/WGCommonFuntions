//
//  ViewController.m
//  WGSocketServer
//
//  Created by wanggang on 2019/9/4.
//  Copyright © 2019 wg. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define margin 15

#import "ViewController.h"

@interface ViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) UILabel *portLab;
@property (nonatomic, strong) UITextField *portField;
@property (nonatomic, strong) UIButton *monitorBtn;

@property (nonatomic, strong) UITextField *messageField;
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, strong) UIButton *receiveBtn;
@property (nonatomic, strong) UITextView *contentTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"server";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self createView];
    
    // 1、初始化服务器socket，在主线程力回调
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}


- (void)createView {
    
    [self.view addSubview:self.portLab];
    [self.view addSubview:self.portField];
    [self.view addSubview:self.monitorBtn];
    [self.view addSubview:self.messageField];
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.receiveBtn];
    [self.view addSubview:self.contentTextView];

}


#pragma mark -服务器socket Delegate
- (void)socket:(GCDAsyncSocket*)sock didAcceptNewSocket:(GCDAsyncSocket*)newSocket {
    
    //保存客户端的socket
    self.clientSocket = newSocket;
    
    [self showContent:@"连接成功"];
    [self showContent:[NSString stringWithFormat:@"服务器地址:%@,端口:%d", newSocket.connectedHost, newSocket.connectedPort]];
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}


//收到消息
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self showContent:text];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    
}

//开始监听
- (void)monitorBtnClicked {
    
    //2、开放哪一个端口
    NSError *error = nil;
    BOOL success = [self.serverSocket acceptOnPort:[self.portField.text integerValue] error:&error];

    if (success && error == nil) {
        //开放成功
        [self showContent:[NSString stringWithFormat:@"开放成功,端口:%@", self.portField.text]];
    }
}


//发送消息
- (void)sendBtnClicked {
    
    NSData *data = [self.messageField.text dataUsingEncoding:NSUTF8StringEncoding];
    
    self.messageField.text = @"";
    
    //withTimeout -1:无穷大，一直等
    //tag:消息标记
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}


//接收消息
- (void)receiveBtnClicked {
    
    [self.clientSocket readDataWithTimeout:11 tag:0];
}


- (void)showContent:(NSString *)str {
    
    self.contentTextView.text = [self.contentTextView.text stringByAppendingFormat:@"%@\n", str];
}


#pragma mark - 懒加载
- (UILabel *)portLab {
    if (!_portLab) {
        _portLab = [[UILabel alloc] init];
        _portLab.frame = CGRectMake(margin, 100, 50, 40);
        _portLab.backgroundColor = UIColor.whiteColor;
        _portLab.textColor = UIColor.blackColor;
        _portLab.text = @"端口";
    }
    return _portLab;
}

- (UITextField *)portField {
    if (!_portField) {
        _portField = [[UITextField alloc] init];
        _portField.frame = CGRectMake(_portLab.right+margin, _portLab.top, 100, _portLab.height);
        _portField.text = @"8080";
        _portField.layer.borderWidth = 0.5;
        _portField.layer.borderColor = UIColor.grayColor.CGColor;
        _portField.layer.cornerRadius = 5;
        _portField.layer.masksToBounds = YES;
        _portField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, _portLab.height)];
        _portField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _portField;
}

-(UIButton *)monitorBtn {
    if (!_monitorBtn) {
        _monitorBtn = [[UIButton alloc] initWithFrame:CGRectMake(_portField.right+margin, _portLab.top, 100, _portLab.height)];
        [_monitorBtn setTitle:@"开始监听" forState:UIControlStateNormal];
        [_monitorBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_monitorBtn addTarget:self action:@selector(monitorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _monitorBtn;
}

- (UITextField *)messageField {
    if (!_messageField) {
        _messageField = [[UITextField alloc] init];
        _messageField.frame = CGRectMake(margin, _portLab.bottom+margin, SCREEN_WIDTH*2/3, _portLab.height);
        _messageField.layer.borderWidth = 0.5;
        _messageField.layer.borderColor = UIColor.grayColor.CGColor;
        _messageField.layer.cornerRadius = 5;
        _messageField.layer.masksToBounds = YES;
        _messageField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, _portLab.height)];
        _messageField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _messageField;
}

-(UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(_messageField.right+margin, _messageField.top, 100, _portLab.height)];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

-(UIButton *)receiveBtn {
    if (!_receiveBtn) {
        _receiveBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, _sendBtn.bottom+margin, 100, _portLab.height)];
        [_receiveBtn setTitle:@"接收消息" forState:UIControlStateNormal];
        [_receiveBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_receiveBtn addTarget:self action:@selector(receiveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _receiveBtn;
}

-(UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(margin, _receiveBtn.bottom+margin, SCREEN_WIDTH-margin*2, SCREEN_HEIGHT-_receiveBtn.bottom-margin)];
        _contentTextView.backgroundColor = UIColor.purpleColor;
        _contentTextView.font = [UIFont systemFontOfSize:18];
    }
    return _contentTextView;
}

@end
