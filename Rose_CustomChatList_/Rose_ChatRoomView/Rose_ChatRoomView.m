//
//  Rose_ChatRoomView.m
//  Rose_CustomChatList_
//
//  Created by Marilyn_Rose on 2017/5/18.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "Rose_ChatRoomView.h"
#import "Rose_TextCell.h"
#import "Rose_IM_Manager.h"
@interface Rose_ChatRoomView()<UITableViewDelegate,UITableViewDataSource,Rose_RongYunMessageDelegate>

@property(nonatomic,strong)UITableView *chatTableView;

@property(nonatomic,strong)NSMutableArray *textDataArrayM;

@end

@implementation Rose_ChatRoomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self initTable:frame];
    }
    return self;
}

-(void)initTable:(CGRect)frame{
    
    self.chatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.chatTableView.backgroundColor = [UIColor redColor];
    self.chatTableView.delegate    = self;
    self.chatTableView.dataSource  = self;
    self.chatTableView.scrollsToTop= NO;
    self.chatTableView.separatorStyle  = NO;
    self.chatTableView.allowsSelection = NO;
    self.chatTableView.showsVerticalScrollIndicator = NO;
    self.chatTableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.chatTableView];
    self.textDataArrayM = [NSMutableArray new];
    
    [self registerCell];
    
    [self registerDelegate];
}

-(void)registerCell{
    [self.chatTableView registerNib:[UINib nibWithNibName:@"Rose_TextCell" bundle:nil] forCellReuseIdentifier:@"textCell"];
}

-(void)registerDelegate{
    [Rose_IM_Manager sharedManager].messageDelegate = self;
}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textDataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *textString = self.textDataArrayM[indexPath.row];
    static NSString *ID = @"textCell";
    Rose_TextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
        cell = [[Rose_TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.mesLabel.text = textString;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

-(void)addReceiveMes{

}

-(void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object{
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        
        NSLog(@"消息内容：%@", testMessage.content);
        [self updateUI:testMessage.content];
        
    }
    
    NSLog(@"还剩余的未接收的消息数：%d", nLeft);
}

-(void)sendSuccessUpdateUI:(NSString *)message{
    [self updateUI:message];
}

-(void)updateUI:(NSString *)message{
    dispatch_async ( dispatch_get_main_queue (), ^{
        
        NSIndexPath *beforeIndexPath = [NSIndexPath indexPathForRow:self.textDataArrayM.count inSection:0];
        [self.textDataArrayM addObject:message];
        [self.chatTableView beginUpdates];
        [self.chatTableView insertRowsAtIndexPaths:@[beforeIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.chatTableView endUpdates];
        
        NSIndexPath *loadedIndexPath = [NSIndexPath indexPathForRow:self.textDataArrayM.count-1 inSection:0];

        [self.chatTableView scrollToRowAtIndexPath:loadedIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        
    });
}
@end
