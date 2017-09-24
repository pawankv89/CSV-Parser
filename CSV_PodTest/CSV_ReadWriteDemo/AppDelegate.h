//
//  AppDelegate.h
//  CSV_ReadWriteDemo
//
//  Created by Pawan kumar on 9/18/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

