//
//  cusRefresh.swift
//  wangwang
//
//  Created by 郑 宏 on 15/3/24.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

class cusRefresh: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func attachToScrollView
    
    
    /*
    
    + (YALSunnyRefreshControl*)attachToScrollView:(UIScrollView *)scrollView
    target:(id)target
    refreshAction:(SEL)refreshAction{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"YALSunnyRefreshControl" owner:self options:nil];
    YALSunnyRefreshControl *refreshControl = (YALSunnyRefreshControl *)[topLevelObjects firstObject];
    
    refreshControl.scrollView = scrollView;
    [refreshControl.scrollView addObserver:refreshControl forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    refreshControl.target = target;
    refreshControl.action = refreshAction;
    [scrollView setDelegate:refreshControl];
    [refreshControl setFrame:CGRectMake(0.f,
    0.f,
    scrollView.frame.size.width,
    0.f)];
    [scrollView addSubview:refreshControl];
    return refreshControl;
    }
    
    -(void)awakeFromNib{
    
    [super awakeFromNib];
    
    CGFloat leadingRatio = [UIScreen mainScreen].bounds.size.width / DefaultScreenWidth;
    [self.skyLeadingConstraint setConstant:self.skyLeadingConstraint.constant * leadingRatio];
    [self.skyTrailingConstraint setConstant:self.skyTrailingConstraint.constant * leadingRatio];
    
    }
    
    - (void)observeValueForKeyPath:(NSString *)keyPath
    ofObject:(id)object
    change:(NSDictionary *)change
    context:(void *)context{
    [self calculateShift];
    }
    
    -(void)calculateShift{
    
    [self setFrame:CGRectMake(0.f,
    0.f,
    self.scrollView.frame.size.width,
    self.scrollView.contentOffset.y)];
    
    if(self.scrollView.contentOffset.y <= -DefaultHeight){
    
    if(self.scrollView.contentOffset.y < -SpringTreshold){
    
    [self.scrollView setContentOffset:CGPointMake(0.f, -SpringTreshold)];
    }
    [self scaleItems];
    [self rotateSunInfinitly];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.action withObject:nil];
    #pragma clang diagnostic pop
    self.forbidSunSet = YES;
    }
    
    if(!self.scrollView.dragging && self.forbidSunSet && self.scrollView.decelerating && !self.forbidOffsetChanges){
    
    [self.scrollView setContentOffset:CGPointMake(0.f, -DefaultHeight) animated:YES];
    self.forbidOffsetChanges = YES;
    }
    
    if(!self.forbidSunSet){
    [self setupSunHeightAboveHorisont];
    [self setupSkyPosition];
    }
    }
    
    -(void)endRefreshing{
    
    self.forbidOffsetChanges = NO;
    
    [UIView animateWithDuration:AnimationDuration
    delay:0.f
    usingSpringWithDamping:AnimationDamping
    initialSpringVelocity:AnimationVelosity
    options:UIViewAnimationOptionCurveLinear
    animations:^{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0.f, 0.f, 0.f)];
    } completion:^(BOOL finished) {
    
    self.forbidSunSet = NO;
    [self stopSunRotating];
    }];
    }
    
    -(void)setupSunHeightAboveHorisont{
    
    CGFloat shiftInPercents = [self shiftInPercents];
    CGFloat sunWay = SunBottomPoint - SunTopPoint;
    CGFloat sunYCoordinate = SunBottomPoint - (sunWay / 100) * shiftInPercents;
    [self.sunTopConstraint setConstant:sunYCoordinate];
    
    CGFloat rotationAngle = (CircleAngle / 100) * shiftInPercents;
    self.sunImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(rotationAngle));
    }
    
    -(CGFloat)shiftInPercents{
    
    return (DefaultHeight / 100) * -self.scrollView.contentOffset.y;
    }
    
    -(void)setupSkyPosition{
    
    CGFloat shiftInPercents = [self shiftInPercents];
    CGFloat skyTopConstant = SkyDefaultShift + ((SkyTopShift / 100) * shiftInPercents);
    [self.skyTopConstraint setConstant:skyTopConstant];
    }
    
    -(void)scaleItems{
    
    CGFloat shiftInPercents = [self shiftInPercents];
    CGFloat buildigsScaleRatio = shiftInPercents / 100;
    
    if(buildigsScaleRatio <= BuildingsMaximumScale){
    
    CGFloat extraOffset = ABS(self.scrollView.contentOffset.y) - DefaultHeight;
    self.buildingsHeightConstraint.constant = BuildingDefaultHeight + extraOffset;
    [self.buildingsImageView setTransform:CGAffineTransformMakeScale(buildigsScaleRatio,1.f)];
    
    CGFloat skyScale = (SunAndSkyMinimumScale + (1 - buildigsScaleRatio));
    [UIView animateWithDuration:SkyTransformAnimationDuration animations:^{
    
    [self.skyImageView setTransform:CGAffineTransformMakeScale(skyScale,skyScale)];
    [self.sunImageView setTransform:CGAffineTransformMakeScale(skyScale,skyScale)];
    }];
    }
    }
    
    - (void)rotateSunInfinitly{
    
    if(!self.isSunRotating){
    self.isSunRotating = YES;
    self.forbidSunSet = YES;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = SunRotationAnimationDuration;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.sunImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    }
    
    -(void)stopSunRotating{
    
    self.isSunRotating = NO;
    self.forbidSunSet = NO;
    [self.sunImageView.layer removeAnimationForKey:@"rotationAnimation"];
    }
    
    - (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if(self.forbidOffsetChanges){
    
    [self.scrollView setContentInset:UIEdgeInsetsMake(DefaultHeight, 0.f, 0.f, 0.f)];
    }
    }
    
    */

}
