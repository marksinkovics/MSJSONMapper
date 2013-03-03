//
//  Address.h
//  JSONMapperApp
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJSONMapperProtocol.h"

@interface Address : NSObject <MSJSONMapperProtocol>
{
	NSString* _country;
	NSString* _town;
	NSString* _street;
	NSNumber* _houseNumber;
	NSNumber* _postCode;
}

@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* town;
@property (nonatomic, strong) NSString* street;
@property (nonatomic, strong) NSNumber* houseNumber;
@property (nonatomic, strong) NSNumber* postCode;

@end
