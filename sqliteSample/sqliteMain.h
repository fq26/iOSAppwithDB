//
//  sqliteMain.h
//  sqliteSample
//
//  Created by Feng Qi on 8/16/18.
//  Copyright © 2018 Feng Qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface sqliteMain : NSObject
{
    sqlite3 *database;
}
- (id)initWithPath:(NSString *)path;
- (NSArray *)performQuery:(NSString *)query;
- (void) closeDatabase;
@end
