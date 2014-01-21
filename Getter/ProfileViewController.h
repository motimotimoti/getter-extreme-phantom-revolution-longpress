//
//  ProfileViewController.h
//  Getter
//
//  Created by Yumitaka Sugimoto on 2013/10/31.
//  Copyright (c) 2013年 大坪裕樹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMHTTPFetcher.h"
#import "GTMOAuthAuthentication.h"

@protocol ProfileViewControllerDelegate;  // プロトコル先行宣言


@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSString *username;
    NSString *name;
    UIImage *prof;
    NSString *tweets;
    NSString *following;
    NSString *followers;
    NSArray *timeline;
    UIImage *bann;
    //NSArray *followinglistPro;
}

@property (weak, nonatomic) id <ProfileViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLable;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@property (nonatomic, retain) NSString *username;

@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) UIImage *prof;

@property (nonatomic, retain) NSString *tweets;

@property (nonatomic, retain) NSString *following;

@property (nonatomic, retain) NSString *followers;

@property (nonatomic, retain) NSArray *timeline;

@property (nonatomic, retain) UIImage *bann;

@property (nonatomic, retain) NSDictionary *followerlistPro;

@property (nonatomic, retain) NSDictionary *followinglistPro;

@property (nonatomic, retain) GTMOAuthAuthentication *auth;

@end


@protocol ProfileViewControllerDelegate <NSObject>

@end