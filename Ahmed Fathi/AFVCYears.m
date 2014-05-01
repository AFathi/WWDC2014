//
//  AFVCYears.m
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/8/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import "AFVCYears.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "AFAppDelegate.h"

@interface AFVCYears ()
{
    NSArray *tweetsarr;
    NSDictionary *tweet;
    NSString*checktheURL;
    NSString*namwe;
    NSString*texwt;
    NSTimer*timer;
    NSDictionary*finalurl;
    UIInterpolatingMotionEffect *theYcenter;
    UIInterpolatingMotionEffect *theXcenter;
    UIMotionEffectGroup *bothXandY;
    CABasicAnimation *pulseIt;
    UISegmentedControl *controls;
    CGPoint lastloc;
    AVSpeechSynthesizer *avspeechsyn;
    UIPanGestureRecognizer *drag;
    NSUserDefaults *calcdata;
    NSUserDefaults *backhide;
    int twname;
}
@end

@implementation AFVCYears

- (void)viewDidLoad
{
    //Set background image
    UIImage *bg = [UIImage imageNamed:@"homebg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bg]];
    
    //set views position to the center of the screen
    year2003.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    year2010.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    year2011.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    year2012.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    year2013.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    year2014.center = CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    
    backhide = [NSUserDefaults standardUserDefaults];
    [backhide setObject:@"hidewelcome" forKey:@"hideorno"];
    [backhide synchronize];
    
    //Check what year you dragged
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"1998"]){
        year1998.hidden = NO;
        year2003.hidden = YES;
        year2010.hidden = YES;
        year2011.hidden = YES;
        year2012.hidden = YES;
        year2013.hidden = YES;
        year2014.hidden = YES;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"2003"]){
        year1998.hidden = YES;
        year2003.hidden = NO;
        year2010.hidden = YES;
        year2011.hidden = YES;
        year2012.hidden = YES;
        year2013.hidden = YES;
        year2014.hidden = YES;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"2010"]){
        year1998.hidden = YES;
        year2003.hidden = YES;
        year2010.hidden = NO;
        year2011.hidden = YES;
        year2012.hidden = YES;
        year2013.hidden = YES;
        year2014.hidden = YES;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"2011"]){
        year1998.hidden = YES;
        year2003.hidden = YES;
        year2010.hidden = YES;
        year2011.hidden = NO;
        year2012.hidden = YES;
        year2013.hidden = YES;
        year2014.hidden = YES;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"2012"]){
        year1998.hidden = YES;
        year2003.hidden = YES;
        year2010.hidden = YES;
        year2011.hidden = YES;
        year2012.hidden = NO;
        year2013.hidden = YES;
        year2014.hidden = YES;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"2013"]){
        year1998.hidden = YES;
        year2003.hidden = YES;
        year2010.hidden = YES;
        year2011.hidden = YES;
        year2012.hidden = YES;
        year2013.hidden = NO;
        year2014.hidden = YES;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"yearview"] isEqualToString:@"2014"]){
        year1998.hidden = YES;
        year2003.hidden = YES;
        year2010.hidden = YES;
        year2011.hidden = YES;
        year2012.hidden = YES;
        year2013.hidden = YES;
        year2014.hidden = NO;
    }
    screenshotsviewer.hidden = YES;
    screenshotsviewer.alpha = 0;
    
    //Parallax for the 1998 view
    theXcenter = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    theXcenter.minimumRelativeValue = @(-15);
    theXcenter.maximumRelativeValue = @(25);
    
    theYcenter = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    theYcenter.minimumRelativeValue = @(-15);
    theYcenter.maximumRelativeValue = @(25);
    
    bothXandY = [UIMotionEffectGroup new];
    bothXandY.motionEffects = @[theXcenter, theYcenter];
    [year1998 addMotionEffect:bothXandY];
    
    //close screenshots scrollview button shadow and font
    closescreensh.layer.masksToBounds = YES;
    closescreensh.titleLabel.font = [UIFont fontWithName:@"Franchise" size:70];
    closescreensh.layer.shadowColor = [UIColor blackColor].CGColor;
    closescreensh.layer.shadowOffset = CGSizeMake(0,5);
    closescreensh.layer.shadowOpacity = 0.7f;
    
    //Tweader label font and shadow
    tweaderlabel.layer.masksToBounds = YES;
    tweaderlabel.font = [UIFont fontWithName:@"Franchise" size:120];
    tweaderlabel.layer.shadowColor = [UIColor blackColor].CGColor;
    tweaderlabel.layer.shadowOffset = CGSizeMake(0,5);
    tweaderlabel.layer.shadowOpacity = 0.7f;
    
    matkrlabel.layer.masksToBounds = YES;
    matkrlabel.font = [UIFont fontWithName:@"Franchise" size:120];
    matkrlabel.layer.shadowColor = [UIColor blackColor].CGColor;
    matkrlabel.layer.shadowOffset = CGSizeMake(0,5);
    matkrlabel.layer.shadowOpacity = 0.7f;
    matkrlabel.text = @"MATKR";
    
    //label year 1998 shadow and font
    yearlabel1998.layer.masksToBounds = YES;
    yearlabel1998.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel1998.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel1998.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel1998.layer.shadowOpacity = 0.7f;
    
    yearlabel2003.layer.masksToBounds = YES;
    yearlabel2003.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel2003.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel2003.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel2003.layer.shadowOpacity = 0.7f;
    
    yearlabel2010.layer.masksToBounds = YES;
    yearlabel2010.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel2010.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel2010.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel2010.layer.shadowOpacity = 0.7f;
    
    yearlabel2011.layer.masksToBounds = YES;
    yearlabel2011.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel2011.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel2011.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel2011.layer.shadowOpacity = 0.7f;
    
    yearlabel2012.layer.masksToBounds = YES;
    yearlabel2012.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel2012.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel2012.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel2012.layer.shadowOpacity = 0.7f;
    
    yearlabel2013.layer.masksToBounds = YES;
    yearlabel2013.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel2013.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel2013.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel2013.layer.shadowOpacity = 0.7f;
    
    yearlabel2014.layer.masksToBounds = YES;
    yearlabel2014.font = [UIFont fontWithName:@"Franchise" size:140];
    yearlabel2014.layer.shadowColor = [UIColor blackColor].CGColor;
    yearlabel2014.layer.shadowOffset = CGSizeMake(0,5);
    yearlabel2014.layer.shadowOpacity = 0.7f;
    
    //Map view corner radius
    domiyat.layer.masksToBounds = YES;
    domiyat.layer.cornerRadius = 10.0f;
    
    riyadh.layer.masksToBounds = YES;
    riyadh.layer.cornerRadius = 10.0f;

    //Get Damietta longitude and latitude
    MKCoordinateRegion damietta = {{0,0},{0,0}};
    damietta.center.latitude = 31.425947;
    damietta.center.longitude = 31.810215;
    damietta.span.latitudeDelta = 0.00795f;
    damietta.span.longitudeDelta = 0.00795f;
    [domiyat setRegion:damietta];
    
    //Get Riyadh longitude and latitude
    MKCoordinateRegion alriyadh = {{0,0},{0,0}};
    alriyadh.center.latitude = 24.674672;
    alriyadh.center.longitude = 46.695208;
    alriyadh.span.latitudeDelta = 0.009f;
    alriyadh.span.longitudeDelta = 0.009f;
    [riyadh setRegion:alriyadh];
    
    //animate year labels
    yearlabel1998.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    yearlabel2003.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    yearlabel2010.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    yearlabel2011.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    yearlabel2012.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    yearlabel2013.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    yearlabel2014.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
    angrybirdslabel.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1);
	pulseIt = [CABasicAnimation animationWithKeyPath:@"transform"];
	pulseIt.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	pulseIt.autoreverses = YES;
	pulseIt.duration = 1.5f;
    pulseIt.removedOnCompletion = NO;
	pulseIt.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseIt.repeatCount = HUGE_VAL;
    [angrybirdslabel.layer addAnimation:pulseIt forKey:@"angrybirdsanimation"];
	[yearlabel1998.layer addAnimation:pulseIt forKey:@"1998animation"];
    [yearlabel2003.layer addAnimation:pulseIt forKey:@"2003animation"];
    [yearlabel2010.layer addAnimation:pulseIt forKey:@"2010animation"];
    [yearlabel2011.layer addAnimation:pulseIt forKey:@"2011animation"];
    [yearlabel2012.layer addAnimation:pulseIt forKey:@"2012animation"];
    [yearlabel2013.layer addAnimation:pulseIt forKey:@"2013animation"];
    [yearlabel2014.layer addAnimation:pulseIt forKey:@"2014animation"];

    drawpad.hidden = YES;
    
    playoutlet.titleLabel.font = [UIFont fontWithName:@"Franchise" size:92];
    playoutlet.layer.masksToBounds = YES;
    playoutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    playoutlet.layer.shadowOffset = CGSizeMake(0,5);
    playoutlet.layer.shadowOpacity = 0.7f;
    
    youwinl.font = [UIFont fontWithName:@"Franchise" size:92];
    youwinl.layer.masksToBounds = YES;
    youwinl.layer.shadowColor = [UIColor blackColor].CGColor;
    youwinl.layer.shadowOffset = CGSizeMake(0,5);
    youwinl.layer.shadowOpacity = 0.7f;
    youwinl.hidden = YES;
    
    angrybirdslabel.font = [UIFont fontWithName:@"AngryBirds" size:30];
    angrybirdslabel.alpha = 0;
    square.hidden = YES;
    circle1.hidden = YES;
    circle2.hidden = YES;
    circle3.hidden = YES;
    circle4.hidden = YES;
    circle5.hidden = YES;
    
    [bing loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bing.com/search?q=how+to+make+an+iPhone+app"]]];
    more2012.contentSize = CGSizeMake(about2012.frame.size.width, about2012.frame.size.height+10);
    more2012.showsVerticalScrollIndicator = NO;
    about2013.contentSize = CGSizeMake(about2012.frame.size.width, about2012.frame.size.height+85);
    about2013.showsVerticalScrollIndicator = NO;
    more2014.contentSize = CGSizeMake(about2012.frame.size.width, about2012.frame.size.height+185);
    more2014.showsVerticalScrollIndicator = NO;
    
    screenshotsviewer.contentSize = CGSizeMake(self.view.frame.size.height*2, self.view.frame.size.width);
    screenshotsviewer.showsVerticalScrollIndicator = NO;
    screenshotsviewer.showsHorizontalScrollIndicator = NO;
    
    matkrscreenshots.center = CGPointMake(matkrscreenshots.center.x+7, matkrscreenshots.center.y);
    
    [about2013 setContentOffset:CGPointMake(0, 80) animated:NO];
    
    basichtml.hidden = YES;
    [basichtml loadHTMLString:@"<html><body><h1 style='font-family:Arial; text-align:center;'>Hello</h1><h2 style='color:red; text-align:center; font-family:Arial;'>I'm Ahmed Fathi</h2><h3 style='text-align:center; font-family:Arial;'>This is a basic HTML in a UIWebView</h3><button style='width:100%' onclick='alert()'>Basic Javascript</button><a href='http://apple.com/' style='margin: 0 auto; display:block; text-align:center; text-decoration:none;' onclick='alert('hey');'></a></body></html>" baseURL:nil];
    [whochat loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://whochat.me/"]]];
    stoptw.hidden = YES;
    closescreensh.alpha = 0;
    twname = 1;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(changescreenshottw) userInfo:nil repeats:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(changescreenshotmatkr) userInfo:nil repeats:YES];

    [super viewDidLoad];
}

