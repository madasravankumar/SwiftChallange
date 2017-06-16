//
//  AirportDataManager.swift
//  AirportsChallange
//
//  Created by Kranthi Kumar on 16/06/17.
//  Copyright © 2017 com.honeywell. All rights reserved.
//

import Foundation

class AirportDataManager {
    
    private init() {
        
    }
    
    enum SQLiteError: Error {
        case OpenDatabase(message: String)
        case Prepare(message: String)
        case Step(message: String)
        case Bind(message: String)
    }
    public static let sharedInstance = AirportDataManager()
    
    
    private func getAirportDBPath() -> String {
        let bundlePath = Bundle.main.path(forResource: "navDataBase", ofType: "sqlite")
        print(bundlePath as Any )
        return bundlePath!
    }
    
    private func openDB() -> OpaquePointer {
        let filePath = getAirportDBPath()
        var db : OpaquePointer?
        
        if sqlite3_open(filePath, &db) == SQLITE_OK {
            print("Successfully Opened DB")
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
        }
        return db!
    }
    
    func getInformationfrom(tableName: String) -> Array<Any> {
        var results = [AnyObject]()
        let filePath = getAirportDBPath()
        var db: OpaquePointer?
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM Apt_info "
        
        if sqlite3_open(filePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(filePath)")
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    if tableName == "Apt_info" {
                        let dict = self.airports_Sqlite_Parse(queryStatement: queryStatement!)
                        results.append(dict as AnyObject)
                    }
                }
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
            }
            if sqlite3_finalize(queryStatement) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
            }
            if sqlite3_close(db) != SQLITE_OK {
                print("error closing database")
            }
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section:")
        }
        return results
    }
    
    private func airports_Sqlite_Parse(queryStatement: OpaquePointer) -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        let icao = String(cString: sqlite3_column_text(queryStatement, 0))
        let name = String(cString: sqlite3_column_text(queryStatement, 1))
        let iata = String(cString: sqlite3_column_text(queryStatement, 2))
        let lat = String(cString: sqlite3_column_text(queryStatement, 3))
        let lon = String(cString: sqlite3_column_text(queryStatement, 4))
        
        dict.updateValue(icao, forKey: "icao")
        dict.updateValue(name, forKey: "name")
        dict.updateValue(iata, forKey: "iata")
        dict.updateValue(lat, forKey: "lat")
        dict.updateValue(lon, forKey: "lon")
        
        return dict
    }
    

    
    
}
