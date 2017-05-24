//
//  mesModel.h
//  Rose_CustomChatList_
//
//  Created by Marilyn_Rose on 2017/5/24.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface mesModel : NSObject

@property(nonatomic,copy)NSString *message;

@property(nonatomic,assign)CGFloat cellHeightFloat;

-(instancetype)initWithMessage:(NSString *)message fontSize:(UIFont *)fontSize width:(CGFloat)width height:(CGFloat)height;

@end
