//
//  Person.h
//  JSONMapperApp
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJSONMapperProtocol.h"


@interface Person : NSObject <MSJSONMapperProtocol>
{
	NSString* _firstName;
	NSString* _lastName;
	Person* _mother;
	NSArray* _addresses;
}

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) Person*	mother;
@property (nonatomic, strong) NSArray*	addresses;

@end
