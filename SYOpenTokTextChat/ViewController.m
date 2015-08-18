//
//  ViewController.m
//  SYOpenTokTextChat
//
//  Created by Rijo George on 17/08/15.
//  Copyright (c) 2015 Suyati Technologies. All rights reserved.
//

#import "ViewController.h"
#import "SYOpenTokClient.h"
#import "ChatCell.h"

static NSString *KAPI_KEY       = @"";
static NSString *KSESSION_ID    = @"";
static NSString *KSESSION_TOKEN = @"";
@interface ViewController ()<SYSessionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    SYOpenTokClient *client;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSMutableArray *chatArray;

- (IBAction)sendClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatArray = [[NSMutableArray alloc] init];
    client = [[SYOpenTokClient alloc] initWithKey:KAPI_KEY
                                        sessionId:KSESSION_ID
                                            token:KSESSION_TOKEN delegate:self];
    [self.txtMessage becomeFirstResponder];
    
}

#pragma mark - SYOpenTok Delegates

- (void)chatSessionDidConnect:(OTSession*)session{
}

- (void)chatSessionDidDisconnect:(OTSession*)session{
    
}

- (void)chatSession:(OTSession*)session didFailWithError:(OTError*)error{
    
}

- (void)chatSession:(OTSession*)session connectionCreated:(OTConnection*) connection{
    
}

- (void)chatSession:(OTSession*)session connectionDestroyed:(OTConnection*) connection{
    
}

- (void)chatSession:(OTSession*)session
 receivedSignalType:(NSString*)type
     fromConnection:(OTConnection*)connection
         withString:(NSString*)string
           isAuthor:(BOOL)isAuthor{
    string = [string stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceCharacterSet]];
    if (string.length==0)
        return;
    
    NSDictionary *dict = @{@"author":[NSNumber numberWithBool:isAuthor],@"message":string};
    [self.chatArray addObject:dict];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.chatArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - TableViewDelegates

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *chat = [self.chatArray objectAtIndex:indexPath.row];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:self options:nil];
    ChatCell *customCell = nil;
    CGSize size = [self findHeightAndWidthForText:[chat valueForKey:@"message"] font:[UIFont systemFontOfSize:17.0]];
    if([[chat valueForKey:@"author"] intValue] == 0){
        customCell = [nib objectAtIndex:0];
        [customCell.bubbleView setFrame:CGRectMake(CGRectGetMinX(customCell.bubbleView.frame), CGRectGetMinY(customCell.bubbleView.frame), size.width, size.height)];
    }
    else{
        customCell = [nib objectAtIndex:1];
        [customCell.bubbleView setFrame:CGRectMake(CGRectGetMinX(customCell.bubbleView.frame), CGRectGetMinY(customCell.bubbleView.frame), size.width, size.height)];
        CGRect frame = customCell.bubbleView.frame;
        frame.origin.x = CGRectGetWidth(customCell.frame) - CGRectGetWidth(frame)-10;
        [customCell.bubbleView setFrame:frame];
    }
    [customCell.chatLabel setText:[chat valueForKey:@"message"]];
    return customCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *chat = [self.chatArray objectAtIndex:indexPath.row];
    CGSize size = [self findHeightAndWidthForText:[chat valueForKey:@"message"] font:[UIFont systemFontOfSize:17.0]];
    return size.height+5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatArray.count;
}

- (CGSize)findHeightAndWidthForText:(NSString *)text font:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        int width_max = 250;
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(width_max, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width+30, frame.size.height + 10);
    }
    if(size.height<40)
        size.height=40;
    return size;
}

- (IBAction)sendClicked:(id)sender {
    NSString *string = [self.txtMessage.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceCharacterSet]];
    if (string.length==0)
        return;
    [client sendMessage:string withSignalType:nil toConnection:nil];
    self.txtMessage.text = @"";
}
@end
