//
//  AFSummaryVC.h
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/14/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFSummaryVC : UIViewController
{
    IBOutlet UIScrollView *summaryscroll;
    IBOutlet UIScrollView *screenshotsscroll;
    IBOutlet UILabel *aboutedu;
    IBOutlet UILabel *aboutdev;
    IBOutlet UILabel *tweaderlabel;
    IBOutlet UILabel *matkrlabel;
    IBOutlet UIImageView *matkrscreenshots;
    IBOutlet UIImageView *tweaderscreenshots;
    IBOutlet UIButton *homeoutlet;
}
- (IBAction)backtimemachine:(id)sender;
@end
