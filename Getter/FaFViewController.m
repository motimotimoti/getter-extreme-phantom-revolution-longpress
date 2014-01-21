//
//  FaFViewController.m
//  Getter
//
//  Created by Yumitaka Sugimoto on 2013/12/17.
//  Copyright (c) 2013年 大坪裕樹. All rights reserved.
//

#import "FaFViewController.h"
#import "MasterViewController.h"
#import "ProfileViewController.h"
#import "DetailViewController.h"
//#import "GTMOAuthAuthentication.h"
#import "GTMOAuthViewControllerTouch.h"
#import "GTMHTTPFetcher.h"

@interface FaFViewController ()

@end

@implementation FaFViewController {
    NSMutableArray *users_data;
    NSMutableArray *next_cursor_data;
    MasterViewController *master;
    NSDictionary *fafview;
    float cellsize;
    NSMutableURLRequest *request;
    int number_count;
    int userdata_count;
    int stepcounter;
}

@synthesize followerlistFaF;
@synthesize followinglistFaF;
@synthesize username;
@synthesize authFaF;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    request = NULL;
    number_count = 1;
    stepcounter = 20;
    
    if(followerlistFaF == NULL){
        fafview = followinglistFaF;
        next_cursor_data = [fafview objectForKey:@"next_cursor"];
    }else if(followinglistFaF == NULL){
        fafview = followerlistFaF;
        next_cursor_data = [fafview objectForKey:@"next_cursor"];
    }
    NSLog (@"followerlistFaF= [%@]", followerlistFaF);
    //users_data = [followerlistFaF objectForKey:@"users"];
    NSArray *first_users = [fafview objectForKey:@"users"];
    users_data = [NSMutableArray array]; // 空の配列で初期化 
    int usize = [first_users count];
    for (int i = 0; i < usize; i++) {
        [users_data addObject:[first_users objectAtIndex:i]];
    }
    
    NSLog(@"next_cursor_data = %@",next_cursor_data);
    int size = [ users_data count ];
    NSLog(@"size = %d",size);
    /*
    for(int i = 0; i < size; i++){
        user = users_data[i];
        NSLog(@"user name = %@", [user objectForKey:@"screen_name"] );
    }
     */
    NSLog(@"%@", users_data );
    NSLog(@"start========================================================");
    for(NSString *key in [followerlistFaF objectForKey:@"users"]){
        /*
        user_data = [[followerlistFaF objectForKey:@"users"] objectForKey:key];
        NSLog(@"user name = %@", [user_data objectForKey:@"screen_name"] );
        NSLog(@"%@", key );
         */
    }
    NSLog(@"end==========================================================");
    
    NSLog(@"authFaF = %@", authFaF);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"users_data size = %d", [users_data count]);
    //return [followerlistFaF count];
    return [users_data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 対象インデックスのステータス情報を取り出す
    NSLog(@"ex size = %d", [followerlistFaF count]);
    NSDictionary *follower_status = [users_data objectAtIndex:indexPath.row];
    // ユーザ情報から screen_name を取り出して表示
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:8];
    cell.textLabel.text = [follower_status objectForKey:@"screen_name"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = [follower_status objectForKey:@"name"];
    NSURL *url = [NSURL URLWithString:[follower_status objectForKey:@"profile_image_url"]];
    NSData *Tweetdata = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:Tweetdata];
    
    return cell;
}

