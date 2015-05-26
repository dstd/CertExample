//
//  ViewController.m
//  CertExample
//
//  Created by dstd on 26/05/15.
//  Copyright (c) 2015 stdlabs. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *requestAddress;

@end

@implementation ViewController
{
    NSURL* _baseURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _baseURL = [NSURL URLWithString:@"https://www.pcwebshop.co.uk/"];
    _requestAddress.text = [NSString stringWithFormat:@"to %@", _baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)execute:(id)sender {
    
    AFHTTPSessionManager *client = [[AFHTTPSessionManager alloc] initWithBaseURL:_baseURL];
    client.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    client.securityPolicy.allowInvalidCertificates = YES;
    client.securityPolicy.validatesDomainName = NO;
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    client.responseSerializer = responseSerializer;
    
    [client GET:@"/" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _textView.text = [NSString stringWithFormat:@"Succeeded:\n\n%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _textView.text = [NSString stringWithFormat:@"Failed:\n\n%@", error];
    }];
}

@end
