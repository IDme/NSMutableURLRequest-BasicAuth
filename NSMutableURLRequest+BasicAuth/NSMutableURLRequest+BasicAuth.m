//
//  NSMutableURLRequest+BasicAuth.m
//  ID.me Scan
//
//  Created by Arthur Sabintsev on 9/9/13.
//  Copyright (c) 2013 ID.me, Inc. All rights reserved.
//

#import "NSMutableURLRequest+BasicAuth.h"

@implementation NSMutableURLRequest (BasicAuth)

+ (void)basicAuthForRequest:(NSMutableURLRequest *)request withUsername:(NSString *)username andPassword:(NSString *)password
{
    // Check for colon in username
    if ([username rangeOfString:@":"].location != NSNotFound) {
        [NSException raise:NSInvalidArgumentException format:@"Usernames for HTTP Basic Auth cannot contain a colon character: %@", username];
    }
    
    // Cast username and password as CFStringRefs via Toll-Free Bridging
    CFStringRef usernameRef = (__bridge_transfer CFStringRef)username;
    CFStringRef passwordRef = (__bridge_transfer CFStringRef)password;
    
    // Reference properties of the NSMutableURLRequest
    CFHTTPMessageRef authorizationMessageRef = CFHTTPMessageCreateRequest(kCFAllocatorDefault, (__bridge_transfer CFStringRef)[request HTTPMethod], (__bridge CFURLRef)[request URL], kCFHTTPVersion1_1);
    
    // Encodes usernameRef and passwordRef in Base64
    CFHTTPMessageAddAuthentication(authorizationMessageRef, nil, usernameRef, passwordRef, kCFHTTPAuthenticationSchemeBasic, FALSE);
    
    // Creates the 'Basic - <encoded_username_and_password>' string for the HTTP header
    CFStringRef authorizationStringRef = CFHTTPMessageCopyHeaderFieldValue(authorizationMessageRef, CFSTR("Authorization"));
    
    // Add authorizationStringRef as value for 'Authorization' HTTP header
    [request setValue:(__bridge_transfer NSString *)authorizationStringRef forHTTPHeaderField:@"Authorization"];
}

@end
