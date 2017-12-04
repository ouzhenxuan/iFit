//
//  NSDate+ZXExtension.h
//  TopHot
//
//  Created by Liushannoon on 16/4/20.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  几种常用的时间字符串dateFormat
 */
typedef NS_ENUM(NSUInteger, ZXDateForMatType){
    /**
     * 年月日时分秒模式,yyyy-MM-dd HH:mm:ss 格式2015-11-24 20:57:38
     */
    ZXDateForMatTypeyyyyMMddHHmmss = 1,
    /**
     * 年月日模式 yyyy-MM-dd 格式2015-11-24
     */
    ZXDateForMatTypeyyyyMMdd = 2,
    /**
     * 月日模式 MM-dd 格式11-24
     */
    ZXDateForMatTypeMMdd = 3,
    /**
     * 时分模式 HH:mm 格式20:57
     */
    ZXDateForMatTypeHHmm = 4,
    /**
     * 月日带文字模式 MMddInChinese 格式11月24日
     */
    ZXDateForMatTypeMMddInChinese = 5,
    /**
     * 月日带文字模式 MMddInChinese,小时分钟 格式:  11月24日 10:10
     */
    ZXDateForMatTypeMMDDInChineseHHmm = 6,
    /**
     * 月日带文字模式 MMddHHmm,小时分钟 格式:  11月24日 10:10
     */
    ZXDateForMatTypeMMddHHmm =7
};


/**
 *  小时/分钟/秒的几种组合时间字符串
 */
typedef NS_ENUM(NSUInteger, ZXHMSStringType){
    /**
     * 时分秒都有 , 20:57:38
     */
    ZXHMSStringTypehhmmss = 1,
    /**
     * 分秒,没有小时 , 57:38
     */
    ZXHMSStringTypemmss = 2
};


@interface NSDate (ZXExtension)

/**
 *  传一个时间戳过来,返回一个yyyy-MM-dd HH:mm:ss 格式的时间字符串
 *
 *  @param timeInterval 从1970年开始的时间戳
 *
 *  @return 返回去的是一个2015-11-24 20:57:38格式的的时间字符串
 */
+ (NSString *)zx_dateStringWithTimeIntervalSince1970:(NSInteger)timeInterval;
/**
 *  传一个时间戳过来,返回一个指定格式的时间字符串
 *
 *  @param timeInterval 从1970年开始的时间戳
 *  @param dateFormatType   时间格式,默认是@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回去的是一个指定时间格式的的时间字符串
 */
+ (NSString *)zx_dateStringWithTimeIntervalSince1970:(NSInteger)timeInterval withDateFormatType:(ZXDateForMatType )dateFormatType;

/**
 *  传一个已经格式化的日期字符串,转化为yyyy-MM-dd HH:mm:ss格式的NSDate,然后再转成时间戳
 *
 *  @param dateString 格式化的日期字符串
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)zx_timeIntervalWithDateString:(NSString *)dateString;
/**
 *  传一个已经格式化的日期字符串,转化为yyyy-MM-dd HH:mm:ss格式的NSDate,然后再转成时间戳
 *
 *  @param dateString 格式化的日期字符串
 *  @param dateFormatType 对应的日期格式 , 默认是@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转化后的时间戳
 */
+ (NSTimeInterval)zx_timeIntervalWithDateString:(NSString *)dateString withDateFormatType:(ZXDateForMatType)dateFormatType;

/**
 *  计算from到今天的时间差距，返回值是NSDateComponents，可以直接取出各种时间成员
 */
- (NSDateComponents *)zx_deltaFrom:(NSDate *)from;
/**
 *  判断是否是今年
 */
- (BOOL)zx_isThisYear;
/**
 *  判断是否是今天
 */
- (BOOL)zx_isToday;
/**
 *  判断是否是昨天
 */
- (BOOL)zx_isYesterday;
/**
 * 返回一个指定年月日的date对象
 */
+ (NSDate *)zx_dateWithDay:(NSUInteger)day month:(NSUInteger)month year:(NSUInteger)year;
/**
 *  快速创建NSDate对象
 */
+ (NSDate *)zx_dateWithYear:(NSUInteger)year
                      Month:(NSUInteger)month
                        Day:(NSUInteger)day
                       Hour:(NSUInteger)hour
                     Minute:(NSUInteger)minute
                     Second:(NSUInteger)second;
/**
 *  获取当天的年月日时间,时分秒为0
 */
+ (NSDate *)zx_currentDayDateOnlyYMD;
/**
 *  把NSDate对象转化成一个包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents对象
 */
- (NSDateComponents *)componentsOfDay;
/**
 *  获得NSDate对象中对应的年份
 */
- (NSUInteger)zx_year;
/**
 *  获得NSDate对象中对应的月份
 */
- (NSUInteger)zx_month;
/**
 *  返回NSDate对象中对应的月份,字符串格式的月份
 */
- (NSString *)zx_monthString;
/**
 *  获取NSDate对象中对应的天
 */
- (NSUInteger)zx_day;
/**
 *  获取NSDate对象中对应的小时
 */
- (NSUInteger)zx_hour;
/**
 *  获得NSDate对应的分钟数
 */
