//
//  WGLoginViewController.m
//  WGSignInWithAppleDemo
//
//  Created by wanggang on 2019/9/25.
//  Copyright © 2019 wg. All rights reserved.
//

#import "WGLoginViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface WGLoginViewController ()<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) UITextView *appleIDInfoTextView;

@end

@implementation WGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ViewController";
    
    if (@available(iOS 13.0, *)) {
        [self observeAppleSignInState];
        [self createView];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self perfomExistingAccountSetupFlows];
}

//添加苹果登录的状态通知
/**
 在 App 使用过程中，你还可以通过通知方法来监听 revoked 状态，可以添加 ASAuthorizationAppleIDProviderCredentialRevokedNotification 这个通知，收到这个通知的时候，我们可以：

 ∙ Sign user out on this device
 ∙ Guide to sign in again
 具体怎么添加和处理，可以根据业务需求来决定。
 */
- (void)observeAppleSignInState {
    if (@available(iOS 13.0, *)) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    }
}

// 观察SignInWithApple状态改变
- (void)handleSignInWithAppleStateChanged:(id)noti {
    
    NSLog(@"%@", noti);
}

- (void)createView {
    
    [self.view addSubview:self.appleIDInfoTextView];
    
    if (@available(iOS 13.0, *)) {
        
        ASAuthorizationAppleIDButton *appleIDButton = [[ASAuthorizationAppleIDButton alloc] init];
        appleIDButton.frame = CGRectMake(50, 100+CGRectGetHeight(self.view.frame) * 0.4, CGRectGetWidth(self.view.frame)-100, 50);
        [appleIDButton addTarget:self action:@selector(appleIDButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:appleIDButton];
    }
}


// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
/**
 苹果还把 iCloud KeyChain password 集成到了这套 API 里，我们在使用的时候，只需要在创建 request 的时候，多创建一个 ASAuthorizationPasswordRequest，这样如果 KeyChain 里面也有登录信息的话，可以直接使用里面保存的用户名和密码进行登录
 */
- (void)perfomExistingAccountSetupFlows {
    if (@available(iOS 13.0, *)) {
                
        // 授权请求依赖于用于的AppleID
        ASAuthorizationAppleIDRequest *authAppleIDRequest = [[ASAuthorizationAppleIDProvider new] createRequest];
        
        // 为了执行钥匙串凭证分享生成请求的一种机制
        ASAuthorizationPasswordRequest *passwordRequest = [[ASAuthorizationPasswordProvider new] createRequest];
        
        NSMutableArray <ASAuthorizationRequest *> *mArr = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [mArr addObject:authAppleIDRequest];
        }
        if (passwordRequest) {
            [mArr addObject:passwordRequest];
        }
        
        // ASAuthorizationRequest：对于不同种类授权请求的基类
        NSArray <ASAuthorizationRequest *> *requests = [mArr copy];
        
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }
}

- (void)appleIDButtonClicked API_AVAILABLE(ios(13.0)) {
    
    //基于用户的Apple ID授权用户，生成用户授权请求的一种机制
    ASAuthorizationAppleIDProvider *provide = [[ASAuthorizationAppleIDProvider alloc] init];
    //创建新的AppleID 授权请求
    ASAuthorizationAppleIDRequest *request = provide.createRequest;
    //在用户授权期间请求的联系信息
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    //由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
    ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    //设置授权控制器通知授权请求的成功与失败的代理
    controller.delegate = self;
    //设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
    controller.presentationContextProvider = self;
    //在控制器初始化期间启动授权流
    [controller performRequests];
}


#pragma mark - ASAuthorizationControllerDelegate
//授权成功的回调
/**
 当授权成功后，我们可以通过这个拿到用户的 userID、email、fullName、authorizationCode、identityToken 以及 realUserStatus 等信息。
 */
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        //苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString *userId = credential.user;
        NSString *state = credential.state;
        NSPersonNameComponents *fullName = credential.fullName;
        //苹果用户信息，邮箱
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        /**
         验证数据，用于传给开发者后台服务器，然后开发者服务器再向苹果的身份验证服务端验证本次授权登录请求数据的有效性和真实性，详见 Sign In with Apple REST API。如果验证成功，可以根据 userIdentifier 判断账号是否已存在，若存在，则返回自己账号系统的登录态，若不存在，则创建一个新的账号，并返回对应的登录态给 App。
         */
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        /**
         用于判断当前登录的苹果账号是否是一个真实用户
         取值有：unsupported、unknown、likelyReal。
         */
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        //  需要使用钥匙串的方式保存用户的唯一信息 这里暂且处于测试阶段 是否的NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"ShareCurrentIdentifier"];
        
        _appleIDInfoTextView.text = [NSString stringWithFormat:@"%@",credential];
        
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;
        
        _appleIDInfoTextView.text = [NSString stringWithFormat:@"%@",passwordCredential];
        
    } else {
        
    }
}

//失败的回调
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    
    NSString *errorMsg = nil;
    
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    
    _appleIDInfoTextView.text = [NSString stringWithFormat:@"%@",errorMsg];
}

#pragma mark - ASAuthorizationControllerPresentationContextProviding
//告诉代理应该在哪个window 展示授权界面给用户
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    
    return self.view.window;
}

-(UITextView *)appleIDInfoTextView {
    
    if (!_appleIDInfoTextView) {
        _appleIDInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(.0, 100.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) * 0.4) textContainer:nil];
        _appleIDInfoTextView.font = [UIFont systemFontOfSize:20.0];
    }
    return _appleIDInfoTextView;
}

@end
