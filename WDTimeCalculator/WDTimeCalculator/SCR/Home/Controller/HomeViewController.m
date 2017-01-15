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

@property (nonatomic, strong) UILabel *amWorkTimeLabel; /**< 上午工作总时间 */
@property (nonatomic, strong) UILabel *pmWorkTimeLabel; /**< 下午工作总时间 */
@property (nonatomic, strong) UILabel *allDateWorkTimeLabel; /**< 总时间 */

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
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(calculatorResetClick)];
    self.navigationItem.leftBarButtonItem = leftItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(calculatorComplete)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)calculatorResetClick{
    
    [self.amStartDatePicker setDate:[self _dateWithHourMinuteString:@"08:00"] animated:YES];
    [self.amEndDatePicker setDate:[self _dateWithHourMinuteString:@"12:00"] animated:YES];

    [self.pmStartDatePicker setDate:[self _dateWithHourMinuteString:@"14:00"] animated:YES];
    [self.pmEndDatePicker setDate:[self _dateWithHourMinuteString:@"18:00"] animated:YES];
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
    UILabel *amWoekTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.amStartDatePicker.frame), kScreenWidth * 0.3, 20)];
    amWoekTagLabel.font = [UIFont systemFontOfSize:16.0f];
    amWoekTagLabel.textAlignment = NSTextAlignmentCenter;
    amWoekTagLabel.backgroundColor = [UIColor clearColor];
    amWoekTagLabel.textColor = [UIColor blackColor];
    amWoekTagLabel.text = @"上午";
    [self.view addSubview:amWoekTagLabel];
    [self.view addSubview:self.amWorkTimeLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.amStartDatePicker.frame) + 30, kScreenWidth, 2)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    
    [self.view addSubview:self.pmStartDatePicker];
    UILabel *pmStartEndSepLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 10, pikerViewHeight * 0.5 + CGRectGetMinY(self.pmStartDatePicker.frame) - 10, 20, 20)];
    pmStartEndSepLabel.font = [UIFont systemFontOfSize:16.0f];
    pmStartEndSepLabel.textAlignment = NSTextAlignmentCenter;
    pmStartEndSepLabel.backgroundColor = [UIColor clearColor];
    pmStartEndSepLabel.textColor = [UIColor blackColor];
    pmStartEndSepLabel.text = @"至";
    [self.view addSubview:pmStartEndSepLabel];

    [self.view addSubview:self.pmEndDatePicker];
    UILabel *pmWoekTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pmStartDatePicker.frame), kScreenWidth * 0.3, 20)];
    pmWoekTagLabel.font = [UIFont systemFontOfSize:16.0f];
    pmWoekTagLabel.textAlignment = NSTextAlignmentCenter;
    pmWoekTagLabel.backgroundColor = [UIColor clearColor];
    pmWoekTagLabel.textColor = [UIColor blackColor];
    pmWoekTagLabel.text = @"下午";
    [self.view addSubview:pmWoekTagLabel];
    [self.view addSubview:self.pmWorkTimeLabel];
    
    UIView *pmLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pmStartDatePicker.frame) + 30, kScreenWidth, 2)];
    pmLineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pmLineView];

    UILabel *allWorkTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pmStartDatePicker.frame) + 40, kScreenWidth * 0.3, 20)];
    allWorkTagLabel.font = [UIFont systemFontOfSize:16.0f];
    allWorkTagLabel.textAlignment = NSTextAlignmentCenter;
    allWorkTagLabel.backgroundColor = [UIColor clearColor];
    allWorkTagLabel.textColor = [UIColor blackColor];
    allWorkTagLabel.text = @"全天";
    [self.view addSubview:allWorkTagLabel];
    
    [self.view addSubview:self.allDateWorkTimeLabel];
    
}

-(void)_loadHomeDataFormServer{
    
}

