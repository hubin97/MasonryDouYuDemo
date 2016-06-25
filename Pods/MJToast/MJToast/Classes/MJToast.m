//
//  MJToast.m
//  Common
//
//  Created by 黄磊 on 16/4/6.
//  Copyright © 2016年 Musjoy. All rights reserved.
//

#import "MJToast.h"
#import <QuartzCore/QuartzCore.h>


static MJToast *s_mjToast = nil;

#define DEFAULT_BOTTOM_PADDING 108    // 50
#define START_DISAPPEAR_SECOND 2.5
#define DISAPPEAR_DURATION 1.0

// toast所依附的window
UIWindow *s_toastWindows = nil;

const CGFloat MJToastTextPadding     = 5;
const CGFloat MJToastLabelWidth      = 200;
const CGFloat MJToastLabelHeight     = 60;

static float totalTimeCount = 60 * DISAPPEAR_DURATION;

@interface MJToast()

@property (nonatomic, copy) NSString *strToast;
@property (nonatomic, strong) UILabel *lblToast;

@property (nonatomic, assign) NSTimer *disappearTimer;
@property (nonatomic, assign) NSTimer *disappearingTimer;
@property (nonatomic, assign) int curToastState;        // 0:不显示;1:显示;2:正在消失
@property (nonatomic, assign) float curTimeCount;         // 当前倒计时

+ (MJToast *)shareInstance;

- (id)initWithText:(NSString *)text;    
- (void)deviceOrientationChange;

@end

@implementation MJToast

static UIInterfaceOrientation lastOrientation; 


+ (UIWindow *)tostWindow
{
    if (s_toastWindows == nil) {
        s_toastWindows = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [s_toastWindows setBackgroundColor:[UIColor clearColor]];
        s_toastWindows.windowLevel = 10000000 + 1;
        [s_toastWindows setUserInteractionEnabled:NO];
        [s_toastWindows makeKeyAndVisible];
    }
    return s_toastWindows;
}

+ (MJToast *)shareInstance
{
    if (s_mjToast == nil) {
        s_mjToast = [[MJToast alloc] init];
        UILabel *lblPg = [[UILabel alloc]initWithFrame:CGRectZero];
        UIFont *font = [UIFont systemFontOfSize:13];
        lblPg.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:33.0/255.0 blue:39.0/255.0 alpha:1.0f];
        //lblToast.backgroundColor = [UIColor lightGrayColor];
        lblPg.textColor = [UIColor whiteColor];
        //lblToast.textColor = [UIColor blackColor];
        lblPg.layer.cornerRadius = 5;
        lblPg.layer.borderWidth = 0;
        lblPg.layer.masksToBounds = YES;
        lblPg.numberOfLines = 2;
        lblPg.font = font;
        lblPg.textAlignment = NSTextAlignmentCenter;
        s_mjToast.lblToast = lblPg;

        // 添加边框
        CALayer *layer = [s_mjToast.lblToast layer];
        layer.borderColor = [[UIColor lightGrayColor] CGColor];
        layer.borderWidth = 1.0f;
        // 添加四个边阴影...(不适用于圆角view)
        //    lblToast.layer.shadowColor = [UIColor whiteColor].CGColor;
        //    lblToast.layer.shadowOffset = CGSizeMake(2, 2);
        //    lblToast.layer.shadowOpacity = 0.5;
        //    lblToast.layer.shadowRadius = 2.0;
    }
    return s_mjToast;
}


- (id)initWithText:(NSString *)text
{

    if (self = [super init])
    {
        self.strToast = text;
         
    }    
    return self;
}


+ (MJToast *)makeToast:(NSString *)text
{
    MJToast *aToast = [MJToast shareInstance];
    aToast.strToast = text;
    return aToast;
}

