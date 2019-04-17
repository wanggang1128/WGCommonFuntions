//
//  ViewController.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#define WGHeight [UIScreen mainScreen].bounds.size.height
#define WGWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "WGMsgSend.h"
#import "Person.h"
#import "MsgZFPerson.h"
#import "WGAddClass.h"
#import "PersonModel.h"
#import "CPerson.h"
#import "CPerson+Associate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSString *temPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBaseView];
    [self.view addSubview:self.tableView];
}

- (void)setBaseView{
    self.title = @"Runtime测试";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    NSInteger row = indexPath.row;
    if (row < self.dataArr.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = _dataArr[row];
        return cell;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self alertView:[WGMsgSend wgMsgSendTest]];
            break;
        }
        case 1:{
            Person *per = [[Person alloc] init];
            per.name = @"寒江";
            per.age = 18;
            per.school = @"哈哈高中";
            per.height = 179;
            NSString *filePath = [self.temPath stringByAppendingPathComponent:@"hanjiang.han"];
            [NSKeyedArchiver archiveRootObject:per toFile:filePath]? [self alertView:@"归档成功"]: [self alertView:@"归档失败"];
            break;
        }
        case 2:{
            NSString *filePath = [self.temPath stringByAppendingPathComponent:@"hanjiang.han"];
            Person *per = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            [self alertView:[NSString stringWithFormat:@"解档成功:%@同学、身高%d、今年%d岁了、在%@上学!", per.name, per.height, per.age, per.school]];
            break;
        }
        case 3:{
            NSURL *url01 = [NSURL URLWithString:@"http://www.baidu.com/中文"];
            NSURL *url02 = [NSURL URLWithString:@"6666"];
            NSURL *url03 = [NSURL URLWithString:@"http://www.baidu.com"];
            [self alertView:[NSString stringWithFormat:@"URL含有中文:%@,没有http：%@、正确格式:%@", url01, url02, url03]];
            break;
        }
        case 4:{
            MsgZFPerson *zfPer = [[MsgZFPerson alloc] init];
            [self alertView:[zfPer performSelector:@selector(msgsendTest:) withObject:@"消息转发第二步偷梁换柱"]];
            break;
        }
        case 5:{
            WGAddClass *add = [[WGAddClass alloc] init];
            [self alertView:[add addClassTest]];
            break;
        }
        case 6:{
            CPerson * cp = [[CPerson alloc] init];
            cp.name = @"王";
            cp.age = 12;
            [cp setValue:@"老师" forKey:@"occupation"];
            cp.height = @(165);
            cp.associatedCallback = ^{
                NSLog(@"CPerson分类中的block");
            };
            cp.associatedCallback();
            NSDictionary *allPropertyDic = [cp allProperties];
            NSDictionary *allIvarDic = [cp allIvars];
            NSDictionary *allMethodDic = [cp allMethods];
            [self alertView:[NSString stringWithFormat:@"属性字典:%@\n成员变量字典:%@\n对象方法字典:%@",allPropertyDic, allIvarDic, allMethodDic]];
            for (NSString *key in [allPropertyDic allKeys]) {
                NSLog(@"属性字典中,键:%@,值:%@", key, [allPropertyDic valueForKey:key]);
            }
            for (NSString *key in [allIvarDic allKeys]) {
                NSLog(@"成员变量字典中,键:%@,值:%@", key, [allIvarDic valueForKey:key]);
            }
            for (NSString *key in [allMethodDic allKeys]) {
                NSLog(@"对象方法字典中,键:%@,值:%@", key, [allMethodDic valueForKey:key]);
            }
            break;
        }
        case 7:{
            NSDictionary *dic = @{@"name":@"寒江",
                                  @"age":@18,
                                  @"occupation":@"老师",
                                  @"captionality":@"中国"
                                  };
            //字典转模型
            PersonModel *dp = [[PersonModel alloc] initWithDictionary:dic];
//            [self alertView:[NSString stringWithFormat:@"%@今年%@岁在%@做%@！",dp.name, dp.age, dp.captionality, dp.occupation]];
            //模型转字典
            NSDictionary *newDic = [dp convertToDictionary];
                        [self alertView:[NSString stringWithFormat:@"runtime模型转字典%@", newDic]];
            break;
        }
        default:
            break;
    }
}


- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithObjects:@"objc_msgSend", @"归档", @"解档", @"方法交换", @"消息转发", @"动态添加类，为类添加对象方法，成员变量", @"分类中不能直接添加属性的原因和探索", @"runtime实现字典和模型之间的相互转换", nil];
    }
    return _dataArr;
}

//这里我就不做适配了
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WGWidth, WGHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (NSString *)temPath{
    if (!_temPath) {
        _temPath = NSTemporaryDirectory();
        NSLog(@"归档缓存路径前缀为:%@",_temPath);
    }
    return _temPath;
}

- (void)alertView:(NSString *)msgStr{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"运行结果" message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
