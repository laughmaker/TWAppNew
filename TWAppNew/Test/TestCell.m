//
//  TestCell.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    { }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self defaultInit];
}

- (void)defaultInit
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    self.nicknameLbl.font           = kTitleFontMiddle;
    self.nicknameLbl.textColor      = kTitleColorBlack;
    self.contentLbl.font            = kContentFontMiddle;
    self.contentLbl.textColor       = kContentColorHighlight;
    self.thumbnail.backgroundColor   = [UIColor brownColor];
    self.nicknameLbl.backgroundColor = [UIColor clearColor];
    self.contentLbl.backgroundColor  = [UIColor clearColor];
}

- (void)configureCellWithCellDatas:(id)cellDatas
{
    [super configureCellWithCellDatas:cellDatas];
    
    self.nicknameLbl.text  = cellDatas[@"nickname"];
    self.contentLbl.height = [self.class heightForContent:cellDatas[@"content"]];
    self.contentLbl.text   = cellDatas[@"content"];

    NSString *portraintUrl = [NSString stringWithFormat:@"%@%@", kImagePrex, cellDatas[@"avatar"]];
    [self.thumbnail setImageWithURL:[NSURL URLWithString:portraintUrl]];
}

+ (CGFloat)heightForContent:(NSString *)content
{
    CGSize contrainSize = CGSizeMake(210, 1500);
    CGSize size = [content sizeWithFont:kContentFontMiddle constrainedToSize:contrainSize];
    return size.height;
}

+ (CGFloat)cellHeightForCellDatas:(NSDictionary *)cellDatas
{
    CGFloat contentHeight = [self.class heightForContent:cellDatas[@"content"]];
    if (contentHeight < 25)
        return 70;

    return contentHeight + 50;
}


@end
