//
//  SYOpenTokClient.h
//  SYOpenTokTextChat
//
//  Created by Rijo George on 17/08/15.
//  Copyright (c) 2015 Suyati Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenTok/OpenTok.h>

@protocol SYSessionDelegate <NSObject>

- (void)chatSessionDidConnect:(OTSession*)session;

- (void)chatSessionDidDisconnect:(OTSession*)session;

- (void)chatSession:(OTSession*)session didFailWithError:(OTError*)error;

- (void)chatSession:(OTSession*)session connectionCreated:(OTConnection*) connection;

- (void)chatSession:(OTSession*)session connectionDestroyed:(OTConnection*) connection;

- (void)chatSession:(OTSession*)session
 receivedSignalType:(NSString*)type
     fromConnection:(OTConnection*)connection
         withString:(NSString*)string
           isAuthor:(BOOL)isAuthor;

@end

@interface SYOpenTokClient : NSObject

- (id)initWithKey:(NSString*)apiKey
        sessionId:(NSString*)sessionId
            token:(NSString*)token
         delegate:(id<SYSessionDelegate>)delegate;

- (void) sendMessage:(NSString*)string
      withSignalType:(NSString*)type
        toConnection:(OTConnection*)connection;

@end
