//
//  ParseManager.swift
//  StarWarsFun
//
//  Created by James H Layton on 4/17/18.
//  Copyright © 2018 james. All rights reserved.
//

import Foundation

class ParseManager {
    static let shared = ParseManager()
    private init(){}
    
    func parseArrayOfDictionary(_ arrayData: NSArray, object: String) -> [String] {
        
        var objects = [String]()
        
        for data in arrayData {
            let dataDictionary = data as! NSDictionary
            let objectName = dataDictionary.value(forKey: object) as? String ?? ""
            objects.append(objectName)
        }
        return objects
    }
}
