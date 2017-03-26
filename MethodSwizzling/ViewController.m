//
//  ViewController.m
//  MethodSwizzling
//
//  Created by Code_Hou on 2017/3/26.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"housenkui" forKey:@"name"];
    
    NSString *name = [dict objectForKey:@"name"];
    
    NSLog(@"name = %@",name);
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    
    //如果有categroy 他回去找Categroy的实现
    //真神奇
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
