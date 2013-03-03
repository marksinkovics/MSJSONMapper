//
//  Address.m
//  JSONMapperApp
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import "Address.h"

@implementation Address

@synthesize country = _country;
@synthesize town = _town;
@synthesize street = _street;
@synthesize houseNumber = _houseNumber;
@synthesize postCode = _postCode;

- (NSString*)description
{
	return [NSString stringWithFormat:@"[%@] Country: %@, Town: %@, Street: %@, House number:%@, Postcode: %@", [super description], self.country, self.town, self.street, self.houseNumber, self.postCode];
}

+ (NSSet*)mappedProperties
{
	return [NSSet setWithArray:@[@"country", @"town", @"street", @"houseNumber", @"postCode"]];
}

@end
