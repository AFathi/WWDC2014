//
//  AFViewController.m
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/5/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import "AFViewController.h"
#import "AFVCYears.h"
#import "AFAppDelegate.h"

@interface AFViewController ()
{
    UIInterpolatingMotionEffect *theYcenter;
    UIInterpolatingMotionEffect *theXcenter;
    UIMotionEffectGroup *bothXandY;
    CABasicAnimation *pulseIt;
    CABasicAnimation *fliphand;
    UILabel *y1998;
    UILabel *y2003;
    UILabel *y2010;
    UILabel *y2011;
    UILabel *y2012;
    UILabel *y2013;
    NSUserDefaults *yearwhat;
    NSUserDefaults *backhide;
    UIPanGestureRecognizer *drag;
}
@end

@implementation AFViewController

- (void)viewDidLoad
{
    // Set background image
    UIImage *bg = [UIImage imageNamed:@"homebg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bg]];
    
    // Summary button shadow and font
    summaryo.titleLabel.font = [UIFont fontWithName:@"Franchise" size:60];
    summaryo.layer.masksToBounds = YES;
    summaryo.layer.shadowColor = [UIColor blackColor].CGColor;
    summaryo.layer.shadowOffset = CGSizeMake(0, 9);
    summaryo.layer.shadowOpacity = 0.3f;
    
    //Parallax for the parallaxview (The view that appear when app is opened for the first time)
    theXcenter = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    theXcenter.minimumRelativeValue = @(-85);
    theXcenter.maximumRelativeValue = @(85);
    
    theYcenter = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    theYcenter.minimumRelativeValue = @(-65);
    theYcenter.maximumRelativeValue = @(15);
    
    bothXandY = [UIMotionEffectGroup new];
    bothXandY.motionEffects = @[theXcenter, theYcenter];
    [parallaxview addMotionEffect:bothXandY];
    
    //Parallax for the whole view (self.view)
    theXcenter = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    theXcenter.minimumRelativeValue = @(-15);
    theXcenter.maximumRelativeValue = @(15);
    
    theYcenter = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    theYcenter.minimumRelativeValue = @(-15);
    theYcenter.maximumRelativeValue = @(15);
    
    bothXandY = [UIMotionEffectGroup new];
    bothXandY.motionEffects = @[theXcenter, theYcenter];
    [self.view addMotionEffect:bothXandY];

    //My name's shadow and font
    AF.layer.masksToBounds = YES;
    AF.font = [UIFont fontWithName:@"Franchise" size:160];
    AF.layer.shadowColor = [UIColor blackColor].CGColor;
    AF.layer.shadowOffset = CGSizeMake(0,3);
    AF.layer.shadowOpacity = 0.7f;
    
    //Time Machine label shadow and font
    tm.layer.masksToBounds = YES;
    tm.font = [UIFont fontWithName:@"Franchise" size:90];
    tm.layer.shadowColor = [UIColor blackColor].CGColor;
    tm.layer.shadowOffset = CGSizeMake(0,3);
    tm.layer.shadowOpacity = 0.7f;
    
    //"Select a year by dragging it..." label shadow and font
    tip.layer.masksToBounds = YES;
    tip.layer.shadowColor = [UIColor blackColor].CGColor;
    tip.layer.shadowOffset = CGSizeMake(0,3);
    tip.layer.shadowOpacity = 0.7f;
    
    //Creating year 1998 label and adding UIPanGestureRecognizer to it
    y1998 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/1.8, self.view.bounds.size.width/10.8, 190, 190)];
    y1998.layer.masksToBounds = YES;
    y1998.layer.cornerRadius = 95.0f;
    y1998.layer.borderWidth = 15.0f;
    y1998.layer.borderColor = [UIColor colorWithRed:10.0f/255.0f green:124.0f/255.0f blue:126.0f/255.0f alpha:1].CGColor;
    y1998.layer.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:186.0f/255.0f blue:189.0f/255.0f alpha:1].CGColor;
    y1998.textAlignment = NSTextAlignmentCenter;
    y1998.textColor = [UIColor whiteColor];
    y1998.text = @"1998";
    y1998.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [y1998 addGestureRecognizer:drag];
    [timemachineview addSubview:y1998];
    y1998.userInteractionEnabled = YES;

    //Creating year 2003 label and adding UIPanGestureRecognizer to it
    y2003 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/1.3, self.view.bounds.size.width/10.8, 190, 190)];
    y2003.layer.masksToBounds = YES;
    y2003.layer.cornerRadius = 95.0f;
    y2003.layer.borderWidth = 15.0f;
    y2003.layer.borderColor = [UIColor colorWithRed:10.0f/255.0f green:124.0f/255.0f blue:126.0f/255.0f alpha:1].CGColor;
    y2003.layer.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:186.0f/255.0f blue:189.0f/255.0f alpha:1].CGColor;
    y2003.textAlignment = NSTextAlignmentCenter;
    y2003.textColor = [UIColor whiteColor];
    y2003.text = @"2003";
    y2003.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [y2003 addGestureRecognizer:drag];
    [timemachineview addSubview:y2003];
    y2003.userInteractionEnabled = YES;
    
    //Creating year 2010 label and adding UIPanGestureRecognizer to it
    y2010 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/1.8, self.view.bounds.size.width/2.8, 190, 190)];
    y2010.layer.masksToBounds = YES;
    y2010.layer.cornerRadius = 95.0f;
    y2010.layer.borderWidth = 15.0f;
    y2010.layer.borderColor = [UIColor colorWithRed:10.0f/255.0f green:124.0f/255.0f blue:126.0f/255.0f alpha:1].CGColor;
    y2010.layer.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:186.0f/255.0f blue:189.0f/255.0f alpha:1].CGColor;
    y2010.textAlignment = NSTextAlignmentCenter;
    y2010.textColor = [UIColor whiteColor];
    y2010.text = @"2010";
    y2010.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [y2010 addGestureRecognizer:drag];
    [timemachineview addSubview:y2010];
    y2010.userInteractionEnabled = YES;

    //Creating year 2011 label and adding UIPanGestureRecognizer to it
    y2011 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/1.3, self.view.bounds.size.width/2.8, 190, 190)];
    y2011.layer.masksToBounds = YES;
    y2011.layer.cornerRadius = 95.0f;
    y2011.layer.borderWidth = 15.0f;
    y2011.layer.borderColor = [UIColor colorWithRed:10.0f/255.0f green:124.0f/255.0f blue:126.0f/255.0f alpha:1].CGColor;
    y2011.layer.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:186.0f/255.0f blue:189.0f/255.0f alpha:1].CGColor;
    y2011.textAlignment = NSTextAlignmentCenter;
    y2011.textColor = [UIColor whiteColor];
    y2011.text = @"2011";
    y2011.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [y2011 addGestureRecognizer:drag];
    [timemachineview addSubview:y2011];
    y2011.userInteractionEnabled = YES;
    
    //Creating year 2012 label and adding UIPanGestureRecognizer to it
    y2012 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/1.8, self.view.bounds.size.width/1.6, 190, 190)];
    y2012.layer.masksToBounds = YES;
    y2012.layer.cornerRadius = 95.0f;
    y2012.layer.borderWidth = 15.0f;
    y2012.layer.borderColor = [UIColor colorWithRed:10.0f/255.0f green:124.0f/255.0f blue:126.0f/255.0f alpha:1].CGColor;
    y2012.layer.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:186.0f/255.0f blue:189.0f/255.0f alpha:1].CGColor;
    y2012.textAlignment = NSTextAlignmentCenter;
    y2012.textColor = [UIColor whiteColor];
    y2012.text = @"2012";
    y2012.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [y2012 addGestureRecognizer:drag];
    [timemachineview addSubview:y2012];
    y2012.userInteractionEnabled = YES;

    //Creating year 2013 label and adding UIPanGestureRecognizer to it
    y2013 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/1.3, self.view.bounds.size.width/1.6, 190, 190)];
    y2013.layer.masksToBounds = YES;
    y2013.layer.cornerRadius = 95.0f;
    y2013.layer.borderWidth = 15.0f;
    y2013.layer.borderColor = [UIColor colorWithRed:10.0f/255.0f green:124.0f/255.0f blue:126.0f/255.0f alpha:1].CGColor;
    y2013.layer.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:186.0f/255.0f blue:189.0f/255.0f alpha:1].CGColor;
    y2013.textAlignment = NSTextAlignmentCenter;
    y2013.textColor = [UIColor whiteColor];
    y2013.text = @"2013";
    y2013.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    y2013.userInteractionEnabled = YES;
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [y2013 addGestureRecognizer:drag];
    [timemachineview addSubview:y2013];
    
    //Adding animation for the Time Machine and The clock button
    clockbutton.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
    timemachine.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
	pulseIt = [CABasicAnimation animationWithKeyPath:@"transform"];
	pulseIt.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	pulseIt.autoreverses = YES;
	pulseIt.duration = 0.45f;
    pulseIt.removedOnCompletion = NO;
	pulseIt.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseIt.repeatCount = HUGE_VAL;
	[clockbutton.layer addAnimation:pulseIt forKey:@"clockpulse"];
    [timemachine.layer addAnimation:pulseIt forKey:@"yead"];
    
    //Check if this is the first time to use the app or not
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"hideorno"] isEqualToString:@""] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"hideorno"] isEqualToString:nil]){
    timemachineview.alpha = 0;
    timemachineview.hidden = YES;
    }else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"hideorno"] isEqualToString:@"hidewelcome"]){
        timemachineview.alpha = 1;
        timemachineview.hidden = NO;
        parallaxview.hidden = YES;
    }
    
    //Adding Tap Gesture to the time machine to recognize the double click
    UITapGestureRecognizer *doubleclick = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(doubleclk)];
    doubleclick.numberOfTapsRequired = 2;
    [timemachine addGestureRecognizer:doubleclick];
    [super viewDidLoad];
}