- (NSUInteger)zx_minute;
/**
 *  获得NSDate对应的秒数
 */
- (NSUInteger)zx_second;
/**
 *  获得NSDate对应的星期
 */
- (NSUInteger)zx_weekday;
/**
 *  获取当天是当年的第几周
 */
- (NSUInteger)zx_weekOfDayInYear;
/**
 *  获得一般当天的工作开始时间
 */
- (NSDate *)zx_workBeginTime;
/**
 *  获得一般当天的工作结束时间
 */
- (NSDate *)zx_workEndTime;
/**
 *  获取一小时后的时间
 */
- (NSDate *)zx_oneHourLater;
/**
 *  获得某一天的这个时刻
 */
- (NSDate *)zx_sameTimeOfDate;
/**
 *  创第一个时间过来,判断和调用这个方法的时间是否是同一个天
 *
 *  @param otherDate 要和当前日期比较的日期
 *
 *  @return 返回结果,yes表示同一
 */
- (BOOL)zx_sameDayWithDate:(NSDate *)otherDate;
/**
 *  创第一个时间过来,判断和调用这个方法的时间是否是同一个周
 *
 *  @param otherDate 要和当前日期比较的日期
 *
 *  @return 返回结果,yes表示同一
 */
- (BOOL)zx_sameWeekWithDate:(NSDate *)otherDate;
/**
 *  创第一个时间过来,判断和调用这个方法的时间是否是同一个月
 *
 *  @param otherDate 要和当前日期比较的日期
 *
 *  @return 返回结果,yes表示同一
 */
- (BOOL)zx_sameMonthWithDate:(NSDate *)otherDate;

/************************        日历相关的方法         *****************************/

/**
 *  NSDate对象所在的月有几天
 */
- (NSUInteger)zx_numberOfDaysInCurrentMonth;
/**
 *  NSDate对象所在的这个月有几个星期
 */
- (NSUInteger)zx_numberOfWeeksInCurrentMonth;
/**
 *  NSDate对象,在星期中的顺序,星期几
 */
- (NSUInteger)zx_weeklyOrdinality;
/**
 *  NSDate对象在月份中的第几天
 */
- (NSUInteger)zx_monthlyOrdinality;
/**
 *  NSDate对象所在的月的第一天
 */
- (NSDate *)zx_firstDayOfCurrentMonth;
/**
 *  NSDate对象所在的月的最后一天
 */
- (NSDate *)zx_lastDayOfCurrentMonth;
/**
 *  NSDate对象在上个月中的NSDate对象 3.28 -> 2.28
 */
- (NSDate *)zx_dayInThePreviousMonth;
/**
 *  NSDate对象在下个月中的NSDate对象 , 3.28 -> 4.28
 */
- (NSDate *)zx_dayInTheFollowingMonth;
/**
 *  根据sele,生成一个NSDateComponents对象
 */
- (NSDateComponents *)zx_YMDComponents;
/**
 * NSDate对象所在的星期在这个月中,是第几个星期
 */
- (NSUInteger)zx_weekNumberInCurrentMonth;
/**
 *  计算当前NSDate对象加上传递过来的days天以后的NSDate值,
 *
 *  @param days 加多少天,可以是负值
 *
 *  @return 加了days天以后的NSDate对象
 */
- (NSDate *)zx_dateByAddingDays:(NSInteger)days;
/**
 *  计算当前NSDate对象加上传递过来的months个月以后的NSDate
 *
 *  @param months 加了多少个月,负数表示向前计算
 *
 *  @return 操作后的对象
 */
- (NSDate *)zx_dateByAddingMonths:(NSInteger)months;
/**
 * 计算当前NSDate对象加上传递过来的minutes个分以后的NSDate
 *
 *  @param minutes 要加的分钟
 *
 *  @return
 */
- (NSDate *)zx_dateByAddingMinutes:(NSInteger)minutes;
/**
 *  对NSDate对象进行指定格式的转换,返回一个指定格式的日期时间字符串
 *
 *  @param dateFormatType 参数是dateFormatType类型
 *
 *  @return 返回去的是一个指定时间格式的的时间字符串
 */
- (NSString *)zx_dateStringWithDateFormatType:(ZXDateForMatType)dateFormatType;
/**
 *  把传过来的字符串日期,转化为指定格式的nsdate,然后再转成时间戳
 *
 *  @param dateString 时间字符串
 *  @param dateFormatType 字符串的指定格式 , 默认是@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转化后的时间戳
 */
+ (NSTimeInterval)zx_timeIntervalWithDateString:(NSString *)dateString withDateFormat:(ZXDateForMatType)dateFormatType;
/**
 把一个表示秒的整数 , 转化成对应的时分秒格式字符串
 
 @param second 多少秒
 
 @return 对应的时分秒字符串 eg:  100s   ->  @"00:01:40"
 */
+ (NSString *)zx_HMSStringWithSecond:(NSInteger)second;
/**
 把一个表示秒的整数 , 转化成对应的时分秒格式字符串
 
 @param second 多少秒
 
 @return 对应的时分秒字符串 eg:  100s   ->  @"00:01:40"
 */
+ (NSString *)zx_HMSStringWithSecond:(NSInteger)second HMSType:(ZXHMSStringType)HMSType;

@end
