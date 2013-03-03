//
//  Person.m
//  JSONMapperApp
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mother = _mother;
@synthesize addresses = _addresses;

- (NSString*)description
{
	return [NSString stringWithFormat:@"[%@] Firstname:%@, LastName: %@ \nAddresses: %@\n Mother:%@ ", [super description], self.firstName, self.lastName, self.addresses, self.mother];
}

+ (NSSet*)mappedProperties
{
	return [NSSet setWithArray:@[@"firstName", @"lastName", @"addresses", @"mother"]];
}

@end
