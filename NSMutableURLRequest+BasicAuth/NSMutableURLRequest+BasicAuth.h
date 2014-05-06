//
//  NSMutableURLRequest+BasicAuth.h
//  ID.me Scan
//
//  Created by Arthur Sabintsev on 9/9/13.
//  Copyright (c) 2013 ID.me, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (BasicAuth)

/*!
 Fills in the `Authorization` header field for performing Basic auth.
 
 Note that Apple recommends against doing this in the latest docs. 
 The URL loading system's authentication challenge approach can't quite 
 handle this approach in some instances. You will receive an authentication 
 challenge, but any fresh credentials you supply are ignored as the existing 
 `Authorization` header appears to take precedence. Any failures have to be 
 handled specially by clients outside of the authentication challenge system.
 
 Should only be used for HTTPS URLs too, as HTTP will expose the credential for anyone to snoop.
 
 @param username The Basic auth username. Must not contain a `:` character.
 @param password The Basic auth password.
 */
+ (void)basicAuthForRequest:(NSMutableURLRequest *)request withUsername:(NSString *)username andPassword:(NSString *)password;

@end
