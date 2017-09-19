//
//  CSVParser.h
//
//  Created by Pawan kumar on 9/19/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVParser : NSObject
+(CSVParser *)sharedInstance;
- (void)parseCSVIntoArrayOfDictionariesFromFile:(NSString *)path withBlock:(void (^)(NSArray *array, NSError *error))block;


@end
