//
//  ViewController.swift
//  sqliteSwift
//
//  Created by Feng Qi on 8/16/18.
//  Copyright © 2018 Feng Qi. All rights reserved.
//

import UIKit
import SQLite3
class ViewController: UIViewController {
    var db: OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // .userDirectory starts from /User
        let urls = try! FileManager.default.url(for: .userDirectory, in: .localDomainMask , appropriateFor: nil, create: false)
            .appendingPathComponent("fengqi/Desktop/LEARN/XCODE/Database/booklist.db")
        
        // if database doesn't exist
        if sqlite3_open(urls.path, &db) != SQLITE_OK {
            print ("error opening")
            return
        }
        // query select operator
        let query_op = "SELECT * FROM booklist"
        // statement pointer
        var stmt : OpaquePointer?
        if sqlite3_prepare(db, query_op, -1, &stmt, nil) != SQLITE_OK {
            NSLog("[SQLite] can't query data!]")
            return;
        }
        
        // query data
        let lists = NSMutableArray()
        var idx = 0;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let row = NSMutableArray()
            let name = String(cString: sqlite3_column_text(stmt, 0))
            let bookid = sqlite3_column_int(stmt, 1)
            row.add(name)
            row.add(bookid)
            lists.add(row)
            idx += 1
        }
        print(lists)
        closeDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // close database
    func closeDatabase() {
        if db != nil {
            sqlite3_close(db)
        }
    }
}