-(void)hideitorno{
    backhide = [NSUserDefaults standardUserDefaults];
    [backhide setObject:@"" forKey:@"hideorno"];
    [backhide synchronize];
}

- (IBAction)tweaderdemo:(id)sender {
    //once user click on the button first it check if there's internet connection or not
    Reachability *reach = [Reachability reachabilityWithHostName: @"www.apple.com"];
    NetworkStatus connectedornot = [reach currentReachabilityStatus];
    switch (connectedornot)
    {
        case NotReachable:
        {
            UIAlertView *ic = [[UIAlertView alloc]initWithTitle:@"No Internet Connection" message:@"Please connect to WiFi" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ic show];
            break;
        }
            
        case ReachableViaWWAN:
        case ReachableViaWiFi:
        {
            trytw.hidden = YES;
            //then check if you're logged into your twitter account or not
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                ACAccountStore *account = [[ACAccountStore alloc] init];
                ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
                
                [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
                 {
                     //if logged in it get tweets
                     if (granted == YES){
                         
                         NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
                         
                         
                         if ([arrayOfAccounts count] > 0) {
                             
                             ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                             
                             //Get tweets from the home page (Home Timeline)
                             NSURL *requestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                             
                             NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                             
                             [parameters setObject:@"200" forKey:@"count"];
                             [parameters setObject:@"1" forKey:@"include_rts"];
                             [parameters setObject:@"true" forKey:@"exclude_replies"];
                             
                             SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPI parameters:parameters];
                             
                             posts.account = twitterAccount;
                             
                             [posts performRequestWithHandler:
                              
                              ^(NSData *response, NSHTTPURLResponse
                                *urlResponse, NSError *error)
                              {
                                  
                                  tweetsarr = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      for(int i=0; i<[tweetsarr count];i++)
                                      {
                                          NSDictionary *tweety = [tweetsarr objectAtIndex:i];
                                          //tweets only
                                          texwt = [tweety objectForKey:@"text"];
                                          //the user Name tweeted the tweet
                                          namwe = [[tweety objectForKey:@"user"] objectForKey:@"name"];
                                          NSLog(@"%@",texwt);
                                          
                                          //fill a text field with the tweets to use it as a string to read from tweets
                                          tweetscontainer.text = [tweetscontainer.text stringByAppendingFormat:@"%@.\n\n%@\n\n",[[tweety objectForKey:@"user"] objectForKey:@"name"],[tweety objectForKey:@"text"]];
                                          
                                          
                                          NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
                                          NSArray *matches = [detector matchesInString:tweetscontainer.text
                                                                               options:0
                                                                                 range:NSMakeRange(0, [tweetscontainer.text length])];
                                          //check if there is a URL or not if URL is found then replace it with ".'a link'."
                                          for (NSTextCheckingResult *match in matches) {
                                              if ([match resultType] == NSTextCheckingTypeLink) {
                                                  NSURL *url = [match URL];
                                                  checktheURL = [url absoluteString];
                                                  //replacing HTML entities with its real sign and replacing "#" with hash to be spoken while speaking tweets
                                                  
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&cent;" withString:@"¢"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&yen;" withString:@"¥"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"RT" withString:@"Re-tweeted"] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:checktheURL withString:@".'a link'."] mutableCopy];
                                                  tweetscontainer.text = [[tweetscontainer.text stringByReplacingOccurrencesOfString:@"#" withString:@"hash "]
                                                                          mutableCopy];
                                              }
                                          }
                                          
                                      }
                                      
                                      [tweetsloader reloadData];
                                  });
                              }];
                             
                         }
                         
                     } else {
                         
                         UIAlertView *la = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",[error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [la show];
                         
                     }
                     
                 }];
                
            }else{
                UIAlertView *la = [[UIAlertView alloc]initWithTitle:@"Log in" message:@"Please go to Settings > Twitter to Log in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [la show];
            }
            break;
            
        }
            
    }
}

