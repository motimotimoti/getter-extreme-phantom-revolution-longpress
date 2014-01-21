//
//  FaFViewController.h
//  Getter
//
//  Created by Yumitaka Sugimoto on 2013/12/17.
//  Copyright (c) 2013年 大坪裕樹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuthAuthentication.h"

@protocol FaFViewControllerDelegate;  // プロトコル先行宣言

@interface FaFViewController : UITableViewController
{
    //NSArray *followinglistFaF;
}

@property (nonatomic, retain) NSDictionary *followerlistFaF;
@property (weak, nonatomic) IBOutlet UILabel *fafusername;

@property (weak, nonatomic) IBOutlet UILabel *fafscreenname;
@property (weak, nonatomic) IBOutlet UIImageView *fafimage;
@property (nonatomic, retain) NSDictionary *followinglistFaF;
@property (nonatomic, retain) NSString *username;

@property (nonatomic, retain) GTMOAuthAuthentication *authFaF;

@end
