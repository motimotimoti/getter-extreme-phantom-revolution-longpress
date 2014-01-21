//
//  TweetViewController.m
//  Getter
//
//  Created by 大坪裕樹 on 2013/10/22.
//  Copyright (c) 2013年 大坪裕樹. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end


@implementation TweetViewController
@synthesize textView;
@synthesize delegate;
@synthesize username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if(username != NULL){
    textView.text = [NSString stringWithFormat:@"@%@ ",username];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
    [self.delegate tweetViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [self.delegate tweetViewControllerDidFinish:self content:textView.text];
}
@end