-(void)dragging:(UIPanGestureRecognizer *)reco {
    
    CGPoint tinview = [reco translationInView:gamescreen];
    
    reco.view.center = CGPointMake(reco.view.center.x + tinview.x, reco.view.center.y + tinview.y);
    
    [reco setTranslation:CGPointMake(0, 0) inView:gamescreen];
    if(CGRectIntersectsRect(circle5.frame, square.frame)){
        [UIView animateWithDuration:0.2 animations:^(void) {
            circle5.alpha = 0;
        }];
        if(circle4.alpha == 0 && circle3.alpha == 0 && circle2.alpha == 0 && circle1.alpha == 0){
            youwinl.hidden = NO;
            square.hidden = YES;
        }
    }
    
    if(CGRectIntersectsRect(circle4.frame, square.frame)){
        [UIView animateWithDuration:0.2 animations:^(void) {
            circle4.alpha = 0;
        }];
        if(circle5.alpha == 0 && circle3.alpha == 0 && circle2.alpha == 0 && circle1.alpha == 0){
            youwinl.hidden = NO;
            square.hidden = YES;
        }
    }
    
    if(CGRectIntersectsRect(circle3.frame, square.frame)){
        [UIView animateWithDuration:0.2 animations:^(void) {
            circle3.alpha = 0;
        }];
        if(circle4.alpha == 0 && circle5.alpha == 0 && circle2.alpha == 0 && circle1.alpha == 0){
            youwinl.hidden = NO;
            square.hidden = YES;
        }
    }
    
    if(CGRectIntersectsRect(circle2.frame, square.frame)){
        [UIView animateWithDuration:0.2 animations:^(void) {
            circle2.alpha = 0;
        }];
        if(circle4.alpha == 0 && circle3.alpha == 0 && circle5.alpha == 0 && circle1.alpha == 0){
            youwinl.hidden = NO;
            square.hidden = YES;
        }
    }
    
    if(CGRectIntersectsRect(circle1.frame, square.frame)){
        [UIView animateWithDuration:0.2 animations:^(void) {
            circle1.alpha = 0;
        }];
        if(circle4.alpha == 0 && circle3.alpha == 0 && circle2.alpha == 0 && circle5.alpha == 0){
            youwinl.hidden = NO;
            square.hidden = YES;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)anyobjt withEvent:(UIEvent *)event {
    UITouch *touch = [anyobjt anyObject];
    lastloc = [touch locationInView:drawpad];
}


- (void)touchesMoved:(NSSet *)dpadtouch withEvent:(UIEvent *)event {
    UITouch *touch = [dpadtouch anyObject];
    CGPoint fingerloc = [touch locationInView:drawpad];

    CGFloat R    = rand() / (float) RAND_MAX;
    CGFloat G  = rand() / (float) RAND_MAX;
    CGFloat B   = rand() / (float) RAND_MAX;
    
    UIGraphicsBeginImageContext(drawpad.frame.size);
    CGContextRef contextref = UIGraphicsGetCurrentContext();
    [drawpad.image drawInRect:CGRectMake(0, 0, drawpad.frame.size.width, drawpad.frame.size.height)];
    CGContextSetLineCap(contextref, kCGLineCapRound);
    CGContextSetLineWidth(contextref,6);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(),[UIColor colorWithRed:R green:G blue:B alpha:1.0].CGColor);
    CGContextSetBlendMode(contextref,kCGBlendModeDarken );
    CGContextBeginPath(contextref);
    CGContextMoveToPoint(contextref, lastloc.x, lastloc.y);
    CGContextAddLineToPoint(contextref, fingerloc.x, fingerloc.y);
    CGContextStrokePath(contextref);
    drawpad.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    lastloc = [touch locationInView:drawpad];
}

- (void)touchesEnded:(NSSet *)dpadtouch withEvent:(UIEvent *)event
{
    UITouch *touch = [dpadtouch anyObject];
    lastloc = [touch locationInView:drawpad];
}

- (IBAction)goback:(id)sender {
    [bing goBack];
}

- (IBAction)goforward:(id)sender {
    [bing goForward];
}

- (IBAction)backtotm:(id)sender {
    [timer invalidate];
    timer = nil;
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *yearviewc = [main instantiateViewControllerWithIdentifier:@"timemachine"];
    yearviewc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:yearviewc animated:YES completion:NULL];
}

