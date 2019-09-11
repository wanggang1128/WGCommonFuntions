//
//  SubViewController.m
//  TestDemo
//
//  Created by 李勇 on 2017/1/4.
//  Copyright © 2017年 aoke. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation SubViewController

//- (instancetype)init{
//    if (self = [super init]){
//        
//    }
//    return self;
//}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"login";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction {

    NSString *account = self.accountTF.text;
    NSString *pwd = self.passwordTF.text;
    
    if ([account isEqualToString:@"liyong"] && [pwd isEqualToString:@"123456"]){
        
        self.navigationItem.title = @"success";
    }else{
        self.navigationItem.title = @"fail";
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
