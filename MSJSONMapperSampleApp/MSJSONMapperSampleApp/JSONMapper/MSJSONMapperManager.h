//
//  MSJSONMapperManager.h
//  JSONMapperApp
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSJSONMapperProtocol.h"
#import "MSJSONMapEntity.h"
#import "MSJSONMapper.h"

@interface MSJSONMapperManager : NSObject
{
	NSMutableDictionary* _mappedTemplates;
}

#pragma mark - Singleton Methods

+ (MSJSONMapperManager*)sharedManager;

+ (id)createInstance;

#pragma mark - Unit Test

- (void)destroy;

#pragma mark - Instance Methods

- (void)addTemplateWithMappedObject:(Class<MSJSONMapperProtocol>)mappedClass;

- (void)addTemplateWithMappedClass:(Class)mappedClass mappedProperties:(NSSet*)mappedProperties;

- (id)mapJSONData:(NSData*)jsonData;

- (NSData*)unmapObject:(id)object;

@end
