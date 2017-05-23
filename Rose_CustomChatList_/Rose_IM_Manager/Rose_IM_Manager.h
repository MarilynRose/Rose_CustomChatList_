//
//  Rose_IM_Manager.h
//  Rose_customChatList
//
//  Created by Marilyn_Rose on 2017/5/17.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RongIMLib.h>

@protocol Rose_RongYunMessageDelegate <NSObject>
@optional
- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object;
@end

@interface Rose_IM_Manager : NSObject<RCIMClientReceiveMessageDelegate>

@property(nonatomic,assign) id<Rose_RongYunMessageDelegate> messageDelegate;

+(Rose_IM_Manager *)sharedManager;


/*!
 加入聊天室
 
 @param targetId                聊天室ID
 @param messageCount            进入聊天室时获取历史消息的数量，-1<=messageCount<=50
 @param successBlock            加入聊天室成功的回调
 @param errorBlock              加入聊天室失败的回调 [status:加入聊天室失败的错误码]
 
 @discussion 可以通过传入的messageCount设置加入聊天室成功之后，需要获取的历史消息数量。
 -1表示不获取任何历史消息，0表示不特殊设置而使用SDK默认的设置（默认为获取10条），0<messageCount<=50为具体获取的消息数量,最大值为50。
 */
- (void)joinChatRoom:(NSString *)targetId
        messageCount:(int)messageCount
             success:(void (^)())successBlock
               error:(void (^)(RCErrorCode status))errorBlock;

/*!
 退出聊天室
 
 @param targetId                聊天室ID
 @param successBlock            退出聊天室成功的回调
 @param errorBlock              退出聊天室失败的回调 [status:退出聊天室失败的错误码]
 */
- (void)quitChatRoom:(NSString *)targetId
             success:(void (^)())successBlock
               error:(void (^)(RCErrorCode status))errorBlock;


-(RCTextMessage *)messageWithContent:(NSString *)str senderName:(NSString *)name;


- (void)sendMessage:(RCConversationType)conversationType
                  targetId:(NSString *)targetId
                   content:(RCMessageContent *)content
                   success:(void (^)(long messageId))successBlock
                     error:(void (^)(RCErrorCode nErrorCode,
                                     long messageId))errorBlock;

// 设置消息接收监听
- (void)setReceiveMessageDelegate;

//取消监听
- (void)removeReceiveMesDelegate;

/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param nLeft       还剩余的未接收的消息数，left>=0
 @param object      消息监听设置的key值
 
 @discussion 如果您设置了IMlib消息监听之后，SDK在接收到消息时候会执行此方法。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 object为您在设置消息接收监听时的key值。
 */
- (void)onReceived:(RCMessage *)message
              left:(int)nLeft
            object:(id)object;

@end
