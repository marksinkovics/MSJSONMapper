//
//  MSJSONMapperTest.m
//  MSJSONMapperTest
//
//  Created by Mark Sinkovics on 3/3/13.
//  Copyright (c) 2013 Mark Sinkovics. All rights reserved.
//

#import "MSJSONMapperTest.h"
#import "Person.h"
#import "Address.h"

@implementation MSJSONMapperTest

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

- (void)testManagerInstance
{
	MSJSONMapperManager* manager1 = [MSJSONMapperManager sharedManager];
	
	MSJSONMapperManager* manager2 = [MSJSONMapperManager sharedManager];
	
	STAssertEqualObjects(manager1, manager2, @"It should be equals, because it is a singleton object");
}

- (void)testMapping
{
	NSString* jsonString = @"{\"firstName\":\"Test\", \"lastName\":\"Ester\"}";
	
	NSData* _jsonData = [[jsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	id person = [manager mapJSONData:_jsonData];
	
	STAssertTrue([person isKindOfClass:[Person class]], @"person object should be Person's object");
	
	STAssertTrue([((Person*)person).firstName isEqualToString:@"Test"], @"firstName properties should be equal with 'Test'");
	
	NSLog(@"%@", person);
}

- (void)testMappingWithMissingValue
{
	NSString* jsonString = @"{\"firstName\":\"Test\"}";
	
	NSData* _jsonData = [[jsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	id person = [manager mapJSONData:_jsonData];
	
	STAssertTrue([person isKindOfClass:[Person class]], @"person object should be Person's object");
	
	STAssertTrue([((Person*)person).firstName isEqualToString:@"Test"], @"firstName properties should be equal with 'Test'");
	
	NSLog(@"%@", person);
}

- (void)testMappingOneRelationship
{
	NSString* jsonString = @"{\"firstName\":\"Elliot\",\"lastName\":\"Reid\",\"mother\":{\"firstName\":\"Emma\",\"lastName\":\"Smith\"}}";
	
	NSData* _jsonData = [[jsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	Person *elliotReid = [manager mapJSONData:_jsonData];
	
	STAssertTrue([elliotReid isKindOfClass:[Person class]], @"person object should be Person's object");
	
	STAssertTrue([elliotReid.firstName isEqualToString:@"Elliot"], @"firstName properties should be equal with 'Test'");
	
	Person *elliotsMother = elliotReid.mother;
	
	STAssertNotNil(elliotsMother, @"Elliot should have a mother 'Emma'");
	
	STAssertTrue([elliotsMother isKindOfClass:[Person class]], @"person object should be Person's object");
	
	STAssertTrue([elliotsMother.lastName isEqualToString:@"Smith"], @"firstName properties should be equal with 'Smith'");
	
	NSLog(@"%@", elliotReid);
}

- (void)testMappingInnerArray
{
	NSString* jsonString = @"[{\"firstName\":\"Reid\"}, {\"firstName\":\"Smith\"}]";
	
	NSData* _jsonData = [[jsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	NSArray* people = [manager mapJSONData:_jsonData];
	
	STAssertNotNil(people, @"People shouldn't be nil");
	
	Person* reid = [people objectAtIndex:0];
	
	STAssertNotNil(reid, @"Reid shouldn't be nil");
	
	Person* smith = [people objectAtIndex:0];
	
	STAssertNotNil(smith, @"Smith shouldn't be nil");
	
	NSLog(@"people %@", people);
}

- (void)testMappingManyRelationship
{
	NSString* jsonString = @"{\"firstName\":\"Elliot\",\"lastName\":\"Reid\",\"addresses\":[{\"country\":\"USA\",\"town\":\"New York\",\"street\":\"23rd street\",\"houseNumber\":\"3\",\"postCode\":\"1234\"},{\"country\":\"Autralia\",\"town\":\"Sydney\",\"street\":\"Main street\",\"houseNumber\":\"6\",\"postCode\":\"09876\"}],\"mother\":{\"firstName\":\"Emma\",\"lastName\":\"Smith\"}}";
	
	NSData* _jsonData = [[jsonString dataUsingEncoding:NSUTF8StringEncoding] retain];
	
	MSJSONMapperManager* manager = [MSJSONMapperManager sharedManager];
	
	Person* elliotReid = [manager mapJSONData:_jsonData];
	
	STAssertNotNil(elliotReid, @"Person object shouldn't be nil");
	
	STAssertTrue([elliotReid isKindOfClass:[Person class]], @"person object should be Person's object");
	
	STAssertTrue([elliotReid.firstName isEqualToString:@"Elliot"], @"firstName properties should be equal with 'Test'");
	
	NSArray* addresses = elliotReid.addresses;
	
	STAssertNotNil(addresses, @"Elliot should have addresses");
	
	STAssertTrue(addresses.count == 2, @"Elliot shoud have 2 addresses");
	
	Address *address1 = [addresses objectAtIndex:0];
	
	STAssertTrue([address1.country isEqualToString:@"USA"], @"Elliot first address should be 'USA'");
	
	Address *address2 = [addresses objectAtIndex:1];
	
	STAssertTrue([address2.street isEqualToString:@"Main street"], @"Elliot second address's town should be 'Main Street'");
	
	NSLog(@"%@", elliotReid);
}


@end
