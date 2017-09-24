//
//  ViewController.m
//  CSV_ReadWriteDemo
//
//  Created by Pawan kumar on 9/18/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import "ViewController.h"
#import "CSVParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Read CSV File
     [self getCSVDataByHelpOfCSVParser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCSVDataByHelpOfCSVParser{
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"EmployeeRecords" ofType:@"csv"];
    
    CSVParser *csvParser = [CSVParser sharedInstance];
    [csvParser parseCSVIntoArrayOfDictionariesFromFile:file withBlock:^(NSArray *csvArray, NSError *erroe){
        
        NSLog(@"%@",csvArray);
    }];
}

@end
