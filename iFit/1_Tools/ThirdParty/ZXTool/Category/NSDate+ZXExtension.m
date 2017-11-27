//
//  NSDate+ZXExtension.m
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//
#define ZX_MINUTE	60
#define ZX_HOUR		3600
#define ZX_DAY		86400
#define ZX_WEEK		604800
#define ZX_YEAR		31556926

#import "NSDate+ZXExtension.h"

@implementation NSDate (ZXExtension)

/**
 *  传一个时间戳过来,返回一个yyyy-MM-dd HH:mm:ss 格式的时间
 *
 *  @param timeInterval 从1970年开始的时间戳
 *
 *  @return 返回去的是一个2015-11-24 20:57:38格式的的时间字符串
 */
+ (NSString *)zX_dateStringWithTimeIntervalSince1970:(NSInteger)timeInterval
{
    return [self zX_dateStringWithTimeIntervalSince1970:timeInterval withDateFormatType:ZXDateForMatTypeyyyyMMddHHmmss];
}

+ (NSDateFormatter *)zX_getDateFormatterWithDateFormatType:(ZXDateForMatType)dateFormatType
{
    // 日期格式化类
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    switch (dateFormatType) {
        case ZXDateForMatTypeyyyyMMddHHmmss:
        {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
            break;
        case ZXDateForMatTypeyyyyMMdd:
        {
            dateFormatter.dateFormat = @"yyyy-MM-dd";
        }
            break;
        case ZXDateForMatTypeMMdd:
        {
            dateFormatter.dateFormat = @"MM-dd";
        }
            break;
        case ZXDateForMatTypeHHmm:
        {
            dateFormatter.dateFormat = @"HH:mm";
        }
            break;
        case ZXDateForMatTypeMMddInChinese:
        {
            dateFormatter.dateFormat = @"MM月dd日";
        }
            break;
        case ZXDateForMatTypeMMDDInChineseHHmm:
        {
            dateFormatter.dateFormat = @"MM月dd日 HH:mm";
        }
            break;
        case ZXDateForMatTypeMMddHHmm:
        {
            dateFormatter.dateFormat = @"MM-dd HH:mm";
        }
            break;
        default:
        {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
            break;
    }
    return dateFormatter;
}

/**
 *  传一个时间戳过来,返回一个指定格式的时间字符串
 *
 *  @param timeInterval 从1970年开始的时间戳
 *  @param dateFormatType   时间格式,默认是@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回去的是一个指定时间格式的的时间字符串
 */
+ (NSString *)zX_dateStringWithTimeIntervalSince1970:(NSInteger)timeInterval withDateFormatType:(ZXDateForMatType )dateFormatType
{
    NSDateFormatter *dateFormatter = [self zX_getDateFormatterWithDateFormatType:dateFormatType];
    // 帖子的创建时间
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    // 日期字符串
    NSString *dateString = [dateFormatter stringFromDate:create];
    return dateString;
}

/**
 *  传一个已经格式化的日期字符串,转化为yyyy-MM-dd HH:mm:ss格式的NSDate,然后再转成时间戳
 *
 *  @param dateString 格式化的日期字符串
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)zX_timeIntervalWithDateString:(NSString *)dateString;
{
    return [self zX_timeIntervalWithDateString:dateString withDateFormatType:ZXDateForMatTypeyyyyMMddHHmmss];
}

/**
 *  传一个已经格式化的日期字符串,转化为yyyy-MM-dd HH:mm:ss格式的NSDate,然后再转成时间戳
 *
 *  @param dateString 格式化的日期字符串
 *  @param dateFormatType 对应的日期格式 , 默认是@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转化后的时间戳
 */
+ (NSTimeInterval)zX_timeIntervalWithDateString:(NSString *)dateString withDateFormatType:(ZXDateForMatType)dateFormatType
{
    NSDateFormatter *dateFormatter = [self zX_getDateFormatterWithDateFormatType:dateFormatType];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [date timeIntervalSince1970];
}

/**
 *  计算from到今天的时间差距，返回值是NSDateComponents，可以直接取出各种时间成员
 */
- (NSDateComponents *)zX_deltaFrom:(NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    
    //也可以是self -> 方法调用者，，，这里调用这个方法的事件就是[NSDate date],计算的是from到现在的时间差距
    return  [calendar components:unit fromDate:from toDate:self options:0];
}
/**
 *  判断是否是今年
 */
- (BOOL)zX_isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}
/**
 *  判断是否是今天
 */
- (BOOL)zX_isToday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *selfString = [dateFormatter stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}
/**
 *  判断是否是昨天
 */
- (BOOL)zX_isYesterday
{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 * 返回一个指定年月日的date对象
 */
+ (NSDate *)zX_dateWithDay:(NSUInteger)day month:(NSUInteger)month year:(NSUInteger)year
{
    //  先定义一个遵循某个历法的日历对象
    //    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //  定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setDay:day];
    [dateComponentsForDate setMonth:month];
    [dateComponentsForDate setYear:year];
    
    //  根据设置的dateComponentsForDate获取历法中与之对应的时间点
    //  这里的时分秒会使用NSDateComponents中规定的默认数值，一般为0或1。
    return  [greCalendar dateFromComponents:dateComponentsForDate];
}

/**
 *  快速创建NSDate对象
 */
+ (NSDate *)zX_dateWithYear:(NSUInteger)year
                      Month:(NSUInteger)month
                        Day:(NSUInteger)day
                       Hour:(NSUInteger)hour
                     Minute:(NSUInteger)minute
                     Second:(NSUInteger)second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

/**
 *  获取当天的年月日时间,时分秒为0
 */
+ (NSDate *)zX_currentDayDateOnlyYMD
{
    NSDate *tempDate = [NSDate date];
    tempDate = [self zX_dateWithYear:tempDate.zX_year Month:tempDate.zX_month Day:tempDate.zX_day Hour:0 Minute:0 Second:0];
    return tempDate;
}

/**
 *  把NSDate对象转化成一个包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents对象
 */
- (NSDateComponents *)componentsOfDay;
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
}

/**
 *  获得对应的年份
 */
- (NSUInteger)zX_year
{
    return [self componentsOfDay].year;
}

/**
 *  获得NSDate对应的月份
 */
- (NSUInteger)zX_month
{
    return [self componentsOfDay].month;
}

/**
 *  返回NSDate对应的月份,字符串格式的月份
 */
- (NSString *)zX_monthString
{
    NSString *monthString = nil;
    NSUInteger month = [self zX_month];
    switch (month) {
        case 1:
            monthString = @"一月";
            break;
        case 2:
            monthString = @"二月";
            break;
        case 3:
            monthString = @"三月";
            break;
        case 4:
            monthString = @"四月";
            break;
        case 5:
            monthString = @"五月";
            break;
        case 6:
            monthString = @"六月";
            break;
        case 7:
            monthString = @"七月";
            break;
        case 8:
            monthString = @"八月";
            break;
        case 9:
            monthString = @"九月";
            break;
        case 10:
            monthString = @"十月";
            break;
        case 11:
            monthString = @"十一月";
            break;
        case 12:
            monthString = @"十二月";
            break;
        default:
            break;
    }
    return monthString;
}

- (NSUInteger)zX_day
{
    return [self componentsOfDay].day;
}

- (NSUInteger)zX_hour
{
    return [self componentsOfDay].hour;
}

- (NSUInteger)zX_minute
{
    return [self componentsOfDay].minute;
}

- (NSUInteger)zX_second
{
    return [self componentsOfDay].second;
}

- (NSUInteger)zX_weekday
{
    return [self componentsOfDay].weekday;
}

- (NSUInteger)zX_weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

- (NSDate *)zX_workBeginTime
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:9];
    [components setMinute:30];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)zX_workEndTime
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:18];
    [components setMinute:0];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)zX_oneHourLater
{
    return [NSDate dateWithTimeInterval:3600 sinceDate:self];
}

