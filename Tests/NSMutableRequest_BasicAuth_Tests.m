//
//  NSMutableRequest_BasicAuth_Tests.m
//  NSMutableRequest+BasicAuth_Tests
//
//  Created by Mike on 19/04/2014.
//
//

#import <XCTest/XCTest.h>
#import "NSMutableURLRequest+BasicAuth.h"


@interface NSMutableRequest_BasicAuth_Tests : XCTestCase

@end

@implementation NSMutableRequest_BasicAuth_Tests

- (void)testSimpleCase
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://example.com"]];
    [NSMutableURLRequest basicAuthForRequest:request withUsername:@"Aladdin" andPassword:@"open sesame"];
	XCTAssertEqualObjects([request valueForHTTPHeaderField:@"Authorization"], @"Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==");
}

@end
