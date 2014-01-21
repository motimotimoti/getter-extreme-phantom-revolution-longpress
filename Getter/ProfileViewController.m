//
//  ProfileViewController.m
//  Getter
//
//  Created by 大坪裕樹 on 2013/10/22.
//  Copyright (c) 2013年 大坪裕樹. All rights reserved.
//

#import "MasterViewController.h"
#import "ProfileViewController.h"
#import "DetailViewController.h"
//#import "GTMOAuthAuthentication.h"
#import "GTMOAuthViewControllerTouch.h"
#import "FaFViewController.h"

@interface ProfileViewController ()

@end


@implementation ProfileViewController {
    /*// OAuth認証オブジェクト
    GTMOAuthAuthentication *auth_;
     */
    // 表示中ツイート情報
    NSArray *timelineStatuses_;
    
    NSString * uwaa;
}

//@synthesize textView;
@synthesize delegate;
@synthesize username;
@synthesize name;
@synthesize prof;
@synthesize tweets;
@synthesize following;
@synthesize followers;
@synthesize timeline;
@synthesize tableView = _tableView;
@synthesize bann;
@synthesize followerlistPro;
@synthesize followinglistPro;
@synthesize auth;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad//:(NSIndexPath *)indexPath
{
    [super viewDidLoad];
    [_profileImageView.layer setBorderWidth:4.0f];
    [_profileImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_profileImageView.layer setShadowRadius:3.0];
    [_profileImageView.layer setShadowOpacity:0.5];
    [_profileImageView.layer setShadowOffset:CGSizeMake(1.0, 0.0)];
    [_profileImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    //[self getInfo];
    
    _usernameLabel.text= [NSString stringWithFormat:@"@%@",username];
    _nameLabel.text= [NSString stringWithFormat:@"%@",name];
    _profileImageView.image = prof;
    _bannerImageView.image = bann;
    _tweetsLable.text= [NSString stringWithFormat:@"%@",tweets];
    _followingLabel.text= [NSString stringWithFormat:@"%@",following];
    _followersLabel.text= [NSString stringWithFormat:@"%@",followers];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, 320, 230) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    /*
    NSLog(@"start**************************************************************");
    NSLog(@"%@",timeline);
    NSLog(@"end****************************************************************");
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [timeline count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 対象インデックスのステータス情報を取り出す
    NSDictionary *status = [timeline objectAtIndex:indexPath.row];
    
    // ツイート本文を表示
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:8];
    cell.textLabel.text = [status objectForKey:@"text"];
    
    // ユーザ情報から screen_name を取り出して表示
    NSDictionary *user = [status objectForKey:@"user"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:6];
    cell.detailTextLabel.text = [user objectForKey:@"screen_name"];
    NSURL *url = [NSURL URLWithString:[user objectForKey:@"profile_image_url"]];
    NSData *Tweetdata = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:Tweetdata];
    //profileImage = [UIImage imageWithData:Tweetdata];
    
    //NSLog(@"%@ - %@", [status objectForKey:@"text"], [[status objectForKey:@"user"] objectForKey:@"screen_name"]);
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"follower"]) {
        FaFViewController *fafViewController = (FaFViewController*)[segue destinationViewController];
        NSLog(@"followerlistPro size = %d", [followerlistPro count]);
        fafViewController.followerlistFaF = followerlistPro;
        fafViewController.username = username;
        fafViewController.authFaF = auth;
    } else if([[segue identifier] isEqualToString:@"following"]){
        FaFViewController *fafViewController = (FaFViewController*)[segue destinationViewController];
        fafViewController.followinglistFaF = followinglistPro;
        fafViewController.username = username;
        NSLog(@"auth = %@", auth);
        fafViewController.authFaF = auth;
    }
}

@end
