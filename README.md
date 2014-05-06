NSMutableURLRequest+BasicAuth
==========================

An iOS Objective-C category for performing HTTP Basic Access Authentication, aka *Basic auth*.

## Why?
Most solutions for performing *Basic auth* on iOS involve the use of 3rd party Base64 libraries. Apple has provided native functions within the CFNetworking framework, removing the need for 3rd party libraries. This category wraps the solution into one clean and reusable method.

## Changelog (1.0.2)
- Thanks to [Mike Abdullah](https://github.com/mikeabdullah) for this update.
- Handled exception for username's that contain colons (e.g. `:`)
- Updated README

## Installation
### Cocoapods Installation

```
pod 'NSMutableURLRequest-BasicAuth'
```

### Manual Installation
- Add the **NSMutableURLRequest+BasicAuth** folder into your project
- Import `NSMutableURLRequest+BasicAuth.h` into your class(es).
- Import Apple's `CFNetworking` framework.

## Usage
- Create an `NSMutableURLRequest` and make sure to set the following properties:
	- `URL`
	- `HTTPMethod`
- Then, call the `basicAuthForRequest:withUsername:andPassword` method with your request.
- Afterwards, initialize your `NSURLConnection` and load your *Basic auth* request.

## Interface
``` obj-c
+ (void)basicAuthForRequest:(NSMutableURLRequest *)request withUsername:(NSString *)username andPassword:(NSString *)password;
```

## Implementation
``` obj-c
    // Cast username and password as CFStringRefs via Toll-Free Bridging
    CFStringRef usernameRef = (__bridge CFStringRef)username;
    CFStringRef passwordRef = (__bridge CFStringRef)password;
    
    // Reference properties of the NSMutableURLRequest
    CFHTTPMessageRef authoriztionMessageRef = CFHTTPMessageCreateRequest(kCFAllocatorDefault, (__bridge CFStringRef)[request HTTPMethod], (__bridge CFURLRef)[request URL], kCFHTTPVersion1_1);
    
    // Encodes usernameRef and passwordRef in Base64
    CFHTTPMessageAddAuthentication(authoriztionMessageRef, nil, usernameRef, passwordRef, kCFHTTPAuthenticationSchemeBasic, FALSE);
    
    // Creates the 'Basic - <encoded_username_and_password>' string for the HTTP header
    CFStringRef authorizationStringRef = CFHTTPMessageCopyHeaderFieldValue(authoriztionMessageRef, CFSTR("Authorization"));
    
    // Add authorizationStringRef as value for 'Authorization' HTTP header
    [request setValue:(__bridge NSString *)authorizationStringRef forHTTPHeaderField:@"Authorization"];
    
    // Cleanup
    CFRelease(authorizationStringRef);
    CFRelease(authoriztionMessageRef);
```

## Important Note
An exception is thrown if the username contains a colon (e.g. `:`).

## Created and maintained by
Created by [Arthur Ariel Sabintsev](http://www.sabintsev.com) for [ID.me, Inc.](http://www.id.me)