//
//  TweetViewController.h
//  Getter
//
//  Created by 大坪裕樹 on 2013/10/22.
//  Copyright (c) 2013年 大坪裕樹. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TweetViewControllerDelegate;  // プロトコル先行宣言


@interface TweetViewController : UIViewController
{
    NSString *username;
}
@property (weak, nonatomic) id <TweetViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *username;

@end


@protocol TweetViewControllerDelegate <NSObject>

- (void)tweetViewControllerDidCancel:(TweetViewController *)viewController;

- (void)tweetViewControllerDidFinish:(TweetViewController *)viewController
                             content:(NSString *)content;

@end