//
//  AFVCYears.h
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/8/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface AFVCYears : UIViewController<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIScrollView *screenshotsviewer;
    IBOutlet UIButton *stoptw;
    IBOutlet UIButton *readtw;
    IBOutlet UIButton *trytw;
    IBOutlet UITableView *tweetsloader;
    IBOutlet UILabel *about2012;
    IBOutlet UIScrollView *more2012;
    IBOutlet UIScrollView *more2014;
    IBOutlet UIWebView *bing;
    IBOutlet UIView *year1998;
    IBOutlet UIView *year2003;
    IBOutlet UIView *year2010;
    IBOutlet UIView *year2011;
    IBOutlet UIView *year2012;
    IBOutlet UIView *year2013;
    IBOutlet UIView *year2014;
    IBOutlet UILabel *yearlabel1998;
    IBOutlet UILabel *yearlabel2003;
    IBOutlet UILabel *yearlabel2010;
    IBOutlet UILabel *yearlabel2011;
    IBOutlet UILabel *yearlabel2012;
    IBOutlet UILabel *yearlabel2013;
    IBOutlet UILabel *yearlabel2014;
    IBOutlet MKMapView *domiyat;
    IBOutlet MKMapView *riyadh;
    IBOutlet UIImageView *drawpad;
    IBOutlet UIView *gamescreen;
    IBOutlet UIButton *playoutlet;
    IBOutlet UIImageView *square;
    IBOutlet UIImageView *circle1;
    IBOutlet UIImageView *circle2;
    IBOutlet UIImageView *circle3;
    IBOutlet UIImageView *circle4;
    IBOutlet UIImageView *circle5;
    IBOutlet UILabel *youwinl;
    IBOutlet UILabel *angrybirdslabel;
    IBOutlet UIButton *angrybirdsoutlet;
    IBOutlet UILabel *calcscreen;
    IBOutlet UIView *calcview;
    IBOutlet UIWebView *basichtml;
    IBOutlet UIScrollView *about2013;
    IBOutlet UIWebView *whochat;
    IBOutlet UITextView *tweetscontainer;
    IBOutlet UILabel *tweaderlabel;
    IBOutlet UILabel *matkrlabel;
    IBOutlet UIButton *timemachinehome;
    IBOutlet UIButton *closescreensh;
    IBOutlet UIImageView *twscreenchots;
    IBOutlet UIImageView *matkrscreenshots;
}
- (IBAction)goback:(id)sender;
- (IBAction)goforward:(id)sender;
- (IBAction)backtotm:(id)sender;
- (IBAction)angrybirdsac:(id)sender;
- (IBAction)playordraw:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)calcorsite:(id)sender;
- (IBAction)cl1:(id)sender;
- (IBAction)cl2:(id)sender;
- (IBAction)cl3:(id)sender;
- (IBAction)cl4:(id)sender;
- (IBAction)cl5:(id)sender;
- (IBAction)cl6:(id)sender;
- (IBAction)cl7:(id)sender;
- (IBAction)cl8:(id)sender;
- (IBAction)cl9:(id)sender;
- (IBAction)cl0:(id)sender;
- (IBAction)clplus:(id)sender;
- (IBAction)clminus:(id)sender;
- (IBAction)clmultiply:(id)sender;
- (IBAction)cldivide:(id)sender;
- (IBAction)clequal:(id)sender;
- (IBAction)clearscreen:(id)sender;
- (IBAction)readtweets:(id)sender;
- (IBAction)tweaderdemo:(id)sender;
- (IBAction)stoptweets:(id)sender;
- (IBAction)showscreenshots:(id)sender;
- (IBAction)closescreenshots:(id)sender;
-(void)hideitorno;
@end
