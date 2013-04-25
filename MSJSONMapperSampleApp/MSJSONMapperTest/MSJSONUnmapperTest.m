//
//  MSJSONUnmapperTest.m
//  MSJSONMapperSampleApp
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import "MSJSONUnmapperTest.h"
#import "Person.h"
#import "Address.h"

@implementation MSJSONUnmapperTest

- (void)setUp
{
    [super setUp];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	[manager addTemplateWithMappedObject:[Person class]];
	
	[manager addTemplateWithMappedObject:[Address class]];
}

- (void)tearDown
{
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	[manager destroy];
    
    [super tearDown];
}

- (void)testMapping
{
	NSString* originalJsonString = @"{\"firstName\":\"Elliot\",\"lastName\":\"Reid\"}";
	
	NSData* originalJsonData = [[originalJsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	Person *elliot = [manager mapJSONData:originalJsonData];
	
	STAssertNotNil(elliot, @"Elliot object shouldn't be nil");
	
	NSData* generatedJsonData = [manager unmapObject:elliot];
	
	STAssertNotNil(generatedJsonData, @"Generated data object shouldn't be nil");
	
	NSString* generatedJsonString = [[[NSString alloc] initWithData:generatedJsonData encoding:NSUTF8StringEncoding] autorelease];
	
	STAssertTrue(originalJsonString.length == generatedJsonString.length, @"Strings should be equals.");
	
	NSLog(@"originalJsonString %@", originalJsonString);
	
	NSLog(@"generatedJsonString %@", generatedJsonString);
}

- (void)testMappingWithMissingFields
{
	NSString* originalJsonString = @"{\"lastName\":\"Reid\"}";
	
	NSData* originalJsonData = [[originalJsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	Person *elliot = [manager mapJSONData:originalJsonData];
	
	STAssertNotNil(elliot, @"Elliot object shouldn't be nil");
	
	NSData* generatedJsonData = [manager unmapObject:elliot];
	
	STAssertNotNil(generatedJsonData, @"Generated data object shouldn't be nil");
	
	NSString* generatedJsonString = [[[NSString alloc] initWithData:generatedJsonData encoding:NSUTF8StringEncoding] autorelease];
	
	STAssertTrue(originalJsonString.length == generatedJsonString.length, @"Strings should be equals.");
	
	NSLog(@"originalJsonString %@", originalJsonString);
	
	NSLog(@"generatedJsonString %@", generatedJsonString);
}

- (void)testMappingOneRelationship
{
	NSString* originalJsonString = @"{\"firstName\":\"Elliot\",\"lastName\":\"Reid\",\"mother\":{\"firstName\":\"Emma\",\"lastName\":\"Smith\"}}";
	
	NSData* originalJsonData = [[originalJsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	Person *elliot = [manager mapJSONData:originalJsonData];
	
	STAssertNotNil(elliot, @"Elliot object shouldn't be nil");
	
	STAssertNotNil(elliot.mother, @"Elliot's mother object shouldn't be nil");
	
	NSData* generatedJsonData = [manager unmapObject:elliot];
	
	STAssertNotNil(generatedJsonData, @"Generated data object shouldn't be nil");
	
	NSString* generatedJsonString = [[[NSString alloc] initWithData:generatedJsonData encoding:NSUTF8StringEncoding] autorelease];
	
	STAssertTrue(originalJsonString.length == generatedJsonString.length, @"Strings should be equals.");
	
	NSLog(@"originalJsonString %@", originalJsonString);
	
	NSLog(@"generatedJsonString %@", generatedJsonString);
}

- (void)testMappingInnerArray
{
	NSString* originalJsonString = @"[{\"firstName\":\"Reid\"},{\"firstName\":\"Smith\"}]";
	
	NSData* originalJsonData = [[originalJsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	NSArray* people = [manager mapJSONData:originalJsonData];
	
	STAssertNotNil(people, @"People shouldn't be nil");
	
	NSData* generatedJsonData = [manager unmapObject:people];
	
	STAssertNotNil(generatedJsonData, @"Generated data object shouldn't be nil");
	
	NSString* generatedJsonString = [[[NSString alloc] initWithData:generatedJsonData encoding:NSUTF8StringEncoding] autorelease];
	
	STAssertTrue(originalJsonString.length == generatedJsonString.length, @"Strings should be equals.");
	
	NSLog(@"originalJsonString %@", originalJsonString);
	
	NSLog(@"generatedJsonString %@", generatedJsonString);
}

- (void)testMappingManyRelationship
{
	NSString* originalJsonString = @"{\"firstName\":\"Elliot\",\"lastName\":\"Reid\",\"addresses\":[{\"country\":\"USA\",\"town\":\"New York\",\"street\":\"23rd street\",\"houseNumber\":\"3\",\"postCode\":\"1234\"},{\"country\":\"Autralia\",\"town\":\"Sydney\",\"street\":\"Main street\",\"houseNumber\":\"6\",\"postCode\":\"09876\"}],\"mother\":{\"firstName\":\"Emma\",\"lastName\":\"Smith\"}}";
	
	NSData* originalJsonData = [[originalJsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	Person* elliotReid = [manager mapJSONData:originalJsonData];
	
	STAssertNotNil(elliotReid, @"Person object shouldn't be nil");
	
	NSData* generatedJsonData = [manager unmapObject:elliotReid];
	
	STAssertNotNil(generatedJsonData, @"Generated data object shouldn't be nil");
	
	NSString* generatedJsonString = [[[NSString alloc] initWithData:generatedJsonData encoding:NSUTF8StringEncoding] autorelease];
	
	STAssertTrue(originalJsonString.length == generatedJsonString.length, @"Strings should be equals.");
	
	NSLog(@"originalJsonString %@", originalJsonString);
	
	NSLog(@"generatedJsonString %@", generatedJsonString);
}

@end
