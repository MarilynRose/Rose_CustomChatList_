//
//  Rose_IM_Manager.m
//  Rose_customChatList
//
//  Created by Marilyn_Rose on 2017/5/17.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "Rose_IM_Manager.h"

@implementation Rose_IM_Manager


+(Rose_IM_Manager *)sharedManager{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        
        _sharedObject = [[Rose_IM_Manager alloc] init];
        
    });
    
    
    return _sharedObject;
}

- (void)joinChatRoom:(NSString *)targetId
        messageCount:(int)messageCount
             success:(void (^)())successBlock
               error:(void (^)(RCErrorCode status))errorBlock{
    
    [[RCIMClient sharedRCIMClient]joinChatRoom:targetId messageCount:messageCount success:^{
        successBlock();
    } error:^(RCErrorCode status) {
        errorBlock(status);
    }];

}

- (void)quitChatRoom:(NSString *)targetId
             success:(void (^)())successBlock
               error:(void (^)(RCErrorCode status))errorBlock{
    [[RCIMClient sharedRCIMClient]quitChatRoom:targetId success:^{
        successBlock();
    } error:^(RCErrorCode status) {
        errorBlock(status);
    }];
}

-(RCTextMessage *)messageWithContent:(NSString *)str senderName:(NSString *)name{
    // 构建消息的内容，这里以文本消息为例。
    RCTextMessage *testMessage = [RCTextMessage messageWithContent:str];
    testMessage.senderUserInfo.name = name;
    return testMessage;
}

- (void)sendMessage:(RCConversationType)conversationType
                  targetId:(NSString *)targetId
                   content:(RCMessageContent *)content
                   success:(void (^)(long messageId))successBlock
                     error:(void (^)(RCErrorCode nErrorCode,
                                     long messageId))errorBlock{

    [[RCIMClient sharedRCIMClient]sendMessage:conversationType targetId:targetId content:content pushContent:nil pushData:nil success:^(long messageId) {
        successBlock(messageId);
    } error:^(RCErrorCode nErrorCode, long messageId) {
        errorBlock(nErrorCode,messageId);
    }];

}

-(void)setReceiveMessageDelegate{
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
}

- (void)removeReceiveMesDelegate{
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:nil object:nil];
}


- (void)onReceived:(RCMessage *)message
              left:(int)nLeft
            object:(id)object {
    
    if ([self.messageDelegate respondsToSelector:@selector(onReceived:left:object:)]) {
        [self.messageDelegate onReceived:message left:nLeft object:object];
    }
    
}
@end
