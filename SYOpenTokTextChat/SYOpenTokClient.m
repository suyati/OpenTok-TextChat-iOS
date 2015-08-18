//
//  SYOpenTokClient.m
//  SYOpenTokTextChat
//
//  Created by Rijo George on 17/08/15.
//  Copyright (c) 2015 Suyati Technologies. All rights reserved.
//

#import "SYOpenTokClient.h"
@interface SYOpenTokClient()<OTSessionDelegate>{
    OTSession* _session;
}

@property (nonatomic,assign) id <SYSessionDelegate>delegate;

@end

@implementation SYOpenTokClient

- (id)initWithKey:(NSString*)apiKey
        sessionId:(NSString*)sessionId
            token:(NSString*)token
         delegate:(id<SYSessionDelegate>)delegate{
    self = [super init];
    _session = [[OTSession alloc] initWithApiKey:apiKey
                                       sessionId:sessionId
                                        delegate:self];
    self.delegate = delegate;
    [self doConnect:token];
    return self;
}

- (void)doConnect:(NSString*)token{
    OTError *error = nil;
    [_session connectWithToken:token error:&error];
    if (error)
    {
        if([self.delegate respondsToSelector:@selector(chatSession:didFailWithError:)])
            [self.delegate chatSession:nil didFailWithError:error];
    }
}

- (void)sessionDidConnect:(OTSession*)session{
    if([self.delegate respondsToSelector:@selector(chatSessionDidConnect:)])
        [self.delegate chatSessionDidConnect:session];
}

- (void)sessionDidDisconnect:(OTSession*)session{
    if([self.delegate respondsToSelector:@selector(chatSessionDidDisconnect:)])
        [self.delegate chatSessionDidDisconnect:session];
}

- (void)session:(OTSession*)session didFailWithError:(OTError*)error{
    if([self.delegate respondsToSelector:@selector(chatSession:didFailWithError:)])
        [self.delegate chatSession:session didFailWithError:error];
}

- (void)session:(OTSession*)session streamCreated:(OTStream*)stream{
    
}

- (void)session:(OTSession*)session streamDestroyed:(OTStream*)stream{
    
}

- (void)  session:(OTSession*) session
connectionCreated:(OTConnection*) connection{
    if([self.delegate respondsToSelector:@selector(chatSession:connectionCreated:)])
        [self.delegate chatSession:session connectionCreated:connection];
}

- (void)    session:(OTSession*) session
connectionDestroyed:(OTConnection*) connection{
    if([self.delegate respondsToSelector:@selector(chatSession:connectionDestroyed:)])
        [self.delegate chatSession:session connectionDestroyed:connection];
}

- (void)   session:(OTSession*)session
receivedSignalType:(NSString*)type
    fromConnection:(OTConnection*)connection
        withString:(NSString*)string{
    BOOL isAuthored = NO;
    if([connection.connectionId isEqualToString:_session.connection.connectionId]){
        isAuthored = YES;
    }
    if([self.delegate respondsToSelector:@selector(chatSession:receivedSignalType:fromConnection:withString:isAuthor:)])
        [self.delegate chatSession:session receivedSignalType:type fromConnection:connection withString:string isAuthor:isAuthored];
}

- (void) sendMessage:(NSString*)string
      withSignalType:(NSString*)type
        toConnection:(OTConnection*)connection{
    OTError* errors = nil;
    [_session signalWithType:type string:string connection:connection error:&errors];
    if (!errors){
        
    }else{
        
    }
}

@end
