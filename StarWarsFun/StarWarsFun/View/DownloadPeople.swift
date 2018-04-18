//
//  DownloadPeople.swift
//  StarWarsFun
//
//  Created by James H Layton on 4/17/18.
//  Copyright © 2018 james. All rights reserved.
//

import Foundation

protocol DownloadPeopleDelegate {
    func getData(next: String?, previous: String?, people: NSArray)
}

class DownloadPeople: NSObject {
    
    private final let urlStr = "https://swapi.co/api/people/"
    
    var delegate: DownloadPeopleDelegate?
    
    private struct PeopleList {
        let count: Int
        let nextUrl: String
        let previousUrl: String
        let results: NSArray
        
        init(json: [String: Any]) {
            count = json["count"] as? Int ?? -1
            nextUrl = json["next"] as? String ?? ""
            previousUrl = json["previous"] as? String ?? ""
            results = json["results"] as? NSArray ?? [""]
        }
    }
    
    override init() {
        super.init()
        self.requestPeopleData(withUrl: nil)
    }
    
    func requestPeopleData(withUrl: String?) {
        
        var networkStr = String()
        
        if withUrl == nil {
            networkStr = self.urlStr
        }
        else {
            networkStr = withUrl!
        }
        
        NetworkManager.shared.requestDataWith(urlStr: networkStr, completion: {(data, error) in
            if let err = error {
                print(err)
            }
            else {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else {return}
                    let peoplelist = PeopleList(json: json)
                    if let del = self.delegate {
                        del.getData(next: peoplelist.nextUrl, previous: peoplelist.previousUrl, people: peoplelist.results)
                    }
                    else {
                        print("Error: Must conform to DownloadPeopleDelegate")
                    }
                } catch let jsonError {
                    print("Error with json: ", jsonError)
                }
            }
        })
    }
}
