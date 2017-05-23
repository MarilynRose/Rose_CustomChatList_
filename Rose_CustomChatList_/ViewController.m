//
//  ViewController.m
//  Rose_CustomChatList_
//
//  Created by Marilyn_Rose on 2017/5/18.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "ViewController.h"
#import "chatRoomVC.h"

@interface ViewController ()
@property(nonatomic,strong)UITextField *textF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textF = [[UITextField alloc]initWithFrame:CGRectMake(120, 200, 120, 30)];
    self.textF.borderStyle = UITextBorderStyleRoundedRect;
    self.textF.placeholder = @"请输入房间号";
    self.textF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(120, 300, 120, 30);
    [btn setTitle:@"进入聊天室" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)click{
    chatRoomVC *vc = [[chatRoomVC alloc]init];
    vc.roomID = self.textF.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
