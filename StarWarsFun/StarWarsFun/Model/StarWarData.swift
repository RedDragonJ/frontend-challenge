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
    let dataObjects = ["name","gender","height","hair_color"]
    
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
}
