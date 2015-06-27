//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

/*The Roman General Julius Caesar used to correspond with his generals using a secret code. He devised a way of encrypting his messages using a simple encryption scheme now known as Caesar Cipher or Shift Cipher. You can read more about it here and watch a video here
 
 You are given a class called CaesarCipher with methods encode and decode
 Being amateur codebreakers, we want to know if two distinct looking ciphers correspond to the same input message. Write a method called codeBreaker, which accepts two cipher strings as paramaters and returns a boolean value which tells us whether they are actually the same input message encoded using two different offsets. hint: the maximum offset is 25
 There are multiple ways to do this. Try to come up with as many solutions as you can.
 Example:
 okmg = "mike", offset 2
 tprl = "mike", offset 7
 
 Both are the same input message, but different offset. Your method would return YES in this case
 */

@interface CaesarCipher : NSObject

- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;

- (BOOL)codeBreakerCipher:(NSString *)cipher1 AndOtherCipher:(NSString *)cipher2;

@end


@implementation CaesarCipher

- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";
    
    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);
        
        result[i] = allchars[new_idx];
    }
    
    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}

- (BOOL)codeBreakerCipher:(NSString *)cipher1string AndOtherCipher:(NSString *)cipher2string{
    
    CaesarCipher *cipher = [[CaesarCipher alloc] init];
    
    //create an array of all the 26 possible decoded ciphers for cipher 1
    NSMutableSet *decodedCipher1array = [[NSMutableSet alloc] init]; //sets used to allow for intersectsSetFunction
    for (int i = 1; i < 26; i++) {
        [decodedCipher1array addObject:[cipher decode:cipher1string offset:i]];
    }
    
    //create an array of all the 26 possible decoded ciphers for cipher 2
    NSMutableSet *decodedCipher2array = [[NSMutableSet alloc] init];
    for (int i = 1; i < 26; i++) {
        [decodedCipher2array addObject:[cipher decode:cipher2string offset:i]];
    }

    //check if the two decoded arrays have a common element
    if ([decodedCipher1array intersectsSet:decodedCipher2array]){
        return YES;
    }
    else {
        return NO;
    }
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        NSString *word1 = @"yellow";
        NSString *word2 = @"yellow";
        
        //encoding cipher 1
        CaesarCipher *cipher1 = [[CaesarCipher alloc] init];
        NSLog(@"Word 1: %@",word1);
        NSString *encodedCipher1 = [cipher1 encode:word1 offset:4];
        NSLog(@"Cipher 1 encoded: %@",encodedCipher1);
        
        //encoding cipher 2
        CaesarCipher *cipher2 = [[CaesarCipher alloc] init];
        NSLog(@"Word 2: %@",word2);
        NSString *encodedCipher2 = [cipher2 encode:word2 offset:17];
        NSLog(@"Cipher 2 encoded: %@",encodedCipher2);
        
        BOOL C4Q =  [cipher1 codeBreakerCipher:encodedCipher1 AndOtherCipher:encodedCipher2];
        if (C4Q) {
            NSLog(@"The input messages are the same!");
        }
        else {
            NSLog(@"The input messages are NOT THE SAME.");
        }
        
        //        CaesarCipher *myCipher = [[CaesarCipher alloc] init];
        //
        //        //encodes cipher
        //        NSString *encodedCipher = [myCipher encode:@"Yes" offset:3];
        //        NSLog(@"%@",encodedCipher);
        //
        //        //decodes cipher
        //         NSString *decodedCipher = [myCipher decode:encodedCipher offset:3];
        //         NSLog(@"%@",decodedCipher);
        //
        //
        //        //decoding cipher 1
        //        NSString *decodedCipher1 = [cipher1 decode:encodedCipher1 offset:5];
        //        NSLog(@"Cipher 1 decoded: %@",decodedCipher1);
        //
        //        //decoding cipher 2
        //        NSString *decodedCipher2 = [cipher2 decode:encodedCipher2 offset:5];
        //        NSLog(@"Cipher 2 decoded: %@",decodedCipher2);
        
    }
}
