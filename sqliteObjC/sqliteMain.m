//
//  sqliteMain.m
//  sqliteSample
//
//  Created by Feng Qi on 8/16/18.
//  Copyright © 2018 Feng Qi. All rights reserved.
//

#import "sqliteMain.h"

@implementation sqliteMain
- (id)initWithPath:(NSString *) path {
    if (self = [super init]) {
        sqlite3 *dbConnection;
        if (sqlite3_open([path UTF8String], &dbConnection) != SQLITE_OK) {
            NSLog(@"[SQLITE] can't open database!");
            return nil;
        }else {
            NSLog(@"[SQLITE] open database successfully!");
        }
        database = dbConnection;
    }
    return self;
}
- (NSArray *)performQuery:(NSString *) query {
    sqlite3_stmt *statement = nil;
    const char *sql = [query UTF8String];
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"[SQLITE] can't query data!");
    }else {
        NSMutableArray *result = [NSMutableArray array];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            // fetch each record
            NSMutableArray *row = [NSMutableArray array];
            char *name = (char *)sqlite3_column_text(statement, 0);
            id value = [NSString stringWithUTF8String:name];
            [row addObject:value];
            int bookID = sqlite3_column_int(statement, 1);
            value = [NSNumber numberWithInt:bookID];
            [row addObject:value];
            char *author = (char *)sqlite3_column_text(statement, 2);
            value = [NSString stringWithUTF8String:author];
            [row addObject:value];
            
            [result addObject:row];
        }
        // release
        sqlite3_finalize(statement);
        return result;
    }
    return nil;
}
- (void) closeDatabase {
    if (database) {
        sqlite3_close(database);
    }
}
@end
