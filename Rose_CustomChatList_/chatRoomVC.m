//
//  chatRoomVC.m
//  Rose_CustomChatList_
//
//  Created by Marilyn_Rose on 2017/5/18.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "chatRoomVC.h"
#import "Rose_IM_Manager.h"
#import "Rose_ChatRoomView.h"

#define myName @"隔壁老王"
@interface chatRoomVC ()

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)Rose_ChatRoomView *chatRoom;

@end

@implementation chatRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    _chatRoom = [[Rose_ChatRoomView alloc]initWithFrame:CGRectMake(10, 74, 200, 200)];
    [self.view addSubview:_chatRoom];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField= [[UITextField alloc]initWithFrame:CGRectMake(100, 300, 200, 40)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"请输入聊天信息";
    [self.view addSubview:self.textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 350, 200, 30);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendMes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [[Rose_IM_Manager sharedManager]joinChatRoom:self.roomID messageCount:-1 success:^{
        [[Rose_IM_Manager sharedManager]setReceiveMessageDelegate];
    } error:^(RCErrorCode status) {
        
    }];
    
    
    
}

-(void)sendMes{
    if (![self.textField.text isEqualToString:@""]) {
        [[Rose_IM_Manager sharedManager]sendMessage:ConversationType_CHATROOM targetId:self.roomID content:[[Rose_IM_Manager sharedManager] messageWithContent:self.textField.text senderName:myName] success:^(long messageId) {
            
            [_chatRoom sendSuccessUpdateUI:self.textField.text];
            
        } error:^(RCErrorCode nErrorCode, long messageId) {
            
        }];
    }else{
        NSLog(@"请输入聊天内容！");
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[Rose_IM_Manager sharedManager]quitChatRoom:self.roomID success:^{
        [[Rose_IM_Manager sharedManager]removeReceiveMesDelegate];
    } error:^(RCErrorCode status) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
