//
//  NSString+ZXExtension.m
//  TopHot
//
//  Created by Liushannoon on 15/12/23.
//  Copyright © 2015年 Liushannoon. All rights reserved.
//

#define kLineSpacing 5
#define kKernSpacing 5

#import "NSString+ZXExtension.h"

@implementation NSString (ZXExtension)

#pragma mark    -   文本处理相关 ,例如:文本高度宽度计算

/**
 *  返回符合条件的文本的高度
 *
 *  @param font       文本字体大小
 *  @param sizeWidth  文本范围的宽度,根据这个宽度和文本内容,计算高度
 *  @param kernSpace  字体间距 , 0
 *  @param lineSpace  行间距 , 6
 *  @param expandDict 预留参数
 *
 *  @return 高度
 */
- (CGFloat)zx_stringHeightWithFontOfSize:(NSInteger)font sizeWidth:(CGFloat)sizeWidth lineSpace:(CGFloat)lineSpace kernSpace:(CGFloat)kernSpace expand:(NSDictionary *)expandDict
{
    /**
     *   方法一:
     */
    CGSize maxSize = CGSizeMake(sizeWidth, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; //调整行间距
    // 计算文字的高度
    CGFloat textH1 = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font],NSParagraphStyleAttributeName : paragraphStyle , NSKernAttributeName : @(kernSpace)} context:nil].size.height;
    /**
     *  方法二:
     */
    //    CGFloat textH = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(sizeWidth, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height;
    //    CGFloat textH2 = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(sizeWidth, MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap].height;
    //    CGFloat textH3 = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(sizeWidth, MAXFLOAT) lineBreakMode:UILineBreakModeClip].height;
    //    CGFloat textH4 = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(sizeWidth, MAXFLOAT) lineBreakMode:UILineBreakModeHeadTruncation].height;
    //    CGFloat textH5 = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(sizeWidth, MAXFLOAT) lineBreakMode:UILineBreakModeTailTruncation].height;
    //    CGFloat textH6 = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(sizeWidth, MAXFLOAT) lineBreakMode:UILineBreakModeMiddleTruncation].height;
    //
    //    ZXLog(@"textH1 == %f  --   textH == %f  textH2 == %f  textH3 == %f  textH4 == %f  textH5 == %f  textH6 == %f",textH1,textH,textH2,textH3,textH4,textH5,textH6);
    
    return ceil(textH1);
}
- (CGFloat)zx_stringWidthWithFontOfSize:(NSInteger)fontSize sizeHeight:(CGFloat)sizeHeight lineSpace:(CGFloat)lineSpace kernSpace:(CGFloat)kernSpace  Expand:(NSDictionary *)expandDict
{
    CGSize maxSize = CGSizeMake(MAXFLOAT, sizeHeight);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; //调整行间距
    CGFloat textWidth = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName : paragraphStyle , NSKernAttributeName : @(kernSpace)} context:nil].size.width;
    
    return ceil(textWidth);
}
- (CGFloat)zx_stringHeightWithFontOfSize:(NSInteger)font sizeWidth:(CGFloat)sizeWidth
{
    CGSize maxSize = CGSizeMake(sizeWidth, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6; //调整行间距
    // 计算文字的高度
    CGFloat textH1 = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font],NSParagraphStyleAttributeName : paragraphStyle , NSKernAttributeName : @(0)} context:nil].size.height;
    return ceil(textH1);
}

#pragma mark    -   日期相关方法

/**
 *  一个时间戳字符串,调用这个方法,返回去一个2015-11-24 20:57:38格式的日期
 *
 *  @param timeInterval 从1970年开始的时间戳
 *
 *  @return 返回去的是一个2015-11-24 20:57:38格式的的时间字符串
 */
- (NSString *)zx_dateString
{
    return  [self zx_dateStringWithDateFormatType:ZXDateForMatTypeyyyyMMddHHmmss];
}
/**
 *  对时间戳字符串进行指定格式的转换,返回一个指定格式的日期时间字符串
 *
 *  @param dateFormatType 参数是dateFormatType类型
 *
 *  @return 返回去的是一个指定时间格式的的时间字符串
 */
- (NSString *)zx_dateStringWithDateFormatType:(ZXDateForMatType)dateFormatType
{
    
    NSInteger timeInterval = [self integerValue];
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    switch (dateFormatType) {
        case ZXDateForMatTypeyyyyMMddHHmmss:
        {
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
            break;
        case ZXDateForMatTypeyyyyMMdd:
        {
            fmt.dateFormat = @"yyyy-MM-dd";
        }
            break;
        case ZXDateForMatTypeMMdd:
        {
            fmt.dateFormat = @"MM-dd";
        }
            break;
        case ZXDateForMatTypeHHmm:
        {
            fmt.dateFormat = @"HH:mm";
        }
            break;
        case ZXDateForMatTypeMMddInChinese:
        {
            fmt.dateFormat = @"MM月dd日";
        }
            break;
            
        default:
            break;
    }
    // 帖子的创建时间
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    // 日期字符串
    NSString *dateString = [fmt stringFromDate:create];
    return dateString;
}

/**
 *  时间戳字符串转NSDate对象
 *
 *  @return 返回NSDate对象
 */
- (NSDate *)zx_date
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.integerValue];
    return date;
}

