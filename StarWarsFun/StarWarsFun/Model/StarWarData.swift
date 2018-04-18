//
//  StarWarData.swift
//  StarWarsFun
//
//  Created by James H Layton on 4/17/18.
//  Copyright © 2018 james. All rights reserved.
//

import Foundation

// TODO: Could use struct
class StarWarData {
    
    private let dataObjects = ["name","gender","height","hair_color"]
    private let parse = ParseManager.shared
    
    var nextPage: String?
    var previousPage: String?
    var names = [String]()
    var genders = [String]()
    var heights = [String]()
    var hairColors = [String]()
    var peopleArr: NSArray?
    
    func removeData() {
        self.nextPage = nil
        self.previousPage = nil
        self.names.removeAll()
        self.genders.removeAll()
        self.heights.removeAll()
        self.hairColors.removeAll()
        self.peopleArr = nil
    }
    
    func parseData() {
        // Parse the array of dictionary data and store in the data model class
        self.names.append(contentsOf: self.parse.parseArrayOfDictionary(self.peopleArr!, object: self.dataObjects[0]))
        self.genders.append(contentsOf: self.parse.parseArrayOfDictionary(self.peopleArr!, object: self.dataObjects[1]))
        self.heights.append(contentsOf: self.parse.parseArrayOfDictionary(self.peopleArr!, object: self.dataObjects[2]))
        self.hairColors.append(contentsOf: self.parse.parseArrayOfDictionary(self.peopleArr!, object: self.dataObjects[3]))
    }
}