/**
 *  获得某一天的这个时刻
 */
- (NSDate *)zX_sameTimeOfDate
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:[[NSDate date] zX_hour]];
    [components setMinute:[[NSDate date] zX_minute]];
    [components setSecond:[[NSDate date] zX_second]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/**
 *  创第一个时间过来,判断和调用这个方法的时间是否是同一个天
 *
 *  @param otherDate 要和当前日期比较的日期
 *
 *  @return 返回结果,yes表示同一天
 */
- (BOOL)zX_sameDayWithDate:(NSDate *)otherDate
{
    if (self.zX_year == otherDate.zX_year && self.zX_month == otherDate.zX_month && self.zX_day == otherDate.zX_day) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  传第一个时间过来,判断和调用这个方法的时间是否是同一个周
 *
 *  @param otherDate 要和当前日期比较的日期
 *
 *  @return 返回结果,yes表示同一
 */
- (BOOL)zX_sameWeekWithDate:(NSDate *)otherDate
{
    if (self.zX_year == otherDate.zX_year  && self.zX_month == otherDate.zX_month && self.zX_weekOfDayInYear == otherDate.zX_weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  创第一个时间过来,判断和调用这个方法的时间是否是同一个月
 *
 *  @param otherDate 要和当前日期比较的日期
 *
 *  @return 返回结果,yes表示同一
 */
- (BOOL)zX_sameMonthWithDate:(NSDate *)otherDate
{
    if (self.zX_year == otherDate.zX_year && self.zX_month == otherDate.zX_month) {
        return YES;
    } else {
        return NO;
    }
}

/************************        日历相关的方法         *****************************/

/**
 *  NSDate对象所在的月有几天
 */
- (NSUInteger)zX_numberOfDaysInCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

/**
 *  NSDate对象所在的这个月有几个星期
 */
- (NSUInteger)zX_numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self zX_firstDayOfCurrentMonth] zX_weeklyOrdinality];
    
    NSUInteger days = [self zX_numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

/**
 *  NSDate对象,在星期中的顺序,星期几
 */
- (NSUInteger)zX_weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}

/**
 *  NSDate对象在月份中的第几天
 */
- (NSUInteger)zX_monthlyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
}

/**
 *  NSDate对象所在的月的第一天
 */
- (NSDate *)zX_firstDayOfCurrentMonth
{
    // 开始时间
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

/**
 *  NSDate对象所在的月的最后一天
 */
- (NSDate *)zX_lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self zX_numberOfDaysInCurrentMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

/**
 *  NSDate对象在上个月中的NSDate对象 3.28 -> 2.28
 */
- (NSDate *)zX_dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/**
 *  NSDate对象在下个月中的NSDate对象 , 3.28 -> 4.28
 */
- (NSDate *)zX_dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/**
 *  根据sele,生成一个NSDateComponents对象
 */
- (NSDateComponents *)zX_YMDComponents
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
}

/**
 * NSDate对象所在的星期在这个月中,是第几个星期
 */
- (NSUInteger)zX_weekNumberInCurrentMonth
{
    NSUInteger firstDay = [[self zX_firstDayOfCurrentMonth] zX_weeklyOrdinality];
    NSUInteger weeksCount = [self zX_numberOfWeeksInCurrentMonth];
    NSUInteger weekNumber = 0;
    
    NSDateComponents *c = [self zX_YMDComponents];
    NSUInteger startIndex = [[self zX_firstDayOfCurrentMonth] zX_monthlyOrdinality];
    NSUInteger endIndex = startIndex + (7 - firstDay);
    for (int i = 0; i < weeksCount; ++i) {
        if (c.day >= startIndex && c.day <= endIndex) {
            weekNumber = i;
            break;
        }
        startIndex = endIndex + 1;
        endIndex = startIndex + 6;
    }
    
    return weekNumber;
}
/**
 *  计算当前NSDate对象加上传递过来的days天以后的NSDate值,
 *
 *  @param days 加多少天,可以是负值
 *
 *  @return 加了days天以后的NSDate对象
 */
- (NSDate *)zX_dateByAddingDays:(NSInteger)days
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/**
 *  计算当前NSDate对象加上传递过来的months个月以后的NSDate
 *
 *  @param months 加了多少个月,负数表示向前计算
 *
 *  @return 操作后的对象
 */
- (NSDate *)zX_dateByAddingMonths:(NSInteger)months
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = months;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/**
 * 计算当前NSDate对象加上传递过来的minutes个分以后的NSDate
 *
 *  @param minutes 要加的分钟
 *
 *  @return
 */
- (NSDate *)zX_dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + ZX_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/**
 *  对时间戳字符串进行指定格式的转换,返回一个指定格式的日期时间字符串
 *
 *  @param dateFormatType 参数是dateFormatType类型
 *
 *  @return 返回去的是一个指定时间格式的的时间字符串
 */
- (NSString *)zX_dateStringWithDateFormatType:(ZXDateForMatType)dateFormatType
{
    NSInteger timeInterval = [self timeIntervalSince1970];
    // 日期格式化类
    NSDateFormatter *dateFormatter = [NSDate zX_getDateFormatterWithDateFormatType:dateFormatType];
    // 帖子的创建时间
    NSDate *create = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    // 日期字符串
    NSString *dateString = [dateFormatter stringFromDate:create];
    return dateString;
}

/**
 *  把传过来的字符串日期,转化为指定格式的nsdate,然后再转成时间戳
 *
 *  @param dateString 时间字符串
 *  @param dateFormat 字符串的指定格式 , 默认是@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转化后的时间戳
 */
+ (NSTimeInterval)zX_timeIntervalWithDateString:(NSString *)dateString withDateFormat:(ZXDateForMatType)dateFormatType
{
    NSDateFormatter *dateFormatter = [self zX_getDateFormatterWithDateFormatType:dateFormatType];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [date timeIntervalSince1970];
}


/**
 把一个表示秒的整数 , 转化成对应的时分秒格式字符串
 
 @param second 多少秒
 
 @return 对应的时分秒字符串 eg:  100s   ->  @"00:01:40"
 */
+ (NSString *)zX_HMSStringWithSecond:(NSInteger)second
{
    return [self zX_HMSStringWithSecond:second HMSType:ZXHMSStringTypehhmmss];
}

/**
 把一个表示秒的整数 , 转化成对应的时分秒格式字符串
 
 @param second 多少秒
 
 @return 对应的时分秒字符串 eg:  100s   ->  @"00:01:40"
 */
+ (NSString *)zX_HMSStringWithSecond:(NSInteger)second HMSType:(ZXHMSStringType)HMSType
{
    switch (HMSType) {
        case ZXHMSStringTypehhmmss:
        {
            NSInteger hour = second / 3600;
            NSInteger minute = (second % 3600) / 60;
            NSInteger secondInteger = ((second % 3600) % 60);
            
            NSString *string = [NSString stringWithFormat:@"%02zd:%02zd:%02zd",hour,minute,secondInteger];
            return string;
        }
            break;
        case ZXHMSStringTypemmss:
        {
            NSInteger minute = second / 60;
            NSInteger secondInteger = second % 60;
            
            NSString *string = [NSString stringWithFormat:@"%02zd:%02zd",minute,secondInteger];
            return string;
        }
            break;
            
        default:
            break;
    }
    
   
}

@end