- (void)show
{
    if([self.strToast isEqualToString:@""]) {
        return;
    }
    
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize textSize = [_strToast boundingRectWithSize:CGSizeMake(MJToastLabelWidth, MJToastLabelHeight)
                                              options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                           attributes:@{NSFontAttributeName:font}
                                              context:nil].size;
//    [strToast sizeWithFont:font constrainedToSize:CGSizeMake(MJToastLabelWidth, MJToastLabelHeight)];
    [_lblToast setFrame:CGRectMake(0, 0, textSize.width + 2 * MJToastTextPadding, textSize.height + 2 * MJToastTextPadding)];

    _lblToast.text = self.strToast;
    
    UIWindow *window = [MJToast tostWindow];

    if(self.lblToast.superview) {
        if (self.lblToast.superview != window) {
            [self.lblToast removeFromSuperview];
            [window addSubview:self.lblToast];
        }
    } else {
        [window addSubview:self.lblToast];
    }
    
    if (_curToastState == 2) {
        [_disappearingTimer invalidate];
        self.disappearingTimer = nil;
    } else if (_curToastState == 1) {
        [_disappearTimer invalidate];
        self.disappearTimer = nil;
    }
    _curToastState = 0;
    [self.lblToast setAlpha:1];
    self.disappearTimer = [NSTimer scheduledTimerWithTimeInterval:START_DISAPPEAR_SECOND target:self selector:@selector(toastDisappear:) userInfo:nil repeats:NO];
    _curToastState = 1;
    [self deviceOrientationChange];
    
}

- (void)deviceOrientationChange
{
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    CGPoint point = window.center;    
    CGFloat centerX=0, centerY=0;
    CGFloat windowCenterX = window.center.x;
    CGFloat windowCenterY = window.center.y;
    CGFloat windowWidth = window.frame.size.width;
    CGFloat windowHeight = window.frame.size.height;
    
    UIInterfaceOrientation currentOrient= [UIApplication
                                           sharedApplication].statusBarOrientation;
    
    if (currentOrient == UIInterfaceOrientationLandscapeRight) {

        CGAffineTransform rotateTransform   = CGAffineTransformMakeRotation(M_PI/2);
        _lblToast.transform = CGAffineTransformConcat(window.transform, rotateTransform);
        centerX = DEFAULT_BOTTOM_PADDING;
        centerY = windowCenterY;
        
    } else if(currentOrient == UIInterfaceOrientationLandscapeLeft) {

        CGAffineTransform rotateTransform;
        if (lastOrientation == UIInterfaceOrientationPortrait) {
            rotateTransform   = CGAffineTransformMakeRotation(-M_PI/2);
        } else {
            rotateTransform   = CGAffineTransformMakeRotation(M_PI/2);
        }
        
        _lblToast.transform = CGAffineTransformConcat(_lblToast.transform, rotateTransform);
        centerX = windowWidth - DEFAULT_BOTTOM_PADDING;
        centerY = windowCenterY;
        
    } else if(currentOrient == UIInterfaceOrientationPortraitUpsideDown) {

        lastOrientation = currentOrient;
        _lblToast.transform = CGAffineTransformRotate(window.transform, -M_PI);
        
        centerX = windowCenterX;
        centerY = DEFAULT_BOTTOM_PADDING;
        
    } else if(currentOrient == UIInterfaceOrientationPortrait) {

        lastOrientation = currentOrient;
        _lblToast.transform = window.transform;
        centerX = windowCenterX;
        centerY = windowHeight - DEFAULT_BOTTOM_PADDING;
        
    }

    self.lblToast.center = CGPointMake(centerX, centerY);
}

- (void)toastDisappear:(NSTimer *)timer
{
    [self.disappearTimer invalidate];
    self.disappearTimer = nil;
    _curTimeCount = totalTimeCount;
    self.disappearingTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(startDisappear:) userInfo:nil repeats:YES];
    _curToastState = 2;
}

- (void)startDisappear:(NSTimer *)timer
{
    if (_curToastState == 0) {
        [self.disappearingTimer invalidate];
        self.disappearingTimer = nil;
        return;
    }
    if (_curTimeCount >= 0) {
        [self.lblToast setAlpha:_curTimeCount/totalTimeCount];
        _curTimeCount--;
    } else {
        [self.lblToast removeFromSuperview];
        [self.disappearingTimer invalidate];
        self.disappearingTimer = nil;
        _curToastState = 0;
        s_toastWindows = nil;
    }
}

@end