//When double clicked on the time machine go to the Year View controller and show 2014 UIView
-(void)doubleclk{
    y1998.userInteractionEnabled = NO;
    y2003.userInteractionEnabled = NO;
    y2010.userInteractionEnabled = NO;
    y2011.userInteractionEnabled = NO;
    y2012.userInteractionEnabled = NO;
    y2013.userInteractionEnabled = NO;
    timemachine.userInteractionEnabled = NO;

    yearwhat = [NSUserDefaults standardUserDefaults];
    [yearwhat setObject:@"2014" forKey:@"yearview"];
    [yearwhat synchronize];
    
    timemachine.layer.speed = 7.0f;
    fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
    fliphand.duration = 10.2f;
    fliphand.cumulative = YES;
    fliphand.repeatCount = HUGE_VALF;
    fliphand.removedOnCompletion = NO;
    fliphand.fillMode = kCAFillModeForwards;
    [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
}

//A method that is connected to the App delegate
-(void)hidee{
    backhide = [NSUserDefaults standardUserDefaults];
    [backhide setObject:@"" forKey:@"hideorno"];
    [backhide synchronize];
}

//While dragging
-(void)dragging:(UIPanGestureRecognizer *)reco {
    
    CGPoint tinview = [reco translationInView:timemachine];
    
    reco.view.center = CGPointMake(reco.view.center.x + tinview.x, reco.view.center.y + tinview.y);

    [reco setTranslation:CGPointMake(0, 0) inView:timemachine];
    
    //if 1998 label intersected to the time machine then go to the year view and make 1998 UIView visible
    if(CGRectIntersectsRect(y1998.frame, timemachine.frame)){
        [UIView animateWithDuration:0.6 animations:^(void) {
            y1998.alpha = 0;
            y2003.userInteractionEnabled = NO;
            y2010.userInteractionEnabled = NO;
            y2011.userInteractionEnabled = NO;
            y2012.userInteractionEnabled = NO;
            y2013.userInteractionEnabled = NO;
            timemachine.userInteractionEnabled = NO;

            yearwhat = [NSUserDefaults standardUserDefaults];
            [yearwhat setObject:@"1998" forKey:@"yearview"];
            [yearwhat synchronize];
            
            timemachine.layer.speed = 7.0f;
            fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
            fliphand.duration = 10.2f;
            fliphand.cumulative = YES;
            fliphand.repeatCount = HUGE_VALF;
            fliphand.removedOnCompletion = NO;
            fliphand.fillMode = kCAFillModeForwards;
            [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
        }];
    }else
    
    //if 2003 label intersected to the time machine then go to the year view and make 2003 UIView visible

    if(CGRectIntersectsRect(y2003.frame, timemachine.frame)){
        [UIView animateWithDuration:0.6 animations:^(void) {
            y2003.alpha = 0;
            y1998.userInteractionEnabled = NO;
            y2010.userInteractionEnabled = NO;
            y2011.userInteractionEnabled = NO;
            y2012.userInteractionEnabled = NO;
            y2013.userInteractionEnabled = NO;
            timemachine.userInteractionEnabled = NO;

            yearwhat = [NSUserDefaults standardUserDefaults];
            [yearwhat setObject:@"2003" forKey:@"yearview"];
            [yearwhat synchronize];

            timemachine.layer.speed = 7.0f;
            fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
            fliphand.duration = 10.2f;
            fliphand.cumulative = YES;
            fliphand.repeatCount = HUGE_VALF;
            fliphand.removedOnCompletion = NO;
            fliphand.fillMode = kCAFillModeForwards;
            [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
        }];
    }else
        
    //if 2010 label intersected to the time machine then go to the year view and make 2010 UIView visible
    if(CGRectIntersectsRect(y2010.frame, timemachine.frame)){
        [UIView animateWithDuration:0.6 animations:^(void) {
            y2010.alpha = 0;
            y2003.userInteractionEnabled = NO;
            y1998.userInteractionEnabled = NO;
            y2011.userInteractionEnabled = NO;
            y2012.userInteractionEnabled = NO;
            y2013.userInteractionEnabled = NO;
            timemachine.userInteractionEnabled = NO;

            yearwhat = [NSUserDefaults standardUserDefaults];
            [yearwhat setObject:@"2010" forKey:@"yearview"];
            [yearwhat synchronize];

            timemachine.layer.speed = 7.0f;
            fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
            fliphand.duration = 10.2f;
            fliphand.cumulative = YES;
            fliphand.repeatCount = HUGE_VALF;
            fliphand.removedOnCompletion = NO;
            fliphand.fillMode = kCAFillModeForwards;
            [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
        }];
    }else
    if(CGRectIntersectsRect(y2011.frame, timemachine.frame)){
        [UIView animateWithDuration:0.6 animations:^(void) {
            y2011.alpha = 0;
            y2003.userInteractionEnabled = NO;
            y2010.userInteractionEnabled = NO;
            y1998.userInteractionEnabled = NO;
            y2012.userInteractionEnabled = NO;
            y2013.userInteractionEnabled = NO;
            timemachine.userInteractionEnabled = NO;

            yearwhat = [NSUserDefaults standardUserDefaults];
            [yearwhat setObject:@"2011" forKey:@"yearview"];
            [yearwhat synchronize];

            timemachine.layer.speed = 7.0f;
            fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
            fliphand.duration = 10.2f;
            fliphand.cumulative = YES;
            fliphand.repeatCount = HUGE_VALF;
            fliphand.removedOnCompletion = NO;
            fliphand.fillMode = kCAFillModeForwards;
            [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
        }];
    }else
    if(CGRectIntersectsRect(y2012.frame, timemachine.frame)){
        [UIView animateWithDuration:0.6 animations:^(void) {
            y2012.alpha = 0;
            y2003.userInteractionEnabled = NO;
            y2010.userInteractionEnabled = NO;
            y2011.userInteractionEnabled = NO;
            y1998.userInteractionEnabled = NO;
            y2013.userInteractionEnabled = NO;
            timemachine.userInteractionEnabled = NO;

            yearwhat = [NSUserDefaults standardUserDefaults];
            [yearwhat setObject:@"2012" forKey:@"yearview"];
            [yearwhat synchronize];

            timemachine.layer.speed = 7.0f;
            fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
            fliphand.duration = 10.2f;
            fliphand.cumulative = YES;
            fliphand.repeatCount = HUGE_VALF;
            fliphand.removedOnCompletion = NO;
            fliphand.fillMode = kCAFillModeForwards;
            [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
        }];
    }else
    if(CGRectIntersectsRect(y2013.frame, timemachine.frame)){
        [UIView animateWithDuration:0.6 animations:^(void) {
            y2013.alpha = 0;
            y2003.userInteractionEnabled = NO;
            y2010.userInteractionEnabled = NO;
            y2011.userInteractionEnabled = NO;
            y2012.userInteractionEnabled = NO;
            y1998.userInteractionEnabled = NO;
            timemachine.userInteractionEnabled = NO;

            yearwhat = [NSUserDefaults standardUserDefaults];
            [yearwhat setObject:@"2013" forKey:@"yearview"];
            [yearwhat synchronize];

            timemachine.layer.speed = 7.0f;
            fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
            fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
            fliphand.duration = 10.2f;
            fliphand.cumulative = YES;
            fliphand.repeatCount = HUGE_VALF;
            fliphand.removedOnCompletion = NO;
            fliphand.fillMode = kCAFillModeForwards;
            [timemachine.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getyear) userInfo:nil repeats:NO];
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enter:(id)sender {
    //change clock button speed animation and animate the hand of the clock
    clockbutton.layer.speed = 7.0f;
    clockbutton.enabled = NO;
    fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
    fliphand.duration = 10.2f;
    fliphand.cumulative = YES;
    fliphand.repeatCount = HUGE_VALF;
    fliphand.removedOnCompletion = NO;
    fliphand.fillMode = kCAFillModeForwards;
    [clockbutton.imageView.layer addAnimation:fliphand forKey:@"fliphandkey"];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doafterloading) userInfo:nil repeats:NO];
}

- (IBAction)summaryaction:(id)sender {
    //Go to the summary view
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *yearviewc = [main instantiateViewControllerWithIdentifier:@"summaryvc"];
    yearviewc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:yearviewc animated:YES completion:NULL];
}

-(void)getyear{
    //go to the years view
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *yearviewc = [main instantiateViewControllerWithIdentifier:@"years"];
    yearviewc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:yearviewc animated:YES completion:NULL];
}

-(void)doafterloading{
    //after animating the clock hand stop animating it and animate the parallax view and then set its alpha to 0
    clockbutton.layer.speed = 0.0f;
    [UIView animateWithDuration:1.9 animations:^(void) {
        parallaxview.alpha = 0;
    }];
    [UIView animateWithDuration:3.0 animations:^(void) {
        timemachineview.alpha = 1;
    }];
    parallaxview.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    pulseIt = [CABasicAnimation animationWithKeyPath:@"transform"];
	pulseIt.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	pulseIt.autoreverses = YES;
	pulseIt.duration = 0.8f;
    pulseIt.removedOnCompletion = NO;
	pulseIt.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseIt.repeatCount = NO;
    [parallaxview.layer addAnimation:pulseIt forKey:@"pulsepview"];
    
    fliphand = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    fliphand.toValue = [NSNumber numberWithFloat: M_PI * 3];
    fliphand.duration = 2.2f;
    fliphand.cumulative = YES;
    fliphand.repeatCount = NO;
    fliphand.autoreverses = YES;
    fliphand.removedOnCompletion = NO;
    fliphand.fillMode = kCAFillModeForwards;
    [parallaxview.layer addAnimation:fliphand forKey:@"fliphandkeyp"];
    timemachineview.hidden = NO;
}
@end