#pragma mark - 时间值的处理
// 上午开始时间
- (void)amDatePickerValueChange:(UIDatePicker *)amStartDatePicker{
    
}

- (void)calculatorComplete{

    NSTimeInterval amStartTime = [self.amStartDatePicker.date timeIntervalSince1970];
    NSTimeInterval amEndTime = [self.amEndDatePicker.date timeIntervalSince1970];
    NSTimeInterval amDistance = amEndTime - amStartTime;
    
    if (amDistance < 0) {
        self.amWorkTimeLabel.textColor = [UIColor redColor];
        self.amWorkTimeLabel.text = @"上午时间设置错误了, 请重新核对";
        return;
    }else{
        self.amWorkTimeLabel.textColor = [UIColor orangeColor];
        self.amWorkTimeLabel.text = [self _timeResultDistanceWithDistance:amDistance];
    }
    
    NSTimeInterval pmStartTime = [self.pmStartDatePicker.date timeIntervalSince1970];
    NSTimeInterval pmEndTime = [self.pmEndDatePicker.date timeIntervalSince1970];
    NSTimeInterval pmDistance = pmEndTime - pmStartTime;
    
    if (pmDistance < 0) {
        self.pmWorkTimeLabel.textColor = [UIColor redColor];
        self.pmWorkTimeLabel.text = @"下午时间设置错误了, 请重新核对";
        return;
    }else{
        self.pmWorkTimeLabel.textColor = [UIColor orangeColor];
        self.pmWorkTimeLabel.text = [self _timeResultDistanceWithDistance:pmDistance];
    }
    
    
    NSTimeInterval allDistance = pmDistance + amDistance;
    if (allDistance >= 0) {
        self.allDateWorkTimeLabel.textColor = [UIColor orangeColor];
        self.allDateWorkTimeLabel.text = [NSString stringWithFormat:@"全天工作共计%.f分钟\n共计%@", allDistance / 60, [self _timeResultDistanceWithDistance:allDistance]];
    }else{
        self.allDateWorkTimeLabel.textColor = [UIColor redColor];
        self.allDateWorkTimeLabel.text = @"设置出错了, 请重新核对";
    }
    
    [self.amWorkTimeLabel setNeedsDisplay];
    [self.pmWorkTimeLabel setNeedsDisplay];
    [self.allDateWorkTimeLabel setNeedsDisplay];
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
        [_amStartDatePicker setMinimumDate:[self _dateWithHourMinuteString:@"03:00"]];
        
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
        [_amEndDatePicker setMinimumDate:[self _dateWithHourMinuteString:@"08:00"]];
        [_amEndDatePicker setMaximumDate:[self _dateWithHourMinuteString:@"18:00"]];
        
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

- (UIDatePicker *)pmStartDatePicker{
    if (_pmStartDatePicker == nil) {
        _pmStartDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.amStartDatePicker.frame) + 22, kScreenWidth * 0.5 - 10, kScreenHeight * 0.3)];
        _pmStartDatePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        _pmStartDatePicker.locale = locale;
        _pmStartDatePicker.tag = 201;
        [_pmStartDatePicker addTarget:self action:@selector(amDatePickerValueChange:) forControlEvents:UIControlEventValueChanged];
        [_pmStartDatePicker setDate:[self _dateWithHourMinuteString:@"14:00"] animated:NO];
        [_pmStartDatePicker setMinimumDate:[self _dateWithHourMinuteString:@"12:00"]];
        [_pmStartDatePicker setMaximumDate:[self _dateWithHourMinuteString:@"23:59"]];
        
        UILabel *amStartSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_pmStartDatePicker.frame) - 40, 20)];
        amStartSep.center = CGPointMake(CGRectGetWidth(_pmStartDatePicker.frame) * 0.5 - 10, CGRectGetHeight(_pmStartDatePicker.frame)  * 0.5);
        amStartSep.font = [UIFont systemFontOfSize:17];
        amStartSep.text = @":";
        amStartSep.textAlignment = NSTextAlignmentCenter;
        amStartSep.backgroundColor = [UIColor clearColor];
        amStartSep.textColor = [UIColor blackColor];
        [_pmStartDatePicker addSubview:amStartSep];
    }
    return _pmStartDatePicker;
}

