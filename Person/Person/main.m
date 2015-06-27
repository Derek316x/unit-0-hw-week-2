//
//  main.m
//  Person
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

/* You are provided with a Person class. This class has private properties name, phoneNumber and city, along with their getter and setter methods.
 
 Write a method called checkSameCity which accepts one parameter of type Person * and checks if they live in the same city. The method should return a boolean value.
 
 A Person has recently had a child, whose name is 'Abc'. Write a method called registerChild which takes 0 parameters and returns a new Person * instance representing the child, which has the same phoneNumber and city as the parent.

*/

@interface Person : NSObject //declare methods

- (void)setCity:(NSString *)city; //setter mehtod
- (NSString *)city; //getter method. By convention, getters are named after what they get

- (void)setPhoneNumber:(NSString *)phoneNumber;
- (NSString *)phoneNumber;

- (void)setName:(NSString *)name;
- (NSString *)name;

-(void)changePersonsName:(Person *)aPerson
                  toName:(NSString *)aName;

-(BOOL)checkSameCity:(Person *)otherPerson;

-(Person *)haveChildwithName:(NSString*)name;
-(void)claimChild:(Person *)childToClaim;

@end

@implementation Person{ //define methods
    
    //by convention, instance variables (a.k.a. properties) start with underscores
    //instance methods have access to instance variables.
    //ONLY ACCESS YOUR INSTANCE VARIABLES DIRECTLY IN YOUR SETTER/GETTER METHODS
    
    NSString *_city;
    NSString *_phoneNumber;
    NSString *_name;
    NSMutableArray *_children;
}

- (void)setCity:(NSString *)city { //setter method for city
    _city = city;
}

//Q. Why use a getter?
//A. Additional level of abstraction that can be used to support conditionals on the value to be returned

- (NSString *)city { //getter method for city
    return _city;
}

- (void)setPhoneNumber:(NSString *)phoneNumber{
    _phoneNumber = phoneNumber;
}

- (NSString *)phoneNumber{
    return _phoneNumber;
}

- (void)setName:(NSString *)name{
    _name = name;
}

- (NSString *)name{
    return _name;
}

-(void)changePersonsName:(Person *)aPerson
                  toName:(NSString *)aName{
    
    [aPerson setName:aName];
}

-(BOOL)checkSameCity:(Person *)otherPerson{
    NSString *myCity = [self city];
    NSString *otherPersonCity = [otherPerson city];
    
    BOOL result = [myCity isEqualToString:otherPersonCity];
    
    return result;
}

-(Person *)haveChildwithName:(NSString*)name{
    
    Person *abc = [[Person alloc] init];
    
    [abc setName:name];
    [abc setPhoneNumber:[self phoneNumber]];
    [abc setCity:[self city]];
    
    return abc;
}

-(void)claimChild:(Person *)childToClaim{
    
    if (_children == nil) {
    _children = [[NSMutableArray alloc] init];
    }
   
    [_children addObject:childToClaim];
}

@end

// argc = number of parameters // argv[] = array of parameters
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        
        // alloc is a class method. class methods don't have access to instance variables
        Person *carl = [[Person alloc] init]; //instantiates an object
        
        //object    //message
        [carl setName:@"Carl"];
        
        [carl setCity:@"Okinawa"];
        
        [carl setPhoneNumber:@"867-5309"];
        
        NSString *carlsName = [carl name];
        NSLog(@"%@",carlsName);
        
        [carl setName:@"Steven"];
        NSLog(@"%@", [carl name]);
        
        NSLog(@"%@", [carl city]);
        [carl setCity:@"New Yawk"];
        NSLog(@"%@", [carl city]);
        
        Person *mike = [[Person alloc] init];
        
        [mike changePersonsName:carl toName:@"Carl"];
        NSLog(@"%@", [carl name]);
        
        [mike setCity:@"New Yawk"];
        
        BOOL areCitiesSame = [mike checkSameCity:carl];
        NSLog(@"%d", areCitiesSame);
        
        [carl setCity:@"Miami"];
        areCitiesSame = [mike checkSameCity:carl];
        NSLog(@"%d", areCitiesSame);
        
        Person *mikesBaby = [mike haveChildwithName:@"Chris"];
        NSLog(@"%@", [mikesBaby city]);

        //TO FIX:
        //children not being added to _children array
        [mike claimChild:mikesBaby];
        
        NSLog(@"%@", [mikesBaby city]);

    }
    return 0;
}
