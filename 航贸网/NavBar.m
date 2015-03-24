//
//  UINavBar.m
//  LoadNibViewDemo
//
//  Created by Haven on 7/2/14.
//  Copyright (c) 2014 LF. All rights reserved.
//

#import "NavBar.h"


@implementation NavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - 定义父视图
- (void)setSuperViewController:(UIViewController *)ViewController{
    superViewController = ViewController;
}

- (IBAction)push:(id)sender {
    NSString *a = [sender currentTitle];
        NSLog(a,nil);
    [superViewController performSegueWithIdentifier:@"news" sender:self];
    
}
@end
