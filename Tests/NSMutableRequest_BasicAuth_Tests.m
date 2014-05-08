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
    [NSMutableURLRequest basicAuthForRequest:request withUsername:@"Aladdin" andPassword:@"Open Sesame"];
	XCTAssertEqualObjects([request valueForHTTPHeaderField:@"Authorization"], @"Basic QWxhZGRpbjpPcGVuIFNlc2FtZQ==");
}

- (void)testInvalidUsername;
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://example.com"]];
	XCTAssertThrows([NSMutableURLRequest basicAuthForRequest:request withUsername:@"Aladdin:2" andPassword:@"Open Sesame"]);
}

@end
