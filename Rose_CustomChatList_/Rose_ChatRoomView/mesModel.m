//
//  mesModel.m
//  Rose_CustomChatList_
//
//  Created by Marilyn_Rose on 2017/5/24.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "mesModel.h"

@implementation mesModel

-(instancetype)initWithMessage:(NSString *)message fontSize:(UIFont *)fontSize width:(CGFloat)width height:(CGFloat)height{
    if (self = [super init]) {
        self.message = message;
        CGFloat length = [self labelAutoCalculateRectWith:message FontSize:fontSize.pointSize MaxSize:CGSizeMake(MAXFLOAT, height)].width;
        int rowsCount = ceil(length/width);

        self.cellHeightFloat = height*rowsCount;
    }
    return self;
}

-(CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}
@end
