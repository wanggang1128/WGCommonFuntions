//
//  ViewController.m
//  TestDemo
//
//  Created by 李勇 on 2016/12/29.
//  Copyright © 2016年 aoke. All rights reserved.
//

#import "ViewController.h"

#import "SubViewController.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationItem.title = @"table";
    
}
//公共方法
- (int)getNum{
    return 100;
}

//私有方法
- (NSString *)privateFuc{
    
    return @"123456";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"HappyNewYear";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 1){
        if (indexPath.row == 0){
            cell.textLabel.text = @"1-0!";
        }else{
            cell.textLabel.text = @"1-x";
        }
    }else{
        if (indexPath.row == 2){
            cell.textLabel.text = @"x-2";
        }else{
            cell.textLabel.text = @"x-x";
        }
    }
    
    
    
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SubViewController *subVC = [board instantiateViewControllerWithIdentifier:@"SubViewController"];
    [self.navigationController pushViewController:subVC animated:YES];
    
}

//私有方法
-(NSInteger)addA:(NSInteger)a b:(NSInteger)b{
    return a+b;
}



@end
