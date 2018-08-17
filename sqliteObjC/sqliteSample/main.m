//
//  main.m
//  sqliteSample
//
//  Created by Feng Qi on 8/16/18.
//  Copyright © 2018 Feng Qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "sqliteMain.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSString *homepath = NSHomeDirectory();
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//        NSString *documentDirectory = [paths objectAtIndex:0];
//        NSLog(@"Put your SQLite file books.db at %@" , documentsDirectory );
        NSString *homepath = @"/Users/fengqi/Desktop/LEARN/XCODE/iOSwithDB/Database/";
        NSLog(@"Put your SQLite file books.db at %@", homepath);
        
        NSString *src_DB = [NSString stringWithFormat:@"%@/booklist.db", homepath];
        sqliteMain *database = [[sqliteMain alloc] initWithPath: src_DB];
        
        // query table
        NSArray *result = [database performQuery:@"SELECT * FROM booklist"];
        NSLog(@"--- record in sqlite DB ---");
        for (NSArray *row in result) {
            int bookID = [[row objectAtIndex:1] intValue];
            NSString *name = [row objectAtIndex:0];
            NSLog(@"%i   :   %@ ", bookID, name);
        }
        [database closeDatabase];
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    return 0;
}
