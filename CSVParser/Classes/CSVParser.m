//
//  CSVParser.m
//
//  Created by Pawan kumar on 9/19/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import "CSVParser.h"

@implementation CSVParser

+(CSVParser *)sharedInstance
{
    static dispatch_once_t once;
    static CSVParser * singleton;
    dispatch_once(&once, ^ { singleton = [[CSVParser alloc] init]; });
    return singleton;
}

//Init Singaltone class
- (id)init
{
    if (self = [super init]){
    }
    return self;
}

- (NSArray *)trimComponents:(NSArray *)array withCharacters:(NSString *)characters{
    
    NSMutableArray *marray = [[NSMutableArray alloc] initWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *str = [obj stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characters]];
        str = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\"\""]] componentsJoinedByString:@""];
        
        [marray addObject:str];
    }];
    return marray;
}

- (void)parseCSVIntoArrayOfDictionariesFromFile:(NSString *)path withBlock:(void (^)(NSArray *array, NSError *error))block{
    
    NSMutableArray *arrayCSV = [[NSMutableArray alloc]init];
    NSError *err = nil;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    if (!content) return;
    NSArray *rows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    NSString *trimStr = @"\n\r ";
    NSString *character = @",";
    NSArray *keys = [self trimComponents:[[rows objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]] withCharacters:trimStr];
    
    for (int i = 1; i < rows.count; i++) {
        NSArray *objects = [self trimComponents:[[rows objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                                 withCharacters:trimStr];
        objects = [self manageArrayObjects:objects withDictionaryKeyArray:keys];
        
        if ([self rowIsBlank:objects]) {
            //Blank Data here!
        }else {
            if ([objects count] == [keys count]) {
                [arrayCSV addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
            }
        }
    }
    block(arrayCSV, err);
}

-(NSArray*)manageArrayObjects:(NSArray*)objectsArray withDictionaryKeyArray:(NSArray*)keyArray{
    
    if ([objectsArray count] < [keyArray count]) {
        NSMutableArray *objects = [[NSMutableArray alloc]initWithArray:objectsArray];
        long counterObject = [keyArray count] - [objectsArray count];
        for (int counter =0; counter < counterObject; counter++) {
            [objects addObject:@""];
        }
        return (NSArray*)objects;
    }
    return (NSArray*)objectsArray;
}
-(BOOL)rowIsBlank:(NSArray*)objectsArray{

    BOOL isBlank = YES;
    for (int counter = 0; counter < [objectsArray count]; counter++) {
        id object = [objectsArray objectAtIndex:counter];
        if (![object isEqual:@""]) {
            isBlank = NO;
        }
    }
    
    return isBlank;
}

@end
