//
//  AFSummaryVC.m
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/14/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import "AFSummaryVC.h"

@interface AFSummaryVC ()
{
    NSUserDefaults *backhide;
    NSTimer *timer;
    int twname;
}
@end

@implementation AFSummaryVC

- (void)viewDidLoad
{
    //Set backgound image
    UIImage *bg = [UIImage imageNamed:@"homebg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bg]];
    
    //Setting scroll view content width to the view width multiplied by 4 so I can view aboutedu, aboutdev, screenshotscroll the view width is the self.view.frame.size.height because my app is in the landscape mode
    summaryscroll.contentSize = CGSizeMake(self.view.frame.size.height*4, self.view.frame.size.width);
    summaryscroll.showsVerticalScrollIndicator = NO;
    summaryscroll.showsHorizontalScrollIndicator = NO;
    
    //Set screenshot's scroll view content width to the view width multiplied by 2 so I can view the screen shots of both my apps Tweader and Matkr
    screenshotsscroll.contentSize = CGSizeMake(self.view.frame.size.height*2, self.view.frame.size.width);
    screenshotsscroll.showsVerticalScrollIndicator = NO;
    screenshotsscroll.showsHorizontalScrollIndicator = NO;
    
    //Set aboutdev, aboutedu label position inside the scroll view
    aboutedu.center = CGPointMake(self.view.frame.size.height*1.5, aboutedu.center.y);
    aboutdev.center = CGPointMake(self.view.frame.size.height*2.5, aboutdev.center.y);
    screenshotsscroll.center = CGPointMake(self.view.frame.size.height*3.5, screenshotsscroll.center.y);
    
    //Set Tweader label font and shadow
    tweaderlabel.layer.masksToBounds = YES;
    tweaderlabel.font = [UIFont fontWithName:@"Franchise" size:120];
    tweaderlabel.layer.shadowColor = [UIColor blackColor].CGColor;
    tweaderlabel.layer.shadowOffset = CGSizeMake(0,5);
    tweaderlabel.layer.shadowOpacity = 0.7f;
    
    //Set Matkr label font and shadow and captiliazing its text
    matkrlabel.layer.masksToBounds = YES;
    matkrlabel.font = [UIFont fontWithName:@"Franchise" size:120];
    matkrlabel.layer.shadowColor = [UIColor blackColor].CGColor;
    matkrlabel.layer.shadowOffset = CGSizeMake(0,5);
    matkrlabel.layer.shadowOpacity = 0.7f;
    matkrlabel.text = @"MATKR";
    
    //Set close button font and shadow and captiliazing its text
    homeoutlet.layer.masksToBounds = YES;
    homeoutlet.titleLabel.font = [UIFont fontWithName:@"Franchise" size:90];
    homeoutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    homeoutlet.layer.shadowOffset = CGSizeMake(0,5);
    homeoutlet.layer.shadowOpacity = 0.7f;
    
    //change Matkr screenshots position
    matkrscreenshots.center = CGPointMake(matkrscreenshots.center.x+7, matkrscreenshots.center.y);

    backhide = [NSUserDefaults standardUserDefaults];
    [backhide setObject:@"hidewelcome" forKey:@"hideorno"];
    [backhide synchronize];
    
    //set image name number (int)
    twname = 1;
    
    //set timer so every 1.7 second change the image a the UIImageView (screenshots)
    timer = [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(changescreenshottw) userInfo:nil repeats:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(changescreenshotmatkr) userInfo:nil repeats:YES];
    
    [super viewDidLoad];
}

-(void)changescreenshottw{
    //if image name is 5 then set it to zero so it starts viewng screenshots again
    if(twname == 5){
        twname = 0;
    }
    CATransition *fadeimage = [CATransition animation];
    twname += 1;
    NSString *twsname = [NSString stringWithFormat:@"%i.png",twname];
    tweaderscreenshots.image = [UIImage imageNamed:twsname];
    
    //fade animation for changing image every 1.7 seconds
    fadeimage.duration = 1.0f;
    fadeimage.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeimage.type = kCATransitionFade;
    [tweaderscreenshots.layer addAnimation:fadeimage forKey:nil];
}

-(void)changescreenshotmatkr{
    if(twname == 5){
        twname = 0;
    }
    CATransition *fadeimage = [CATransition animation];
    twname += 1;
    NSString *twsname = [NSString stringWithFormat:@"m%i.png",twname];
    matkrscreenshots.image = [UIImage imageNamed:twsname];
    fadeimage.duration = 1.0f;
    fadeimage.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeimage.type = kCATransitionFade;
    [matkrscreenshots.layer addAnimation:fadeimage forKey:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)backtimemachine:(id)sender {
    //stop timer
    [timer invalidate];
    timer = nil;
    //back to the timemachine view
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *yearviewc = [main instantiateViewControllerWithIdentifier:@"timemachine"];
    yearviewc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:yearviewc animated:YES completion:NULL];
}
@end