- (UIDatePicker *)pmEndDatePicker{
    if (_pmEndDatePicker == nil) {
        _pmEndDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 10, CGRectGetMaxY(self.amStartDatePicker.frame) + 22, kScreenWidth * 0.5 - 10, kScreenHeight * 0.3)];
        _pmEndDatePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        _pmEndDatePicker.locale = locale;
        _pmEndDatePicker.tag = 202;
        [_pmEndDatePicker addTarget:self action:@selector(amDatePickerValueChange:) forControlEvents:UIControlEventValueChanged];
        [_pmEndDatePicker setDate:[self _dateWithHourMinuteString:@"18:00"] animated:NO];
        [_pmEndDatePicker setMinimumDate:[self _dateWithHourMinuteString:@"12:00"]];
        [_pmStartDatePicker setMaximumDate:[self _dateWithHourMinuteString:@"23:59"]];
        
        UILabel *amStartSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_pmEndDatePicker.frame) - 40, 20)];
        amStartSep.center = CGPointMake(CGRectGetWidth(_pmEndDatePicker.frame) * 0.5 - 10, CGRectGetHeight(_pmEndDatePicker.frame)  * 0.5);
        amStartSep.font = [UIFont systemFontOfSize:17];
        amStartSep.text = @":";
        amStartSep.textAlignment = NSTextAlignmentCenter;
        amStartSep.backgroundColor = [UIColor clearColor];
        amStartSep.textColor = [UIColor blackColor];
        [_pmEndDatePicker addSubview:amStartSep];
    }
    return _pmEndDatePicker;
}

- (UILabel *)amWorkTimeLabel{
    if (_amWorkTimeLabel == nil) {
        _amWorkTimeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.3, CGRectGetMaxY(self.amStartDatePicker.frame), kScreenWidth * 0.7 - 10, 20)];
        _amWorkTimeLabel.font = [UIFont systemFontOfSize:16.0f];
        _amWorkTimeLabel.textAlignment = NSTextAlignmentCenter;
        _amWorkTimeLabel.textColor = [UIColor orangeColor];
    }
    return _amWorkTimeLabel;
}
- (UILabel *)pmWorkTimeLabel{
    if (_pmWorkTimeLabel == nil) {
        _pmWorkTimeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.3, CGRectGetMaxY(self.pmStartDatePicker.frame), kScreenWidth * 0.7 - 10, 20)];
        _pmWorkTimeLabel.font = [UIFont systemFontOfSize:16.0f];
        _pmWorkTimeLabel.textAlignment = NSTextAlignmentCenter;
        _pmWorkTimeLabel.textColor = [UIColor orangeColor];
//        _pmWorkTimeLabel.backgroundColor = [UIColor redColor];
    }
    return _pmWorkTimeLabel;
}

- (UILabel *)allDateWorkTimeLabel{
    if (_allDateWorkTimeLabel == nil) {
        _allDateWorkTimeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.pmStartDatePicker.frame) + 70, kScreenWidth - 20, 80)];
        _allDateWorkTimeLabel.font = [UIFont systemFontOfSize:16.0f];
        _allDateWorkTimeLabel.textAlignment = NSTextAlignmentCenter;
        _allDateWorkTimeLabel.textColor = [UIColor orangeColor];
        _allDateWorkTimeLabel.numberOfLines = 0;
        _allDateWorkTimeLabel.layer.cornerRadius = 5;
        _allDateWorkTimeLabel.layer.masksToBounds = YES;
        _allDateWorkTimeLabel.layer.borderWidth = 1;
        _allDateWorkTimeLabel.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _allDateWorkTimeLabel;
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
