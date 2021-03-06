//
//  Delete.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


struct Delete {
    fileprivate var tableClass : FFObject.Type?
    var sqlStatement : String?
    init() {
        sqlStatement = ""
        sqlStatement?.append(" delete ")
    }
 
    
    func from(_ table:FFObject.Type) -> Delete {
        var delete = self
        delete.tableClass = table
        
        delete.sqlStatement?.append(" from " + table.tableName())
        return delete
    }
    
    func whereFormat(_ condition:String) -> Delete {
        var delete = self
        delete.sqlStatement?.append(" where " + condition + " ")
        return delete
    }
    
    func execute(shouldClose:Bool = false,complete:FFDBUpdateComplete = nil) {

        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return
        }
        return FFDB.connect.executeDBUpdate(sql: sql, shouldClose: shouldClose, complete: complete)
    }
}