/**
 *  根据时间间距,动态调整时间
 */
- (NSString *)zx_customDateString
{
    // 帖子的创建时间
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:self.integerValue];
    if (create.zx_isThisYear) { // 今年
        if (create.zx_isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] zx_deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.zx_isYesterday) { // 昨天
            return [self zx_dateStringWithDateFormatType:ZXDateForMatTypeyyyyMMdd];
        } else { // 其他
            return [self zx_dateStringWithDateFormatType:ZXDateForMatTypeyyyyMMdd];
        }
    } else { // 非今年
        return [self zx_dateStringWithDateFormatType:ZXDateForMatTypeyyyyMMdd];
    }
}

/**
 *  对日期格式的字符串转化为时间戳
 *
 *  @param dateFormat 日期格式
 *
 *  @return 时间戳
 */
- (NSTimeInterval)zx_timeIntervalDateFormat:(ZXDateForMatType)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (dateFormat) {
        case ZXDateForMatTypeyyyyMMddHHmmss:
        {
            dateFormatter.dateFormat =  @"yyyy-MM-dd HH:mm:ss";
            
        }
            break;
        case ZXDateForMatTypeyyyyMMdd:
        {
            dateFormatter.dateFormat =  @"yyyy-MM-dd";
        }
            break;
        default:
        {
            dateFormatter.dateFormat =  @"yyyy-MM-dd HH:mm:ss";
        }
            break;
    }
    NSDate *date = [dateFormatter dateFromString:self];
    return [date timeIntervalSince1970];
}

#pragma mark    -   图文混排

/**
 *  生成一个文字和图片混合的富文本字符串
 *
 *  @param title        文本
 *  @param titleColor   文本颜色
 *  @param titleFont    文本字体大小
 *  @param image        图片
 *  @param isTitleFirst 图片在前还是文字在前
 *
 *  @return 图文混排的富文本
 */
+ (NSAttributedString *)zx_titleAndImageAttributedStringWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)titleFont alignment:(NSTextAlignment)alignment image:(UIImage *)image isTitleFirst:(BOOL)isTitleFirst
{
    // 1. 文字部分变富文本
    NSMutableAttributedString *textAttributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = kLineSpacing; //调整行间距
    paragraphStyle.alignment = alignment;
    [textAttributedString addAttributes:@{NSForegroundColorAttributeName :titleColor , NSFontAttributeName :[UIFont systemFontOfSize:titleFont]} range:NSMakeRange(0, title.length)];
    
    // 2. 表情富文本
    NSTextAttachment *attchment = [[NSTextAttachment alloc] init];
    // 表情图片
    attchment.image = image;
    // 设置图片大小
    attchment.bounds = CGRectMake(0, 0, titleFont, titleFont);
    NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:attchment];
    NSMutableAttributedString *textAndAttachmentAttributedString = nil;
    
    // 3.拼接
    if (!isTitleFirst) {
        textAndAttachmentAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:imageAttributedString];
        [textAndAttachmentAttributedString appendAttributedString:textAttributedString];
    } else {
        textAndAttachmentAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:textAttributedString];
        [textAndAttachmentAttributedString appendAttributedString:imageAttributedString];
    }
    return textAndAttachmentAttributedString;
}
/**
 *  返回指定格式的富文本字符串
 *
 *  @param fontSize 字体size
 *
 *  @return 富文本字符串
 */
- (NSMutableAttributedString *)zx_formatAttributedStringWithFontOfSize:(NSInteger)fontSize
{
    return [self zx_formatAttributedStringWithFontOfSize:fontSize lineSpace:kLineSpacing kernSpace:kKernSpacing color:[UIColor blackColor]];
}

- (NSMutableAttributedString *)zx_formatAttributedStringWithFontOfSize:(NSInteger)fontSize lineSpace:(CGFloat)lineSpace kernSpace:(CGFloat)kernSpace color:(UIColor *)color
{
    if (self ==nil || self.length <= 0) return nil;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; //调整行间距
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSKernAttributeName value:@(kernSpace) range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    
    return attributedString;
}

#pragma mark    -   other

/**
 *  是否为中文
 */
+ (NSString *)isChineseLanguage
{
    NSString *language = [NSLocale preferredLanguages][0];
    if ( [language rangeOfString:@"zh-"].length>0)
    {
        NSString *isChinese = [NSString stringWithFormat:@"0"];
        return isChinese;
    }else if([language rangeOfString:@"cs-"].length>0){
        
        NSString *csLanguage = [NSString stringWithFormat:@"2"];
        return csLanguage;
    }
    else
    {
        NSString *notChinese = [NSString stringWithFormat:@"1"];
        return notChinese;
    }
}

- (BOOL)zx_containsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark    -   正则匹配相关

/**
 匹配是否全是数字
 
 @return yes表示字符串全是0-9数字组成,反之为NO
 */
- (BOOL)zx_checkAllNumber
{
    NSString *nicknameRegex = @"^[0-9]*$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}
@end