- (IBAction)angrybirdsac:(id)sender {
    [UIView animateWithDuration:0.2 animations:^(void) {
        angrybirdslabel.alpha = 1;
    }];
    [angrybirdsoutlet setHidden:YES];
    
}

- (IBAction)playordraw:(id)sender {
    controls = (UISegmentedControl *)sender;
    if([[controls titleForSegmentAtIndex: [controls selectedSegmentIndex]]isEqualToString:@"Play"]){
        drawpad.hidden = YES;
        gamescreen.hidden = NO;
        if(youwinl.hidden == NO){
            square.hidden = YES;
            circle1.hidden = YES;
            circle2.hidden = YES;
            circle3.hidden = YES;
            circle4.hidden = YES;
            circle5.hidden = YES;
            playoutlet.hidden = YES;
        }else{
            square.hidden = YES;
            circle1.hidden = YES;
            circle2.hidden = YES;
            circle3.hidden = YES;
            circle4.hidden = YES;
            circle5.hidden = YES;
            playoutlet.hidden = NO;
        }
    }else if ([[controls titleForSegmentAtIndex: [controls selectedSegmentIndex]]isEqualToString:@"Draw"]){
        drawpad.hidden = NO;
        gamescreen.hidden = YES;
        drawpad.image = nil;
    }
}

