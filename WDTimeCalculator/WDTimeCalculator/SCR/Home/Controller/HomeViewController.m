//
//  HomeViewController.m
//  WDTimeCalculator
//
//  Created by YJHou on 2016/12/11.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "HomeViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define pikerViewHeight kScreenHeight * 0.3

static CGFloat const leftMargin = 10.0f;

@interface HomeViewController ()

@property (nonatomic, strong) UIDatePicker *amStartDatePicker; /**< 上午开始时间选择器 */
@property (nonatomic, strong) UIDatePicker *amEndDatePicker; /**< 上午结束时间选择器 */
@property (nonatomic, strong) UIDatePicker *pmStartDatePicker; /**< 下午开始时间选择器 */
@property (nonatomic, strong) UIDatePicker *pmEndDatePicker; /**< 下午结束时间选择器 */

@property (nonatomic, strong) UILabel *amStartLabel; /**< 上午开始时间 */

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self _setUpHomeNavgationView];
    [self _setUpHomeMainView];
    [self _loadHomeDataFormServer];
}

- (void)_setUpHomeNavgationView{
    self.navigationItem.title = @"工时计算器";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(calculatorComplete)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)_setUpHomeMainView{
    
    // 添加时间选择器
    [self.view addSubview:self.amStartDatePicker];
    UILabel *amStartEndSepLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 10, pikerViewHeight * 0.5 - 10, 20, 20)];
    amStartEndSepLabel.font = [UIFont systemFontOfSize:16.0f];
    amStartEndSepLabel.textAlignment = NSTextAlignmentCenter;
    amStartEndSepLabel.backgroundColor = [UIColor clearColor];
    amStartEndSepLabel.textColor = [UIColor blackColor];
    amStartEndSepLabel.text = @"至";
    [self.view addSubview:amStartEndSepLabel];
    [self.view addSubview:self.amEndDatePicker];
    [self.view addSubview:self.amStartLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.amStartDatePicker.frame) + 20, kScreenWidth, 2)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    
    
    
}

-(void)_loadHomeDataFormServer{
    
}

#pragma mark - 时间值的处理
// 上午开始时间
- (void)amDatePickerValueChange:(UIDatePicker *)amStartDatePicker{
    
    if (amStartDatePicker.tag == 101) {
        NSLog(@"-%@", amStartDatePicker.date);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = [formatter stringFromDate:amStartDatePicker.date];
        self.amStartLabel.text = dateString;

    }else if (amStartDatePicker.tag == 102){
        NSLog(@"-%@", amStartDatePicker.date);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = [formatter stringFromDate:amStartDatePicker.date];
        self.amStartLabel.text = dateString;
    }
}

- (void)calculatorComplete{

    NSTimeInterval amStartTime = [self.amStartDatePicker.date timeIntervalSince1970];
    NSTimeInterval amEndTime = [self.amEndDatePicker.date timeIntervalSince1970];
    NSTimeInterval amdistance = amEndTime -amStartTime;
    
    self.amStartLabel.text = [NSString stringWithFormat:@"上午工时:%@", [self _timeResultDistanceWithDistance:amdistance]];
    
}

#pragma mark - Lazy
-(UIDatePicker *)amStartDatePicker{
    if (_amStartDatePicker == nil) {
        _amStartDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.5 - 10, kScreenHeight * 0.3)];
        _amStartDatePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        _amStartDatePicker.locale = locale;
        _amStartDatePicker.tag = 101;
        [_amStartDatePicker addTarget:self action:@selector(amDatePickerValueChange:) forControlEvents:UIControlEventValueChanged];
        [_amStartDatePicker setDate:[self _dateWithHourMinuteString:@"8:00"] animated:NO];
        [_amStartDatePicker setMaximumDate:[self _dateWithHourMinuteString:@"12:00"]];
        
        UILabel *amStartSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_amStartDatePicker.frame) - 40, 20)];
        amStartSep.center = CGPointMake(CGRectGetWidth(_amStartDatePicker.frame) * 0.5 - 10, CGRectGetHeight(_amStartDatePicker.frame)  * 0.5);
        amStartSep.font = [UIFont systemFontOfSize:17];
        amStartSep.text = @":";
        amStartSep.textAlignment = NSTextAlignmentCenter;
        amStartSep.backgroundColor = [UIColor clearColor];
        amStartSep.textColor = [UIColor blackColor];
        [_amStartDatePicker addSubview:amStartSep];
    }
    return _amStartDatePicker;
}

- (UIDatePicker *)amEndDatePicker{
    if (_amEndDatePicker == nil) {
        _amEndDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 10, 0, kScreenWidth * 0.5 - 10, kScreenHeight * 0.3)];
        _amEndDatePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        _amEndDatePicker.locale = locale;
        _amEndDatePicker.tag = 102;
        [_amEndDatePicker addTarget:self action:@selector(amDatePickerValueChange:) forControlEvents:UIControlEventValueChanged];
        [_amEndDatePicker setDate:[self _dateWithHourMinuteString:@"12:00"] animated:NO];
        
        UILabel *amStartSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_amEndDatePicker.frame) - 40, 20)];
        amStartSep.center = CGPointMake(CGRectGetWidth(_amEndDatePicker.frame) * 0.5 - 10, CGRectGetHeight(_amEndDatePicker.frame)  * 0.5);
        amStartSep.font = [UIFont systemFontOfSize:17];
        amStartSep.text = @":";
        amStartSep.textAlignment = NSTextAlignmentCenter;
        amStartSep.backgroundColor = [UIColor clearColor];
        amStartSep.textColor = [UIColor blackColor];
        [_amEndDatePicker addSubview:amStartSep];
    }
    return _amEndDatePicker;
}

- (UILabel *)amStartLabel{
    if (_amStartLabel == nil) {
        _amStartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.amStartDatePicker.frame), kScreenWidth, 20)];
        _amStartLabel.font = [UIFont systemFontOfSize:16.0f];
        _amStartLabel.textAlignment = NSTextAlignmentCenter;
        _amStartLabel.textColor = [UIColor redColor];
    }
    return _amStartLabel;
}

#pragma mark - SettingSupport
- (NSDate *)_dateWithHourMinuteString:(NSString *)timeString{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"]; // 这里是用大写的 H
    NSDate * date = [dateFormatter dateFromString:timeString];
    return date;
}

- (NSString *)_timeResultDistanceWithDistance:(NSTimeInterval)distance{
    
    if (distance < 0) {
        return @"亲, 开始时间要大于结束时间哦~";
    }
    
    NSMutableString *string = [[NSMutableString alloc] init];
    if (distance >= 3600) { // 1小时以上
        [string appendString:[NSString stringWithFormat:@"%d小时", (int)distance / 3600]];
        [string appendString:[NSString stringWithFormat:@"%d分", ((int)distance % 3600) / 60]];
    }else{
        [string appendString:[NSString stringWithFormat:@"%d分", ((int)distance % 3600) / 60]];
    }
    return string;
}


@end