// 指定位置の行で使用する高さの要求
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 対象インデックスのステータス情報を取り出す
    NSDictionary *status = [users_data objectAtIndex:indexPath.row];
    
    // ツイート本文をもとにセルの高さを決定
    NSString *content = [status objectForKey:@"text"];
    CGSize labelSize = [content sizeWithFont:[UIFont systemFontOfSize:12]
                           constrainedToSize:CGSizeMake(300, 1000)
                               lineBreakMode:UILineBreakModeWordWrap];
    
    int userdata_count = [users_data count];
    cellsize = (labelSize.height + 25)*20;
    float cellsize2 = tableView.contentSize.height;
    NSLog(@"cellsize = %f",cellsize);
    NSLog(@"cellsize2 = %f",cellsize2);
    return labelSize.height + 25;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //一番下までスクロールしたかどうか
    //if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
    userdata_count =[users_data count];
    NSLog(@"********** userdata_count = %d *************@",userdata_count);
    NSLog(@"********** stepcounter = %d *************@",stepcounter);
    if( userdata_count == stepcounter)
    {
        int reqestdata_count =1;
        if (reqestdata_count == 1)
        {
            if(self.tableView.contentOffset.y >= (500*number_count - self.tableView.bounds.size.height))
            {
                //ここで次に表示する件数を取得して表示更新の処理を書けばOK
                reqestdata_count = reqestdata_count+1;
                number_count = number_count+1;
                
                NSLog(@"number_count = %d",number_count);
                NSLog(@"おいおいろえいｊふぃくぉいおｒくぇぎおｑじおｒｊくぇおいｇじぇいｑｊｒごいｑｊご");
                NSString *scname_followerlist = username;
                NSString *str_cid_followerlist = [NSString stringWithFormat:@"https://api.twitter.com/1.1/followers/list.json?screen_name=%@&cursor=%@",scname_followerlist,next_cursor_data];
                NSURL *followerurl = [NSURL URLWithString:[str_cid_followerlist stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
                
                //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:followerurl];
                request = [NSMutableURLRequest requestWithURL:followerurl];
                [request setHTTPMethod:@"GET"];
                [authFaF authorizeRequest:request];
                
                NSLog(@"request = %@", request);
                
                GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
                [fetcher beginFetchWithDelegate:self
                              didFinishSelector:@selector(homeTimelineFetcher:finishedWithData:error:)];
            }
        }
    }
    /*
    if(request == NULL){
    if(self.tableView.contentOffset.y >= (500*number_count - self.tableView.bounds.size.height))
    {
        //ここで次に表示する件数を取得して表示更新の処理を書けばOK
        number_count = number_count+1;
        NSLog(@"number_count = %d",number_count);
        NSLog(@"おいおいろえいｊふぃくぉいおｒくぇぎおｑじおｒｊくぇおいｇじぇいｑｊｒごいｑｊご");
        NSString *scname_followerlist = username;
        NSString *str_cid_followerlist = [NSString stringWithFormat:@"https://api.twitter.com/1.1/followers/list.json?screen_name=%@&cursor=%@",scname_followerlist,next_cursor_data];
        NSURL *followerurl = [NSURL URLWithString:[str_cid_followerlist stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        
        //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:followerurl];
        request = [NSMutableURLRequest requestWithURL:followerurl];
        [request setHTTPMethod:@"GET"];
        [authFaF authorizeRequest:request];
        
        NSLog(@"request = %@", request);
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher beginFetchWithDelegate:self
                      didFinishSelector:@selector(homeTimelineFetcher:finishedWithData:error:)];
    }
    }
     */
}

- (void)homeTimelineInsert:(GTMHTTPFetcher *)fetcher
           finishedWithData:(NSData *)data
                      error:(NSError *)error
{
    if (error != nil) {
        // タイムライン取得時エラー
        NSLog(@"Fetching status/home_timeline error: %d", error.code);
        return;
    }

    NSError *jsonError = nil;
    NSDictionary *followerData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:&jsonError];
    // JSONデータのパースエラー
    if (followerData == nil) {
        NSLog(@"JSON Parser error: %d", jsonError.code);
        return;
    }
}

- (void)homeTimelineFetcher:(GTMHTTPFetcher *)fetcher
           finishedWithData:(NSData *)data
                      error:(NSError *)error
{
    if (error != nil) {
        // タイムライン取得時エラー
        NSLog(@"Fetching status/home_timeline error: %d", error.code);
        return;
    }
    
    // タイムライン取得成功
    // JSONデータをパース
    NSError *jsonError = nil;
    NSDictionary *followerData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:&jsonError];
    
    // JSONデータのパースエラー
    if (followerData == nil) {
        NSLog(@"JSON Parser error: %d", jsonError.code);
        return;
    }
    
    // データを保持
    //followerlist = statuses;
    //followerlistFaF = followerData;
    NSMutableArray *temp = [followerData objectForKey:@"users"];
    int size = [temp count];
    for(int i = 0; i < size; i++){
        NSLog(@"%@",@"add");
        [users_data addObject:[temp objectAtIndex:i]];
    }
    
    next_cursor_data = [followerData objectForKey:@"next_cursor"];
    NSLog(@"~~~~~~~~~ next_cursor_data = %@ ~~~~~~~~~~",next_cursor_data);
    stepcounter = stepcounter+20;
    
    NSLog(@"%@",@"update table");
    // テーブルを更新
    
    [self.tableView reloadData];
}

@end