- (IBAction)play:(id)sender {
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [circle5 addGestureRecognizer:drag];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [circle4 addGestureRecognizer:drag];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [circle3 addGestureRecognizer:drag];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [circle2 addGestureRecognizer:drag];
    drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    [circle1 addGestureRecognizer:drag];
    playoutlet.hidden = YES;
    square.hidden = NO;
    circle1.hidden = NO;
    circle2.hidden = NO;
    circle3.hidden = NO;
    circle4.hidden = NO;
    circle5.hidden = NO;
}

- (IBAction)calcorsite:(id)sender {
    controls = (UISegmentedControl *)sender;
    if([[controls titleForSegmentAtIndex: [controls selectedSegmentIndex]]isEqualToString:@"Calculator"]){
        calcview.hidden = NO;
        basichtml.hidden = YES;
    }else if ([[controls titleForSegmentAtIndex: [controls selectedSegmentIndex]]isEqualToString:@"Website"]){
        calcview.hidden = YES;
        basichtml.hidden = NO;
    }
}

- (IBAction)cl1:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"1"];
}
- (IBAction)cl2:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"2"];
}
- (IBAction)cl3:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"3"];
}
- (IBAction)cl4:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"4"];
}
- (IBAction)cl5:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"5"];
}
- (IBAction)cl6:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"6"];
}
- (IBAction)cl7:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"7"];
}
- (IBAction)cl8:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"8"];
}
- (IBAction)cl9:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"9"];
}
- (IBAction)cl0:(id)sender{
    calcscreen.text = [calcscreen.text stringByAppendingString:@"0"];
}
- (IBAction)clplus:(id)sender{
    calcdata = [NSUserDefaults standardUserDefaults];
    [calcdata setObject:[NSString stringWithFormat:@"%@+",calcscreen.text] forKey:@"savenum"];
    calcscreen.text = @"";

}
- (IBAction)clminus:(id)sender{
    calcdata = [NSUserDefaults standardUserDefaults];
    [calcdata setObject:[NSString stringWithFormat:@"%@-",calcscreen.text] forKey:@"savenum"];
    calcscreen.text = @"";
}
- (IBAction)clmultiply:(id)sender{
    calcdata = [NSUserDefaults standardUserDefaults];
    [calcdata setObject:[NSString stringWithFormat:@"%@x",calcscreen.text] forKey:@"savenum"];
    calcscreen.text = @"";
}
- (IBAction)cldivide:(id)sender{
    calcdata = [NSUserDefaults standardUserDefaults];
    [calcdata setObject:[NSString stringWithFormat:@"%@/",calcscreen.text] forKey:@"savenum"];
    calcscreen.text = @"";
}
- (IBAction)clequal:(id)sender{
    calcdata = [NSUserDefaults standardUserDefaults];
    NSString *num = [calcdata objectForKey:@"savenum"];
    if ([num rangeOfString:@"+"].location != NSNotFound) {
        num = [num stringByReplacingOccurrencesOfString:@"+" withString:@""];
        float numadded = [num floatValue];
        float finalresult = numadded + [calcscreen.text floatValue];
        calcscreen.text = [NSString stringWithFormat:@"%f",finalresult];
    }else if ([num rangeOfString:@"-"].location != NSNotFound) {
        num = [num stringByReplacingOccurrencesOfString:@"-" withString:@""];
        float numadded = [num floatValue];
        float finalresult = numadded - [calcscreen.text floatValue];
        calcscreen.text = [NSString stringWithFormat:@"%f",finalresult];
    }else if ([num rangeOfString:@"x"].location != NSNotFound) {
        num = [num stringByReplacingOccurrencesOfString:@"x" withString:@""];
        float numadded = [num floatValue];
        float finalresult = numadded * [calcscreen.text floatValue];
        calcscreen.text = [NSString stringWithFormat:@"%f",finalresult];
    }else if ([num rangeOfString:@"/"].location != NSNotFound) {
        num = [num stringByReplacingOccurrencesOfString:@"/" withString:@""];

        if([calcscreen.text isEqualToString:@"0"]){
            UIAlertView *nodivide = [[UIAlertView alloc]initWithTitle:@"" message:@"MATH ERROR" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [nodivide show];
        }else{
            float numadded = [num floatValue];
            float finalresult = numadded / [calcscreen.text floatValue];
            calcscreen.text = [NSString stringWithFormat:@"%f",finalresult];
        }
    }else{
        calcscreen.text = @"";
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweetsarr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load tweets into a the UITableView
    UITableViewCell *cell = [tweetsloader dequeueReusableCellWithIdentifier:@"tweetcell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tweetcell"];
    }
    
    NSDictionary *tweety = [tweetsarr objectAtIndex:indexPath.row];
    NSString *text = [tweety objectForKey:@"text"];
    NSString *name = [[tweety objectForKey:@"user"] objectForKey:@"name"];
    NSArray*displayurl = [[tweety objectForKey:@"entities"]objectForKey:@"urls"];
    
    UILabel *theTweeted = (UILabel *)[cell.contentView viewWithTag:11];
    [theTweeted setText:[NSString stringWithFormat:@"%@",name]];
    
    UILabel *tweetitself = (UILabel *)[cell.contentView viewWithTag:12];
    [tweetitself setText:[NSString stringWithFormat:@"%@",text]];
    
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detector matchesInString:tweetitself.text
                                         options:0
                                           range:NSMakeRange(0, [tweetitself.text length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            checktheURL = [url absoluteString];
            for (finalurl in displayurl) {
                tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:checktheURL withString:[finalurl objectForKey:@"display_url"]] mutableCopy];
            }
        }
    }
    
    
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&cent;" withString:@"¢"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&yen;" withString:@"¥"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"] mutableCopy];
    tweetitself.text = [[tweetitself.text stringByReplacingOccurrencesOfString:@"RT" withString:@"Re-tweeted"] mutableCopy];
    UIImageView *ppd = (UIImageView *)[cell.contentView viewWithTag:14];
    ppd.layer.masksToBounds = YES;
    ppd.layer.cornerRadius = 10.0f;
    ppd.layer.borderColor = [UIColor grayColor].CGColor;
    ppd.layer.borderWidth = 0.16f;
    NSString *imageUrl = [[tweety objectForKey:@"user"] objectForKey:@"profile_image_url"];
    imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    [ppd setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"tweaderbg.png"]];
    
    NSString*username = [[tweety objectForKey:@"user"] objectForKey:@"screen_name"];
    UILabel *theusern = (UILabel *)[cell.contentView viewWithTag:19];
    [theusern setText:[NSString stringWithFormat:@"@%@",username]];
    return cell;

}
- (IBAction)readtweets:(id)sender {
    //Speak tweets using AVSpeech
    avspeechsyn = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:tweetscontainer.text];
    utterance.rate = 0.14;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"];
    [avspeechsyn speakUtterance:utterance];
    readtw.hidden = YES;
    stoptw.hidden = NO;
}

