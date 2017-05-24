//
//  Rose_ChatRoomView.h
//  Rose_CustomChatList_
//
//  Created by Marilyn_Rose on 2017/5/18.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rose_ChatRoomView : UIView

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)UIFont  *fontSize;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)addReceiveMes;

-(void)sendSuccessUpdateUI:(NSString *)message;


@end