- (IBAction)stoptweets:(id)sender {
    stoptw.hidden = YES;
    readtw.hidden = NO;
    [avspeechsyn stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (IBAction)showscreenshots:(id)sender {
    [UIView animateWithDuration:0.2 animations:^(void) {
        screenshotsviewer.hidden = NO;
        screenshotsviewer.alpha = 1;
        year2014.alpha = 0;
        closescreensh.alpha = 1;
        timemachinehome.alpha = 0;
    }];
}
-(void)changescreenshottw{
    if(twname == 5){
        twname = 0;
    }
    CATransition *fadeimage = [CATransition animation];
    twname += 1;
    NSString *twsname = [NSString stringWithFormat:@"%i.png",twname];
    twscreenchots.image = [UIImage imageNamed:twsname];
    fadeimage.duration = 1.0f;
    fadeimage.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeimage.type = kCATransitionFade;
    [twscreenchots.layer addAnimation:fadeimage forKey:nil];
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

- (IBAction)closescreenshots:(id)sender {
    [UIView animateWithDuration:0.2 animations:^(void) {
        screenshotsviewer.alpha = 0;
        year2014.alpha = 1;
        closescreensh.alpha = 0;
        timemachinehome.alpha = 1;
        screenshotsviewer.hidden = YES;
    }];
}

- (IBAction)clearscreen:(id)sender{
    calcscreen.text = @"";
}
@end
